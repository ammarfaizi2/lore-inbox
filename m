Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbSL3NKb>; Mon, 30 Dec 2002 08:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbSL3NKa>; Mon, 30 Dec 2002 08:10:30 -0500
Received: from mx15.sac.fedex.com ([199.81.197.54]:64520 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S266975AbSL3NK0>; Mon, 30 Dec 2002 08:10:26 -0500
Date: Mon, 30 Dec 2002 21:16:47 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.5x COMMAND_LINE_SIZE cmdline problem (fwd)
Message-ID: <Pine.LNX.4.51.0212302115480.2140@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/30/2002
 09:18:45 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/30/2002
 09:18:48 PM,
	Serialize complete at 12/30/2002 09:18:48 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone out there having this problem...

Thanks,
Jeff
[ jchua@fedex.com ]

---------- Forwarded message ----------
Date: Fri, 27 Dec 2002 15:06:01 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.5x COMMAND_LINE_SIZE cmdline problem



When booting the kernel with a long command line arguments, the kernel
will hang under 2.5.52, 2.5.53. Short command line is ok. 2.5.51 is ok.

# cat /proc/cmdline
root=/dev/hda2 ro reboot=hard hostname=boston.corp.fedex.com master=hda
network=none nssdns=0 apm=1 gpm=1 pccards=2 dma=1 lvm=1 reiser=1
modules="dm-mod ide-disk ide-probe-mod" /d /k autoexec BOOT_IMAGE=bzc1

I've tried both loadlin and linld with the same result.

It seems that COMMAND_LINE_SIZE is defined at several places with
different values ...

./arch/sh/kernel/setup.c
./arch/um/kernel/user_util.c
./arch/i386/kernel/setup.c
./include/asm-i386/setup.h


Thanks,
Jeff.

