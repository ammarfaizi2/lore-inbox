Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312141AbSCTUdr>; Wed, 20 Mar 2002 15:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312143AbSCTUdh>; Wed, 20 Mar 2002 15:33:37 -0500
Received: from marc1.theaimsgroup.com ([63.238.77.171]:35598 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S312141AbSCTUda>; Wed, 20 Mar 2002 15:33:30 -0500
Date: Wed, 20 Mar 2002 15:33:29 -0500
Message-Id: <200203202033.PAA18847@mailer.progressive-comp.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20 oops during fsck, mylex 352 (DAC960), CONFIG_3GB
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any known issues with 2.2's deliberately-partially-disabled 3GB
physical-RAM support (#define PAGE_OFFSET_RAW 0x40000000 in page_offset.h)
and either the DAC960 driver, or e2fsck v1.22 ?

I've ended up (because of a comedy of RMA-related errors) with 3 1GB DIMMs
for a new server, when I'd originally planned only 2.  For several reasons
I'd like to stick to 2.2 for a bit longer.  But to get 3GB support in 2.2 I
had to "complete" the CONFIG_3GB config option, and thinking that I knew
what I was doing, started smacking the box around.  Everything seemed
solid, until I killed the box with 8k NFS (I think--was getting
>10mbytes/sec writes before the lockup though :).  That's not the problem
I'm worrying about now, though :-P

Upon reboot+fsck, while I cursed myself for not yet having converted to
ext3, the box oops'ed.  It isn't local to me and doesn't have a serial
console yet, so it was rebooted w/o recording the oops info.

Now, I'm *hoping* there's a known or easily-identifiable issue with either
the DAC960 driver, or (less likely) with e2fsck, when running with
PAGE_OFFSET_RAW 0x40000000.  If so, then I'll take the doctor's advice and
won't do that.  If not, then I may have *another* problem[1].  So, someone
please tell me this is a known problem ;)  OTOH, glancing through source
for the DAC960 driver and for fsck I don't see anything that looks like it
would care about PAGE_OFFSET.  And, CONFIG_2GB seems to be solid.  Is
anyone running a similar configuration who has *not* had these problems?

[1] I will first suspect a hardware problem.  This is all for a replacement
    server to upgrade the one that runs MARC.  In the 4 months since I
    bought all the hardware, nearly half of the components--all high-end,
    supposedly high-quality, certianly expensive--have failed, or were
    simply DOA.  I hate hardware.  

Thanks,

Hank Leininger <hlein@progressive-comp.com> 
