Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753242AbWKFPhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbWKFPhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbWKFPg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:36:59 -0500
Received: from nz-out-0102.google.com ([64.233.162.194]:16389 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1753242AbWKFPg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:36:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=DiRI5W2peaKRU9uibR+LfxNWyxdYKdevPQ4GprVhOC/d507JLN99qeF0EUmEfidMsavpCUOSbgJRLhZL9wcbeokYPzM3PjkgEAECcOm+AKA1E2WXhsUJbadcvSm4Zg4hjF19petGk84t2yBaiyMl5J9+UG8DuahC0115OYf8BtU=
Message-ID: <d9a083460611060736h748c12a1s2acc00974f1dd73a@mail.gmail.com>
Date: Mon, 6 Nov 2006 16:36:55 +0100
From: Jano <jano@90-mo3-3.acn.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 837ded18284f3cbd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Recently I've downloaded and compiled kernel 2.6.18.1. After installing
modules and kernel and updating Grub I rebooted my box and tried to
launch new kernel. Everything was launching nicely, but while loading
GDM the screen went black and I was unable to switch console (using
ctrl+alt+Fn). I've rebooted using single user mode and logged in as
root. What I've discovered is the fact that I cannot mount any
filesystem from /dev/hdb. All filesystems from /dev/hda work as they
ought to, but when I try to mount something from the second hard disk I
get:

# mount -t ext3 /dev/hdb1 /home
/dev/hdb1 already mounted or /home is busy
# umount /home
/home not mounted

Here you've got my /etc/fstab:

proc            /proc           proc    defaults        0       0
/dev/hda3       /               ext3    defaults,errors=remount-ro 0
   1
/dev/hda1       /boot           ext3    defaults        0       2
/dev/hdb1       /home           ext3    defaults        0       2
/dev/hda5       /usr            ext3    defaults        0       2
/dev/hda7       none            swap    sw              0       0
/dev/hdc        /media/cdrom0   udf,iso9660 user,noauto 0       0
/dev/sda1       /media/usbdisk  vfat    user,auto       0       0

Currently I am using kernel 2.6.15 from Ubuntu repositories. All
filesystems work perfectly. Have you got any ideas what might be going
on?

Kind regards,
Jano

-- 
Mail 	jano at stepien.com.pl
Jabber 	jano at jabber.aster.pl
GG 	1894343
Web	stepien.com.pl
