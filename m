Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSL0G7s>; Fri, 27 Dec 2002 01:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSL0G7r>; Fri, 27 Dec 2002 01:59:47 -0500
Received: from mx11.dmz.fedex.com ([199.81.193.118]:33290 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S264795AbSL0G7r>; Fri, 27 Dec 2002 01:59:47 -0500
Date: Fri, 27 Dec 2002 15:06:01 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.5x COMMAND_LINE_SIZE cmdline problem
In-Reply-To: <200212182242.OAA03454@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.51.0212271457460.27890@boston.corp.fedex.com>
References: <200212182242.OAA03454@adam.yggdrasil.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/27/2002
 03:07:59 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 12/27/2002
 03:08:02 PM,
	Serialize complete at 12/27/2002 03:08:02 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



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

