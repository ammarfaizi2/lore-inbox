Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWCCNRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWCCNRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWCCNRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:17:50 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:29626 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751143AbWCCNRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:17:49 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-mm1 ext3 filesystem corruption
Date: Fri, 3 Mar 2006 14:15:08 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603031415.08745.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my 2.6.15-rc5-mm1 test boxes just crashed and caused filesystem 
corruption on its ext3 / filesystem.

The crash left these bits in syslog before automatically remounting the 
filesystem read-only and crashing the X server that was displaying the full 
message:

[<b01aa074>] __ext3_journal_stop+0x24/0x50
[<b01a3cf2>] ext3_delete_inode+0xb2/0x100
[<b01770c3>] dput+0x23/0x180
[<b017b022>] mntput_no_expire+0x22/0x90
[<b016fadf>] sys_link+0x2f/0x40
[<b0102e13>] sysenter_past_esp+0x54/0x75

The box was under relatively high load at the time this happened (compiling 
gcc 4.1.0 and OpenOffice.org 2.0.2rc1); the root filesystem is on a SATA disk 
(sata_via).
