Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUF1Cal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUF1Cal (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 22:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUF1Cal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 22:30:41 -0400
Received: from web41505.mail.yahoo.com ([66.218.93.88]:1639 "HELO
	web41505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264639AbUF1Cak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 22:30:40 -0400
Message-ID: <20040628023039.70960.qmail@web41505.mail.yahoo.com>
Date: Sun, 27 Jun 2004 19:30:39 -0700 (PDT)
From: Brian <bmg300@yahoo.com>
Subject: Kernel VM bug?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

While doing massive memory allocation (I'm using GRASS to project NASA's BlueMarble maps) the
kernel apparently tries to kill grass but fails. When I try to access /proc/<grass_pid>/stat the
process hangs.

For example, an 'strace' of 'ps' ends like this:
open("/proc/1783/stat", O_RDONLY) = 6
read(6, <PS and strace hang here>

I am able to project a few files, but once the filesystem cache fills up, GRASS hangs or gives a
panic in vm_stat:381. The strange thing is, very little swap space is in use, and the filesystem
cache continues to use most of the RAM.

Is this a kernel bug, or do I need to use kernel 2.6.x (I am using kernel 2.4.26) and
/proc/sys/vm/overcommit_memory or similar hack?

Since I am a kernel-newbie, these links might help explain the problem better ;)
http://seclists.org/linux-kernel/2001/Dec/1604.html
http://www.mail-archive.com/debian-glibc@lists.debian.org/msg10070.html

Brian G



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
