Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUBHBTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUBHBTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:19:19 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.67]:20520 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261775AbUBHBTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:19:12 -0500
Date: Sat, 07 Feb 2004 20:20:34 -0500
From: Robert F Merrill <griever@t2n.org>
Subject: 2.6.2-mm1 seems to break ALSA and DRI module compilation
To: linux-kernel@vger.kernel.org
Message-id: <40258EE2.9000507@t2n.org>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
 Debian/1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got 2.6.2-mm1 running... however I get a bunch of module errors
when I try to load my (seperately compiled) ALSA and DRI modules

first of all, nearly every alsa module complains about a billion 
undefined symbols
secondly, I get the error "module falsely claims to have symbol ^A".

Feb  7 20:06:00 cheyenne kernel: snd: falsely claims to have parameter ^A
Feb  7 20:06:00 cheyenne kernel: snd_ak4531_codec: Unknown symbol 
snd_ctl_add
Feb  7 20:06:00 cheyenne kernel: snd_ak4531_codec: Unknown symbol 
snd_card_proc_new
Feb  7 20:06:00 cheyenne kernel: snd_ak4531_codec: Unknown symbol 
snd_ctl_new1
Feb  7 20:06:00 cheyenne kernel: snd_ak4531_codec: Unknown symbol 
snd_component_add
Feb  7 20:06:00 cheyenne kernel: snd_ak4531_codec: Unknown symbol 
snd_iprintf
Feb  7 20:06:00 cheyenne kernel: snd_ak4531_codec: Unknown symbol 
snd_kcalloc
Feb  7 20:06:00 cheyenne kernel: snd_ak4531_codec: Unknown symbol 
snd_device_new
Feb  7 20:06:00 cheyenne kernel: snd_page_alloc: falsely claims to have 
parameter ^A


I also get a few errors like this...
Feb  7 20:06:00 cheyenne kernel: i_size_write() called without i_sem
Feb  7 20:06:00 cheyenne kernel: Call Trace:
Feb  7 20:06:00 cheyenne kernel:  [i_size_write_check+91/96] 
i_size_write_check+0x5b/0x60
Feb  7 20:06:00 cheyenne kernel:  [generic_commit_write+98/176] 
generic_commit_write+0x62/0xb0
Feb  7 20:06:00 cheyenne kernel:  [ext2_commit_chunk+65/144] 
ext2_commit_chunk+0x41/0x90
Feb  7 20:06:00 cheyenne kernel:  [ext2_make_empty+362/464] 
ext2_make_empty+0x16a/0x1d0
Feb  7 20:06:00 cheyenne kernel:  [ext2_get_block+0/1056] 
ext2_get_block+0x0/0x420
Feb  7 20:06:00 cheyenne kernel:  [ext2_mkdir+181/336] ext2_mkdir+0xb5/0x150
Feb  7 20:06:00 cheyenne kernel:  [vfs_mkdir+148/272] vfs_mkdir+0x94/0x110
Feb  7 20:06:00 cheyenne kernel:  [sys_mkdir+184/256] sys_mkdir+0xb8/0x100
Feb  7 20:06:00 cheyenne kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
at bootup.

I'm going to go to vanilla 2.6.2 and see if that has the problem.

