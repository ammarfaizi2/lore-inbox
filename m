Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbULJWeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbULJWeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbULJWcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:32:20 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:3076 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261861AbULJWaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:30:08 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10rc3+cset == oops (fs).
Date: Fri, 10 Dec 2004 23:30:01 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412102330.02459.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just tried to boot the 2.6.10rc3+cset20041210_0507.

[handcopy of the ooops]

dereferencing null pointer
eip at: radix_tree_tag_clear

trace:
(...)
test_clear_page_dirty
truncate_complete_page
truncate_inode_pages_range
truncate_inode_pages
generic_delete_inode
sys_unlink
initrd_load
prepare_namespace
(...)


/dev/hda1 on / type ext3 (rw)
/dev/hda2 on /usr type ext3 (rw)
/dev/hda5 on /tmp type ext3 (rw)
/dev/hda6 on /var type ext3 (rw)
/dev/hda7 on /home type ext3 (rw)
/dev/hda8 on /home/users/pluto/multimedia type ext3 (rw)
/dev/hdd1 on /home/users/pluto/rpm type ext3 (rw)
none on /proc type proc (rw,gid=17)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)
sysfs on /sys type sysfs (rw)
selinuxfs on /selinux type selinuxfs (rw)

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
