Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRGHK1U>; Sun, 8 Jul 2001 06:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266830AbRGHK1K>; Sun, 8 Jul 2001 06:27:10 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:19842 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261173AbRGHK1A>; Sun, 8 Jul 2001 06:27:00 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 8 Jul 2001 03:26:48 -0700
Message-Id: <200107081026.DAA22119@baldur.yggdrasil.com>
To: rjd@xyzzy.clara.co.uk
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
Cc: jun1m@mars.dti.ne.jp, linux-kernel@vger.kernel.org, m.ashley@unsw.edu.au,
        stelian.pop@fr.alcove.com, t-kinjo@tc4.so-net.ne.jp,
        tridge@valinux.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
>Hi,

>First off, it works for me on my VAIO PCG-Z600NE.

	Great.  Thanks for testing it!

[...]
>Just a niggle however. This still isn't a very good test to finding a
>Sony laptop. What'll happen on machines that have any sort of Sony
>plugin device ?

>How's about we test for a machine that has a host bridge with the Sony
>subvendor ID, rather than any device.

	On my Sony Vaio C1VN PictureBook, the host bridge subsystem
vendor ID is Transmeta, not Sony.  The device with the Sony subsystem
vendor ID are the firewire controller, sound devices, soft modem,
cardbus bridge and video.  So, you could would not work on it (although
I did not actually try it).

>I guess this'll still pickup Sony desktops.

	Sony desktops are also called "Vaio."  I do not know whether
they have the hardware that sonypi tries to talk to.


>Perhaps we need a survey of lspci -nv results for sony and non-sony
>machines ?

	Yes, although that is a task that is never complete.  So, I
would recommend that we adopt a simple test that should work into the
stock kernels with the expectation that the test will probably be
refined in the future.  Perhaps we could check the Cardbus bridge.
Does "lspci -v" on your Sony Vaio indicate that its cardbus bridge
have a subsystem vendor ID of Sony?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
