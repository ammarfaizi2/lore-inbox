Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUBKCOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 21:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBKCOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 21:14:53 -0500
Received: from [207.111.197.98] ([207.111.197.98]:40717 "EHLO www.igotu.com")
	by vger.kernel.org with ESMTP id S262913AbUBKCOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 21:14:51 -0500
From: "Martin Bogomolni" <martinb@www.igotu.com>
To: linux-kernel@vger.kernel.org
Reply-To: martinb@igotu.com
Subject: Kernel 2.6.2, initrd, /dev/ram
Date: Tue, 10 Feb 2004 20:45:36 -0500
Message-Id: <20040211013227.M48358@www.igotu.com>
X-Mailer: Open WebMail 2.21 20031110
X-OriginatingIP: 68.153.81.149 (martinb)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a mini-distribution that runs from CD-ROM using H Peter Anvin's 
ISOLINUX/SYSLINUX boot loader.  While upgrading it to kernel 2.6, I have 
come across a behavioral difference between 2.4 and 2.6 that may impact 
other users of the 2.6 kernel.

With kernel 2.4, to boot an initial ramdisk, I would use the following 
arguments appended to the kernel :

linux24 ramdisk_size=32000 root=/dev/ram rw 

----

With kernel 2.6, the same arguments result in an error message.  Neither 
devfs nor udev are enabled, the distribution relies on pre-created /dev 
entries in the ramdisk.

However, the kernel will boot but -not- enter the ramdisk if root=/dev/ram.  
The entry has to be changed to root=/dev/ram0 in order for a successful boot.

Why has this change of behavior occured?

Martin B.
