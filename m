Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRDJWGU>; Tue, 10 Apr 2001 18:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132373AbRDJWGL>; Tue, 10 Apr 2001 18:06:11 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:51207 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S132370AbRDJWGF>; Tue, 10 Apr 2001 18:06:05 -0400
Date: Tue, 10 Apr 2001 18:06:58 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>
cc: <linux-fsdevel@vger.kernel.org>
Subject: Cannot unmount ramfs after chmod
Message-ID: <Pine.LNX.4.33.0104101802080.1795-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This happens on RedHat Linux 7.0, i686 with Linux-2.4.3-ac3.
Chmod on the top-level inode of ramfs make it impossible to unmount the
filesystem.

Chmod on other files has no effect.

[root@fonzie /root]# umount t1
[root@fonzie /root]# mount -t ramfs none t1
[root@fonzie /root]# touch t1/foo
[root@fonzie /root]# umount t1
[root@fonzie /root]# mount -t ramfs none t1
[root@fonzie /root]# touch t1/foo
[root@fonzie /root]# chmod 600 t1/foo
[root@fonzie /root]# umount t1
[root@fonzie /root]# mount -t ramfs none t1
[root@fonzie /root]# chmod 600 t1
[root@fonzie /root]# umount t1
umount: /root/t1: device is busy

-- 
Regards,
Pavel Roskin

