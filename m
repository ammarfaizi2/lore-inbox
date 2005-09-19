Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVISUvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVISUvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVISUvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:51:37 -0400
Received: from smtp102.biz.mail.re2.yahoo.com ([68.142.229.216]:16979 "HELO
	smtp102.biz.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932237AbVISUvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:51:37 -0400
From: Pantelis Antoniou <pantelis@embeddedalley.com>
Reply-To: pantelis@embeddedalley.com
Organization: EASI
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Au1x00 8250 uart support.
Date: Mon, 19 Sep 2005 23:53:34 +0300
User-Agent: KMail/1.8
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>
References: <200509192340.10450.pantelis@embeddedalley.com> <20050919204454.GA30041@infradead.org>
In-Reply-To: <20050919204454.GA30041@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509192353.35427.pantelis@embeddedalley.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 September 2005 23:44, Christoph Hellwig wrote:
> >  static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
> >  {
> > +#ifdef CONFIG_SERIAL_8250_AU1X00
> > +	if (up->port.iotype == UPIO_AU)
> > +		offset = au_io_in_map[offset];
> > +#endif
> 
> All this ifdef stuff is rather messy.  Allowing the driver to specity a map
> in some structure might make more sense.
> 
> 

Sure, I can do that.

But the check for the map existence will take a couple of instructions then,
for all architectures. If you're fine with that, it'd be no problem.

Regards

Pantelis
