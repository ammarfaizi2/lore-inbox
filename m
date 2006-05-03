Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWECQp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWECQp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWECQp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:45:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50346 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030241AbWECQpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:45:55 -0400
Date: Wed, 3 May 2006 18:45:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?ISO-8859-15?Q?Markus_M=FCller?= <mm@priv.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
In-Reply-To: <4458C48B.8040703@priv.de>
Message-ID: <Pine.LNX.4.61.0605031842260.13546@yvahk01.tjqt.qr>
References: <4458C48B.8040703@priv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi Linux kernel users,
>
> reiserfsck told me that I have to run --rebuild-tree to fix all errors. But
> this don't work (see below), I tried two times (every time I am waiting 28
> hours). If I mount the filesystem, there are no files in it. What can I do?

Is the harddisk broken? (Check for spurious IDE warnings in /var/log/...)
It is possible that fsck zeroed out many entries because they were not 
readable.

> stacker:/# dmesg
> oop0: warning: vs-5150: search_by_key: invalid format found in block 1770409.
> Fsck?
> ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure
[...]

reiserfs warnings, but no lowlevel warnings :-/
Did, by chance, you use dm-flakey?


Jan Engelhardt
-- 
