Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264482AbRF1Vmf>; Thu, 28 Jun 2001 17:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264407AbRF1Vm0>; Thu, 28 Jun 2001 17:42:26 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59716 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S264482AbRF1VmR>; Thu, 28 Jun 2001 17:42:17 -0400
Message-Id: <200106282143.f5SLht624150@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Yaacov Akiba Slama <slamaya@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Announcing Journaled File System (JFS) release 1.0.0 available 
In-Reply-To: Message from Yaacov Akiba Slama <slamaya@yahoo.com> 
   of "Fri, 29 Jun 2001 00:12:50 +0300." <3B3B9DD2.1030103@yahoo.com> 
Date: Thu, 28 Jun 2001 16:43:55 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,

> So I only hope that the smart guys at SGI find a way to prepare the 
> patches the way Linus loves because now the file 
> "patch-2.4.5-xfs-1.0.1-core" (which contains the modifs to the kernel 
> and not the new files) is about 174090 bytes which is a lot.
> 
> YA
> 

But that is not a patch intended for Linus, it is intended to enable all
the XFS features. I have a couple of kernel patches which total 46298 bytes
which get you a working XFS filesystem in the kernel, and I could do
lots of things to make them smaller. When you hit header files in the
correct manner for different platforms the size tends to mushroom.
These lines are all in different fcntl.h files for example:

+#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    0x80000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    02000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    0x200000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    0x200000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    01000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    02000000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    0x80000 /* invisible I/O, for DMAPI/XDSM */
+#define O_INVISIBLE    02000000 /* invisible I/O, for DMAPI/XDSM */

You make the patches look a lot bigger than they really are. There is
a difference between a patch which is placing things in the correct
places and one which is designed to be as short as possible.

Steve



