Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVBYMem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVBYMem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 07:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVBYMem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 07:34:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62640 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262686AbVBYMek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 07:34:40 -0500
Subject: Re: [PATCH] vsprintf.c cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <421F19E4.10600@didntduck.org>
References: <200502250059.j1P0xbDU006504@laptop11.inf.utfsm.cl>
	 <421F19E4.10600@didntduck.org>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 13:34:27 +0100
Message-Id: <1109334867.6290.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 07:28 -0500, Brian Gerst wrote:
> Horst von Brand wrote:
> > Brian Gerst <bgerst@didntduck.org> said:
> > 
> >>- Make sprintf call vsnprintf directly
> >>- use INT_MAX for sprintf and vsprintf
> > 
> > 
> > This is the size limit on what is written. 4GiB sounds a bit extreme...
> 
> Sprintf has no limit, which is why it's generally bad to use it.  I just 
> replaced an open coded ((~0U)>>1) value with the equivalent INT_MAX.

I can see the point of using PAGE_SIZE instead; and if someone really
wants more than that, he/she should use snprintf with a specified
size....



