Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSGJSd3>; Wed, 10 Jul 2002 14:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGJSd2>; Wed, 10 Jul 2002 14:33:28 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:28063 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S315182AbSGJSd1>; Wed, 10 Jul 2002 14:33:27 -0400
Date: Wed, 10 Jul 2002 13:43:45 -0500
From: Andrew Friedley <saai@swbell.net>
Subject: old/nonexistent system ioctl problem
To: linux-kernel@vger.kernel.org
Message-id: <MMEBLEKGHGAJDDEGABFIAEFCCAAA.saai@swbell.net>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I build my linux systems by compiling everything from source code.  I'm in
the process of rebuilding a system know, though ive got a weird kernel
related problem.

During bootup on the new system root, just before the kernel mounts the root
filesystem, i see the following:
Jul  9 14:30:59 thor kernel: md: swapper(pid 1) used obsolete MD ioctl,
upgrade your software to use new ictls.

This does not cause md to fail or not work, as once booted the system works
fine with no problems, except for the next error.

When i try to connect using pppd and the pppoe plugin i see this:
Jul  9 19:31:01 thor pppd[28]: Failed to negotiate PPPoE connection: 25
Inappropriate ioctl for device

I am using the same pppd binary, config, and /dev/ppp on both system.  It
works fine on the old system.

When using this very same kernel to boot my old/existing linux system, i do
not see these errors and everything works perfectly.  I compiled the kernel
using gcc 2.95.3, both the old and new system use glibc 2.2.5.  The old
system uses modutils 2.4.15 and binutils 2.12, while the new system uses
modutils 2.4.16 and binutils 2.12.1.  The kernel version is 2.4.19rc1 with
the reiserfs speedup patches for 2.4.19pre6 from namesys.com, and was
compiled on the old system.

The machine itself is a dual xeon 450 w/ 2mb cache, intel c440gx mobo, 256mb
ram, two seagate ST39103 drives and a 40gb ibm 60gxp.  The seagate drives
use the onboard aic7896 controller.

What could possibly be going wrong?  What software is the md error talking
about?

A syslog excerpt containing dmesg output and pppd log messages is at
http://saai.linuxfromscratch.org/misc/syslog
My .config for this kernel can be found at
http://saai.dyndns.org/misc/config

Thanks,

Andrew Friedley

