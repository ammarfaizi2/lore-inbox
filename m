Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVCDGSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVCDGSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVCDGSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:18:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:47780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261571AbVCDGS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:18:27 -0500
Date: Thu, 3 Mar 2005 22:17:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: chrisw@osdl.org, olof@austin.ibm.com, paulus@samba.org, rene@exactcode.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
 Altivec
Message-Id: <20050303221745.6a7ebfea.akpm@osdl.org>
In-Reply-To: <4227FADD.30905@pobox.com>
References: <422751D9.2060603@exactcode.de>
	<422756DC.6000405@pobox.com>
	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	<20050303225542.GB16886@austin.ibm.com>
	<20050303175951.41cda7a4.akpm@osdl.org>
	<20050304022424.GA26769@austin.ibm.com>
	<20050304055451.GN5389@shell0.pdx.osdl.net>
	<4227FADD.30905@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > Olof's patch is in the linux-release tree, so this brings up a point
>  > regarding merging.  If the quick fix is to be replaced by a better fix
>  > later (as in this case) there's some room for merge conflict.  Does this
>  > pose a problem for either -mm or Linus' tree?
> 
>  Just need to make sure <whomever> aware of this, when you push to Linus.
> 
>  In most cases, of dire fixes, they should just go into linux-release, 
>  and then get pulled into linux-2.6.
> 
>  For a few cases, like this one, the quick fix will hit linux-release and 
>  linux-2.6 before the better fix, so no big deal.
> 
>  In a few rare cases, you will need to create a "for-upstream" tree that 
>  handles the conflict before it get pushed to Linus.

As I say, it sounds dumb, but I'm sure you can make it work ;)

The main person it affects is yours truly:

bix:/usr/src/25> grep fix series | wc -l 
    162

And fixes which are 2.6.x.y material need to go mm->linux_release->linus. 
I drop them when they turn up in Linus's tree.

That works as long as I don't have non-linux_release patches which depend
upon earlier fixes.  If that happens I have to wait until linux-release
merges up.

Again, it's manageable, but complex.
