Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUCDW2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUCDW2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:28:37 -0500
Received: from baltazar.tecnoera.com ([200.24.224.1]:26064 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id S261984AbUCDW2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:28:35 -0500
Subject: 2.6.3 + reiser + quota support
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078439292.16283.49.camel@blackbird.tecnoera.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 04 Mar 2004 19:28:12 -0300
Content-Transfer-Encoding: 7bit
X-tecnoera-MailScanner-Information: Please contact the ISP for more information
X-tecnoera-MailScanner: Found to be clean
X-MailScanner-From: jpabuyer@tecnoera.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

As I can read in the help of quota it says:
------------------------------------------------------------
CONFIG_QUOTA:
If you say Y here, you will be able to set per user limits for disk
usage (also called disk quotas). Currently, it works for the
ext2, ext3, and reiserfs file system.
------------------------------------------------------------

but when I try to mount a reiserfs formatted partition this happens:
[root@test mnt]# mount -o defaults,usrquota /dev/hdc1 test
mount: wrong fs type, bad option, bad superblock on /dev/hdc1,
       or too many mounted file systems
[root@test mnt]#
and /var/log/messages says:
Mar  4 19:15:46 test kernel: reiserfs_getopt: unknown option "usrquota"

for an ext3 formatted partition it works:
[root@test mnt]# mount -o defaults,usrquota /dev/hdc1 test
[root@test mnt]# mount
/dev/hda2 on / type ext3 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
/dev/hdc1 on /mnt/test type ext3 (rw,usrquota)

Additional info:
[root@test linux-2.6.3]# grep -i quota .config
CONFIG_XFS_QUOTA=y
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y

Any advice?

-- 
Juan Pablo Abuyeres <jpabuyer@tecnoera.com>

