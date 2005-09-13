Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVIMKlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVIMKlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVIMKlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:41:16 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:48397 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S932605AbVIMKlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:41:15 -0400
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: Mathieu Fluhr <mfluhr@nero.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
Content-Type: text/plain
Organization: Nero AG
Date: Tue, 13 Sep 2005 12:40:30 +0200
Message-Id: <1126608030.3455.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 20:34 -0700, Linus Torvalds wrote:
> Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
> and that means that the merge window is closed. I've released a 
> 2.6.14-rc1, and we're now all supposed to help just clean up and fix 
> everything, and aim for a really solid 2.6.14 release.
> 

Sorry to bother you again and again with this stuff, but I got no answer
from anyone... DVD burning is broken since 2.6.13-rc1 and I checked this
morning the 2.6.14-rc1: Same status.

To be short, when burning a DVD at 16x with 2.6.12.6, no problem at all.
With 2.6.13-rc1 and upper, lots of buffer underruns. (If someone wants
to help, feel free to ask more details... I would be happy to help
anyone). The only thing that I know is that it is not coming from the
peripheral driver, as I have the same issue when using ide-cd with a
CDROM_SEND_PACKET ioctl or usb-storage+sg with a SG_IO ioctl.

As far as I looked in the source code, it seems to be lots (and lots) of
changes between these 2 versions, specially regarding block devices
drivers. But the ChangeLog is so huge that it is quite impossible to
make a step-by-step upgrade to see _where_ the problem is :-(

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
> 
> Anybody with git can do the shortlog with
> 
> 	git-rev-list --no-merges --pretty=short v2.6.14-rc1 ^v2.6.13 |
> 		git-shortlog | less -S
> 
> which is actually pretty informative.
> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

