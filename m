Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWBGJuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWBGJuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWBGJuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:50:52 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:62968 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964837AbWBGJuv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:50:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KEsvhr579rHDoUIHf5jvWSdEeUHPdfPKifaw4q8qOtoSBqVsrXszxBfV72kZhJUCNMeWZt2gNwCXyTQwDHvXBf3gIV0x3Xf03dwLSZc72h9sqgP8VNr/L88vQmRMvM2CirBIeZvC7V4+JUFOEHw/Gn6CYz9mn2d+OpZdMJxeQcY=
Message-ID: <1d222adf0602070150v656f62e9g8f563ad43e9c05fe@mail.gmail.com>
Date: Tue, 7 Feb 2006 15:20:50 +0530
From: vinay hegde <vinaymh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Regarding the Linux 2.6.14-7 kernel compilation - depmod error
Cc: vinaymh@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am compiling the 2.6.14-7 kernel (from kernel.org) on Linux 2.4.20-8
i386 PC. I have used the following commands to build the kernel:- make
menuconfig, make, make install, make modules_install.

But, when "make modules_install" runs, and after creating ".ko"
modules, I get the depmod errors. Below is the partial error log:

>>>>>>>>>
#make modules_install

depmod:         fat_alloc_new_dir
depmod: *** Unresolved symbols in /lib/modules/2.6.14.7/kernel/fs/nfs/nfs.ko
.......
.......
depmod:         qword_addhex
depmod: *** Unresolved symbols in /lib/modules/2.6.14.7/kernel/fs/vfat/vfat.ko
.......
.......
<<<<<<<<

If I try to boot the newly built kernel, I get the following set of errors:

>>>>>>>>
Mounting root filesystem
mount: error 19 mounting ext3
pivotroot: pivot_root (/sysroot, /sysroot/initrd) failed: 2
umount /initrd/proc failed: 2
Freeing unused kernel memory: 236k freed
Kernel panic - not syncing: No init found. Try passing init= option to kernel.
<<<<<<<<<

Since I am using pretty old kernel (2.4.20-8), do I need to apply any
patches before building 2.6? Also, I tried with the latest version of
"module-init-tools", but it didn't help.

Can somebody help me in this regard?

Thank you,
Vinay.
