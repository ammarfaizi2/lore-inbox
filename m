Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317783AbSGPIWs>; Tue, 16 Jul 2002 04:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSGPIWr>; Tue, 16 Jul 2002 04:22:47 -0400
Received: from pop.gmx.de ([213.165.64.20]:25540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317783AbSGPIWr>;
	Tue, 16 Jul 2002 04:22:47 -0400
Message-ID: <002c01c22ca2$bb80a6d0$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Tom Oehser" <tom@toms.net>
Cc: "Daniel Phillips" <phillips@arcor.de>,
       "Ville Herva" <vherva@niksula.hut.fi>,
       "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207150807450.9793-100000@conn6m.toms.net>
Subject: [PATCH] bzip2 compression for kernel 2.4 and ramdisk
Date: Tue, 16 Jul 2002 10:28:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have released the new version 1.4 of the bzip2 support patch.
You can find it at http://chrissicool.piranho.com/linux (sorry for the ads.)

This patch consists actually of two independant parts, which do _not_ belong
together in any case. The only reason why they cannot be split up is that
both are using the same decompression code for bzip2 at the same location.
The two parts are:

1. A kernel bzip2 compression support patch.
The kernel will be compressed with bzip2, if you choose the appropriate
option in the "General options" menu of the kernel configuration. Choosing
gzip compression is still possible. You can also choose the compression
level in nine steps, from very poor compression (level 1), which is not very
memory and speed intensive. A very strong compression (level 9) makes the
bzImage smaller, but uses a large amount of RAM for decompression and takes
longer. This part is architecture dependent and was implemented for i386
based PCs.

2. A ramdisk bzip2 compression support patch.
You can enable gzip or bzip2 compression (or even both) for the ramdisk in
the kernel configuration. The ramdisk driver will test the image, which
should be loaded. If it recognises a valid (and supported) ramdisk image, it
will load and decompress it. The ramdisk compression is optional. You even
can turn off compressed ramdisk support at all.

If you find bugs, please mail me.

Have fun.

    - Christian Ludwig


