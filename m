Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317615AbSFNOmK>; Fri, 14 Jun 2002 10:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317923AbSFNOmK>; Fri, 14 Jun 2002 10:42:10 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:49592 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317616AbSFNOmE>; Fri, 14 Jun 2002 10:42:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.19 - 2.5.21 don't boot with devfs
Date: Fri, 14 Jun 2002 16:41:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: devfs@oss.sgi.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17IsGy-0003ls-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from 2.5.19 (x86), booting fails at "Checking root file system..."
if devfs is mounted; there is no problem if devfs is not mounted.  With
devfs mounted I get:

...
Checking root file system...
fsck 1.27 (8-Mar-2002)
...
fsck.ext3: No such file or directory while trying to open /dev/hda2

Here is my fstab:

# /etc/fstab: static file system information.
#
# <file system>	<mount point>	<type>	<options>			<dump>	<pass>
/dev/hda2	/		ext3	defaults,errors=remount-ro	0 1
/dev/hda3	none		swap	sw		        	0 0
/dev/hda1	/windows	vfat	defaults,user,exec		0 2
proc		/proc		proc	defaults			0 0
none    	/proc/bus/usb	usbdevfs	defaults		0 0
none		/devices	driverfs	defaults		0 0

Any ideas?

Duncan.
