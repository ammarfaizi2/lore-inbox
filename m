Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSGaJ1x>; Wed, 31 Jul 2002 05:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSGaJ1x>; Wed, 31 Jul 2002 05:27:53 -0400
Received: from ns.sysgo.de ([213.68.67.98]:25842 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S317861AbSGaJ1w>;
	Wed, 31 Jul 2002 05:27:52 -0400
Date: Wed, 31 Jul 2002 11:28:26 +0200
From: Soewono Effendi <SEffendi@sysgo.de>
To: linux-kernel@vger.kernel.org
Subject: initial ramdisk + devfs
Message-Id: <20020731112826.61a75ece.SEffendi@sysgo.de>
Organization: SYSGO Real-Time Solutions GmbH
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!
 
 
 I was able to to use linux (2.4.x and 2.5.x) on a floppy with busybox using 
 this great devfs only, which saves me lots of spaces. I use the initial ram 
 disk.
 
 But since I downloaded linux-2.5.29, nothing worked anymore.
 Then I came a long about the problem with ramdisk driver and applied the 
 patch.
 To my surprise :) it worked again. I was able to boot again.
 
 As I tried to mount the boot floppy I got instead my floppy(ext2), driverfs 
 mounted??? How can that be? I'll send you my boot-floppy image, if you ask 
 me for that.
 
 ---------------------------------------------------------
 I did the following:
 
 without file system type specified:
 # mount /dev/floppy/0 /mnt
 **** driverfs is mounted instead of my ext2-floppy
 # mount
 ...
 /dev/floppy/0 on /mnt type driverfs (rw)
 
 
 
 with file system type specified: 
 # mount -t ext2 /dev/floppy/0 /mnt
 **** I got the following kernel dump
 generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
 Unable to handle kernel NULL pointer dereference at virtual address 000000a0
 ...
 ...
 
 floppy0: timeout handler died: floppy shutdown
 
 -----------------------------------------------------------
 
 I have "Kernel automounter version 4 support" compiled in.
 
 Would someone, who has enough time to "break" some linux-API behaviour, also 
 has time to notes this down!
 Maybe there should be a kind of separate "WARNING_API_CHANGED" file under 
 Documentation, so that everybody might keep up with the latest "What might 
 be broken now?".
 
 
 cheers,
 -sE
         
 -- 
 visit us at http://www.sysgo.de
