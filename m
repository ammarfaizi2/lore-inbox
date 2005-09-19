Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVISUo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVISUo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbVISUo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:44:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63616 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932624AbVISUo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:44:58 -0400
Date: Mon, 19 Sep 2005 21:44:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pantelis Antoniou <pantelis@embeddedalley.com>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>
Subject: Re: [PATCH] Au1x00 8250 uart support.
Message-ID: <20050919204454.GA30041@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org,
	cw@f00f.org, Pete Popov <ppopov@embeddedalley.com>,
	Matt Porter <mporter@embeddedalley.com>
References: <200509192340.10450.pantelis@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509192340.10450.pantelis@embeddedalley.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
>  {
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +	if (up->port.iotype == UPIO_AU)
> +		offset = au_io_in_map[offset];
> +#endif

All this ifdef stuff is rather messy.  Allowing the driver to specity a map
in some structure might make more sense.

