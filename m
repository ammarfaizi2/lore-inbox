Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUBFXna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUBFXna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:43:30 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:38536 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S265553AbUBFXm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:42:59 -0500
Message-ID: <40242651.3080207@lbl.gov>
Date: Fri, 06 Feb 2004 15:42:09 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: i_size_write called without i_sem..
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found these in my dmesg..

i_size_write() called without i_sem
Call Trace:
 [<c01436c5>] i_size_write_check+0x55/0x60
 [<c0163d2b>] generic_commit_write+0x4b/0x80
 [<c01b3bf5>] ext2_commit_chunk+0x25/0x70
 [<c01b4bbf>] ext2_make_empty+0x12f/0x1b0
 [<c01b8434>] ext2_mkdir+0x94/0x120
 [<c016fafe>] vfs_mkdir+0x4e/0x90
 [<c016fbcf>] sys_mkdir+0x8f/0xd0
 [<c015fc7e>] sys_write+0x2e/0x50
 [<c02ca1ba>] sysenter_past_esp+0x43/0x69

kernel info:

Linux version 2.6.2-mm1 (root@lanshark.nersc.gov) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 SMP Thu Feb 5 15:50:03 PST 2004

Hints?

thomas
