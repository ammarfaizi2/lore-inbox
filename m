Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUIWKyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUIWKyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUIWKye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:54:34 -0400
Received: from [193.29.205.125] ([193.29.205.125]:54762 "EHLO s1.conecto.pl")
	by vger.kernel.org with ESMTP id S268382AbUIWKyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:54:24 -0400
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Windows Logical Disk Manager error
Date: Thu, 23 Sep 2004 12:54:09 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231254.12287@senat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
while using a disc partitioned with ldm the following error occures:

sda:<6>ldm_validate_vmdb(): VMDB and TOCBLOCK don't agree on the database 
size.
[LDM] sda1 sda2 sda3 sda4

One partition is then unaccessible (though it works in windows). Kernel 
version is 2.6.8.1, but the problem also seems to appear in earlier versions.

# mount -t ntfs /dev/sda1 /mnt/d
# ls /mnt/d
ls: reading directory /mnt/d: Input/output error

# dmesg
attempt to access beyond end of device
sda1: rw=0, want=58136241, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136240.
attempt to access beyond end of device
sda1: rw=0, want=58136242, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136241.
attempt to access beyond end of device
sda1: rw=0, want=58136243, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136242.
attempt to access beyond end of device
sda1: rw=0, want=58136244, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136243.
attempt to access beyond end of device
sda1: rw=0, want=58136245, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136244.
attempt to access beyond end of device
sda1: rw=0, want=58136246, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136245.
attempt to access beyond end of device
sda1: rw=0, want=58136247, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136246.
attempt to access beyond end of device
sda1: rw=0, want=58136248, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136247.
attempt to access beyond end of device
sda1: rw=0, want=58136241, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136240.
attempt to access beyond end of device
sda1: rw=0, want=58136242, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136241.
attempt to access beyond end of device
sda1: rw=0, want=58136243, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136242.
attempt to access beyond end of device
sda1: rw=0, want=58136244, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136243.
attempt to access beyond end of device
sda1: rw=0, want=58136245, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136244.
attempt to access beyond end of device
sda1: rw=0, want=58136246, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136245.
attempt to access beyond end of device
sda1: rw=0, want=58136247, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136246.
attempt to access beyond end of device
sda1: rw=0, want=58136248, limit=54138987
NTFS-fs error (device sda1): ntfs_end_buffer_async_read(): Buffer I/O error, 
logical block 58136247.
NTFS-fs error (device sda1): ntfs_readdir(): Reading index allocation data 
failed.

-- 
mg
