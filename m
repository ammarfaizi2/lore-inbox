Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTDNOK6 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTDNOK6 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:10:58 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:5046 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263018AbTDNOK4 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 10:10:56 -0400
Date: Mon, 14 Apr 2003 16:22:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Bourne <jbourne@hardrock.org>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030414142235.GC10347@wohnheim.fh-wedel.de>
References: <20030414134603.GB10347@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0304140748040.22450-100000@cafe.hardrock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0304140748040.22450-100000@cafe.hardrock.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 07:56:45 -0600, James Bourne wrote:
> On Mon, 14 Apr 2003, Jörn Engel wrote:
> > On Mon, 14 April 2003 07:34:54 -0600, James Bourne wrote:
> > > 
> > > This patch has also been added to the update patch available at
> > > http://www.hardrock.org/kernel/current-updates/linux-2.4.20-updates.patch
> > > 
> > > This patch includes the ptrace patch, tg3 patch, and ext3 patches.  It also
> > > changes the EXTRAVERSION to -uv2.
> > 
> > Privately, I have introduced a variable FIXLEVEL for this. The
> > resulting kernel version is 2.4.20.2 instead of 2.4.20-uv2, which imo
> > is more suiting for a fixed stable kernel.
> > 
> > Are you interested in this patch?
> 
> Sure, if you have the patch already please send it along.  I think this was
> suggested once before as well.

Must have lost it, but it was simple to recreate. :)

The fixlevel must also include the leading dot, so it will fold into
nothing for normal (non-fixed) kernels.

Marcelo, would/should this be included in Mainline as well?

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy

--- linux-2.4.20/Makefile~FIXLEVEL	2002-11-29 00:53:16.000000000 +0100
+++ linux-2.4.20/Makefile	2003-04-14 16:14:18.000000000 +0200
@@ -1,9 +1,10 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 20
+FIXLEVEL =
 EXTRAVERSION =
 
-KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(FIXLEVEL)$(EXTRAVERSION)
 
 ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
 KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")
