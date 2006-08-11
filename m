Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWHKXVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWHKXVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWHKXVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:21:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751276AbWHKXVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:21:31 -0400
Date: Fri, 11 Aug 2006 16:21:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
Message-Id: <20060811162124.66895682.akpm@osdl.org>
In-Reply-To: <1155337603.7574.61.camel@localhost.localdomain>
References: <1155334308.7574.50.camel@localhost.localdomain>
	<1155335237.3552.48.camel@mulgrave.il.steeleye.com>
	<1155335506.7574.54.camel@localhost.localdomain>
	<1155336653.3552.54.camel@mulgrave.il.steeleye.com>
	<1155337603.7574.61.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 16:06:43 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Fri, 2006-08-11 at 17:50 -0500, James Bottomley wrote:
> > > 0000:02:01.0 0100: 9005:00cf (rev 01)
> > > 0000:02:01.1 0100: 9005:00cf (rev 01)
> > 
> > OK strike that.  The aic94xx cards all have IDs like 9005:04XX
> > 
> > There does seem to be a cockup in the initialisation tables, but I can't
> > see how it could affect what you're seeing. (PCI_DEVICE() uses the .name
> > = value initialisation method and the fields following are unnamed).  Do
> > you build both of these into the kernel, and if so does it work when
> > they're both modular?
> 
> Yep, I build both of them in.  Making them both modular will require a
> wee bit more time, as the aic7xxx has my root disk on it, and I don't
> have any initrds.
> 
> In any case, I'm starting to get some funky results.  I can't get the
> problem to reappear in the tree where I was doing the bisect, but my
> development tree where I first saw it is still broken.
> 
> I'll do some more digging and get out a more reliable bug report.
> 

CONFIG_PCI_MULTITHREAD_PROBE might be implicated, if it's enabled.
