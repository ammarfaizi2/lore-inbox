Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSA0MRl>; Sun, 27 Jan 2002 07:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSA0MRc>; Sun, 27 Jan 2002 07:17:32 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:37856 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S288040AbSA0MRQ>;
	Sun, 27 Jan 2002 07:17:16 -0500
Date: Sun, 27 Jan 2002 13:17:14 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201271217.NAA27890@harpo.it.uu.se>
To: sczjd@yahoo.com
Subject: Re: issues with 2.4.18 kernel and Dell Inspiron 8000
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002 03:35:37 -0600, SI Reasoning wrote:
>On 2002-01-27 at 11:43, SI Reasoning wrote:
>> When halting my Dell Inspiron 8000, I get the power
>> off message but the laptop does not power off while
>> using the 2.4.17-10mdk kernel. Other APM related stuff is
>> a mess with this laptop also. If it suspends or does
>> any power saving features, it can not be brought back
>> up and has to be rebooted. Even worse, if I try to go
>> to bios or check the battery feature, it completely
>> locks up the computer and it has to be forcibly turned
>> off.
>> > Kernel 2.4.16-11mdk was way better. It still had the
>> suspend issue, but I could go to the bios or battery
>> display and other bios related shortcuts without
>> issue. It also powered down without issue.

If the kernel has CONFIG_SMP or CONFIG_X86_UP_APIC enabled,
then it's known Dell Inspiron bug.

A patch to fix the problem has been posted here numerous
times, but it's not yet in any standard kernel (and likely
never will be since the powers that be just toss it in
/dev/null w/o comment).

To fix it, you can either ensure that both config options
mentioned above are OFF, or you can get the following patches

patch-boot-time-ioremap-2.4.18-pre7
patch-early-dmi-scan-2.4.18-pre7
patch-dmi-apic-fixups-2.4.18-pre7

from http://www.csd.uu.se/~mikpe/linux/kernel-patches/2.4/
and apply them in the order listed.

/Mikael
