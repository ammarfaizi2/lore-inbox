Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUBHKkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 05:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbUBHKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 05:40:20 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:5522 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263205AbUBHKkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 05:40:17 -0500
Date: Sun, 8 Feb 2004 11:40:15 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: minixfs problem on 2.6
Message-ID: <20040208104015.GA21366@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# # Hello, lkml.  This is a bug report.
# uname -r
2.6.3-rc1
# pwd
/tmp
# dd if=/dev/zero of=test.img bs=1024k count=48
48+0 records in
48+0 records out
# losetup /dev/loop0 test.img
# mkfs -t minix /dev/loop0
16384 inodes
49152 blocks
Firstdatazone=523 (523)
Zonesize=1024
Maxsize=268966912
# losetup -d /dev/loop0
# mount -o loop test.img /mnt
# mount| grep mnt
/tmp/test.img on /mnt type minix (rw,loop=/dev/loop0)
# cd /mnt
# cp /usr/lib/libc.a .
# du -h /usr/lib/libc.a ./libc.a
2.4M    /usr/lib/libc.a
1.0K    ./libc.a
