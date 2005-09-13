Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbVIMT5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbVIMT5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVIMT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:57:10 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:52100 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S932691AbVIMT5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:57:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Tue, 13 Sep 2005 21:57:11 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509132157.11722.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 13 of September 2005 05:34, Linus Torvalds wrote:
> 
> Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
> and that means that the merge window is closed. I've released a 
> 2.6.14-rc1, and we're now all supposed to help just clean up and fix 
> everything, and aim for a really solid 2.6.14 release.
> 
> Both the diffstat and the shortlog are so big that I can't post them on 
> the kernel mailing list without getting the email killed by the size 
> restrictions, so there's not a lot to say. 
> 
> alpha, arm, x86, x86-64, ppc, ia64, mips, sparc, um.. Pretty much every
> architecture got some updates. And an absolutely _huge_ ACPI diff, largely 
> because of some re-indentation.
> 
> drm, watchdog, hwmon, i2c, infiniband, input layer, md, dvb, v4l, network,
> pci, pcmcia, scsi, usb and sound driver updates. People may appreciate
> that the most common wireless network drivers got merged - centrino
> support is now in the standard kernel.
> 
> On the filesystem level, FUSE got merged, and ntfs and xfs got updated. In 
> the core VFS layer, the "struct files" thing is now handled with RCU and 
> has less expensive locking.
> 
> And networking changes.
> 
> In other words, a lot of stuff all over the place. Be nice now, and follow 
> the rules: put away the new toys, and instead work on making sure the 
> stuff that got merged is all solid. Ok?

My AMD64-based box (Asus L5D) does not resume from disk on battery power
any more, even if booted with init=/bin/bash.

I think this is related to Bug #4959, which remains a mistery, but now it
also does not resume with CONFIG_DEBUG_SLAB unset.

Andi, is it possible that an MCE occurs when the image is copied (ie. while
the code in arch/x86_64/kernel/suspend_asm.S is being executed)?

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
