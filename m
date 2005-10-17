Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVJQJnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVJQJnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVJQJnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:43:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932233AbVJQJnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:43:08 -0400
Date: Mon, 17 Oct 2005 02:42:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@virtuousgeek.org, rob@janerob.com
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Message-Id: <20051017024219.08662190.akpm@osdl.org>
In-Reply-To: <4353705D.6060809@s5r6.in-berlin.de>
References: <20051015185502.GA9940@plato.virtuousgeek.org>
	<43515ADA.6050102@s5r6.in-berlin.de>
	<20051015202944.GA10463@plato.virtuousgeek.org>
	<20051017005515.755decb6.akpm@osdl.org>
	<4353705D.6060809@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>
> Andrew Morton wrote:
> > Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> > 
> >>diff -X linux-2.6.14-rc2/Documentation/dontdiff -Naur linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c
> >>--- linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c	2005-09-19 20:00:41.000000000 -0700
> >>+++ linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c	2005-10-15 12:55:08.000000000 -0700
> [...]
> >>+module_param(toshiba, bool, 0);
> >>+MODULE_PARM_DESC(toshiba, "Toshiba Legacy-Free BIOS workaround (default=0).");
> [...]
> > It would be really really preferable if we could find some automatic way of
> > doing this.
> 
> I agree.
> 
> >  Is it possible to use DMI matching, like
> > arch/i386/kernel/acpi/sleep.c:acpisleep_dmi_table ?
> 
> Earlier forms of the patch do DMI matching:
> http://marc.theaimsgroup.com/?l=linux1394-devel&m=110790513206094
> http://www.janerob.com/rob/ts5100/tosh-1394.patch
> [short-circuited by if (1) at the second URL]

Rob, can you finish that patch off and send it?

> Of course we don't have a complete picture of which models are affected 
> though.

I suppose we could do both.  As people are found who need the module
parameter, we grab their DMI strings and add them to the table?

