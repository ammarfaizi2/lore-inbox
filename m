Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVGSS7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVGSS7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVGSS7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:59:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6082 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261680AbVGSS7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:59:13 -0400
Subject: Re: [PATCH] jsm driver - Linux-2.6.12.3
From: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk, gregkh@suse.de
In-Reply-To: <20050719184721.GA11325@mipter.zuzino.mipt.ru>
References: <1121795600.3756.25.camel@siliver.austin.ibm.com>
	 <20050719184721.GA11325@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 13:52:36 -0500
Message-Id: <1121799156.3756.33.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using RHEL4.0-U1 as the distro. Here is the info on gcc version is
3.4.3-22.1

Thanks for your feed-back.

Ananda Krishnan
On Tue, 2005-07-19 at 22:47 +0400, Alexey Dobriyan wrote:
> On Tue, Jul 19, 2005 at 12:53:20PM -0500, V. ANANDA KRISHNAN wrote:
> > This patch takes care of (1) compiler warnings which displays the mixing
> > of declarations and code
> 
> With what gcc version and what CFLAGS?
> 
> > (2) dynamic allocation of major device number
> > instead of the static number 253 (3) the version update to reflect the
> > changes in the patch.
> 
> > --- linux-2.6.12.3.orig/drivers/serial/jsm/jsm_driver.c
> > +++ linux-2.6.12.3.new/drivers/serial/jsm/jsm_driver.c
> 
> > + * CHANGE LOG:
> > + * Jul 18, 2005: Changed the major number changed to 0 to use the dynamic
> > + *	allocation of major number by OS.
> > + *
> 
> ChangeLog maintenance is the job of SCM. Don't add useless comments.
> 
> > --- linux-2.6.12.3.orig/drivers/serial/jsm/jsm_neo.c
> > +++ linux-2.6.12.3.new/drivers/serial/jsm/jsm_neo.c
> 
> > -	u8 ier = readb(&ch->ch_neo_uart->ier);
> > -	u8 efr = readb(&ch->ch_neo_uart->efr);
> > +	u8 ier, efr;
> > +	ier = readb(&ch->ch_neo_uart->ier);
> > +	efr = readb(&ch->ch_neo_uart->efr);
> 
> 

