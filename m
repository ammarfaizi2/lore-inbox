Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWBKAcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWBKAcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWBKAcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:32:08 -0500
Received: from mail.usfltd.com ([69.222.0.23]:29194 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S932273AbWBKAcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:32:07 -0500
Date: Fri, 10 Feb 2006 18:30:36 -0600
Message-Id: <200602101830.AA329122124@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <reiser@namesys.com>
Subject: kernel-2.6.16-rc2-git8 - reiserfs 3.6 - write problem !!!
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-2.6.16-rc2-git8 - reiserfs - write problem !!!

it started ~from kernel-2.6.16-rc2
2.6.16-rc1-git6 works ok

with 2.6.16-rc2-git8
--reiserfs is 3.6 on ide hdd mounted on /mnt on scsi-hdd with ext3 on it--
mount
/dev/hda1 on /mnt/mountpoint-reiserfs type reiserfs (rw)
/dev/sdb1 on /mnt/mountpoint-ext3 type ext3 (rw)

[bebe@localhost mnt]$ ls -l -Z
drwxr-xr-x root root system_u:object_r:file_t mountpoint-ext3
drwxr-xr-x root root system_u:object_r:file_t mountpoint-reiserfs

[root@localhost mountpoint-ext3]# ls -Z
drwxrwxrwx root root root:object_r:file_t abc
drwxr-xr-x bebe bebe root:object_r:file_t def
drwx------  root root system_u:object_r:file_t lost+found

[root@localhost mountpoint-reiserfs]# ls -Z
drwxr-xr--  bebe bebe system_u:object_r:file_t abc
drwxr-xr-x  root root system_u:object_r:file_t def

[bebe@localhost abc]$ su
Password:
[root@localhost abc]# ls >xxxxxx
bash: xxxxxx: Permission denied
[root@localhost abc]#

same in targeted and permissive mode in selinux

up to 2.6.16-rc1-git6 it works OK

xboom

