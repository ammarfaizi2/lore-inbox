Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUBJPpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 10:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbUBJPpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 10:45:30 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:60803 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S265932AbUBJPp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 10:45:28 -0500
Date: Tue, 10 Feb 2004 10:44:49 -0500
From: Eric Buddington <ebuddington@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Reiserfs crash while deleting specific file in 2.6.2
Message-ID: <20040210154449.GA1419@pool-151-203-182-190.wma.east.verizon.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.203.182.190] at Tue, 10 Feb 2004 09:45:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.2, not tainted.

My reiser root fs filled up while compiling, so I started deleting
extra files to make space. One directory in particular gives me a BUG
when I try to rm -rf it (I don't know if it's the same file each time;
the dir in question has no subdirs).

Running 'dmesg' afterwards to check messages hangs. So do other
commands I tried. I can still type at existing shells until I hit
enter, so I had to reboot.

When I repeated this at the console, I saw the following (which I had
to scribble on paper, so I just grabbed what I guessed was most
useful):

-----------
Kernel BUG at fs/reiserfs/prints.c:339
invalid operand: 0000 [#1]
call trace:
	reiserfs_do_truncate+0x34a/0x5f0
	reiserfs_delete_object
	reiserfs_delete_inode
	reiserfs_delete_inode
	generic_delete_inode
-------------

This is repeatable (2 for 2, anyway), and I will get more info if requested.

-Eric
