Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315789AbSEDIyh>; Sat, 4 May 2002 04:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315791AbSEDIyg>; Sat, 4 May 2002 04:54:36 -0400
Received: from smtp3.wanadoo.nl ([194.134.35.186]:52968 "EHLO smtp3.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S315789AbSEDIyf>;
	Sat, 4 May 2002 04:54:35 -0400
Message-Id: <4.1.20020504102844.00940230@pop.cablewanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1
Date: Sat, 04 May 2002 10:49:44 +0200
To: Dave Jones <davej@suse.de>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: Linux 2.5.13-dj1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020503185811.GA4846@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

>2.5.13-dj1
>o   Back out bogus ext2_setup_super() change.
>o   IDE-49 changes.					(Martin Dalecki)
>o   IDE-50 and IDE-51.					(Martin Dalecki)

compiled ok, booted ok, but got the same problem as with 2.5.1[02]-dj1 on
my p100 (with F00F bug):

the boot process stopped after fsck of hda1 (root partition) and the
message 'hda lost interrupt' popped up every 5 sec or so.
reboot into 2.4.19-pre8 resulted in a panic due to ext2 corruption, fscking
hda1 from a rescue partition gave the message: Group descriptors look
bad... using backup 

so how can I try to find the cause of this problem??

	Rudmer

--
output of ver_linux:
Linux frodo 2.4.19-pre8 #1 Sat May 4 18:32:42 CEST 2002 i586 unknown

Gnu C                  2.95.3
Gnu make               3.77
binutils               2.11.2
usage: fdformat [ -n ] device
mount                  2.9z
modutils               2.4.13
e2fsprogs              1.27
Linux C Library        x   1 root     root      4223971 Nov  6  1999
/lib/libc.so.6
Dynamic linker (ldd)   2.1.2
Procps                 2.0.2
Net-tools              1.53
Kbd                    command
Sh-utils               2.0
Modules Loaded

output lspci:
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
00:11.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
LANCE] (rev 16)

note: the pcnet is my eth1 and is not enabled, driver is compiled as module

IDE stuff in .config:
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

