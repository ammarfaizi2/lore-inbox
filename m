Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbULUF6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbULUF6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 00:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbULUF6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 00:58:19 -0500
Received: from tanthi.teneoris.com ([164.164.94.19]:16099 "EHLO
	tanthi.teneoris.com") by vger.kernel.org with ESMTP id S261291AbULUF6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 00:58:16 -0500
Subject: linuxrc in 2.6.7
From: Amol <amol@teneoris.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1103608125.2711.212.camel@amol.teneoris.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Dec 2004 11:18:45 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am using 2.6.7 in my embedded linux box. I start with RAMDISK as a
rootfilesystem and finally want to move the rootfile system to RAMFS (I
cannot use initramfs for some reasons). 

I used following linuxrc script. I see kernel calling do_linuxrc
function but none of the commands in the linuxrc are getting executed. 

What I am missing ??

linuxrc
--------

!/bin/busybox sh


busybox mount -t ramfs ramfs /mnt
busybox cp -a bin dev etc lib sbin usr var mnt
cd /mnt
busybox mkdir proc initrd
busybox pivot_root . initrd
busybox mount /proc /proc -t proc
busybox --install -s


echo 0x100 >/proc/sys/kernel/real-root-dev



