Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbSLPMtj>; Mon, 16 Dec 2002 07:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbSLPMtj>; Mon, 16 Dec 2002 07:49:39 -0500
Received: from mailout.nordcom.net ([213.168.202.90]:12507 "HELO
	mailout.nordcom.net") by vger.kernel.org with SMTP
	id <S266675AbSLPMti>; Mon, 16 Dec 2002 07:49:38 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ext3 fixes
In-Reply-To: <3DFCE55B.E9C634E2@digeo.com>
References: <3DFCE55B.E9C634E2@digeo.com>
Message-Id: <E18NuoO-0000IU-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
Date: Mon, 16 Dec 2002 13:57:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2002 21:30:16 +0100, you wrote in linux.kernel:

> Fix it so that we only run ext3_mark_inode_dirty() if the inode was
> successfully instantiated.

After applying your three ext3 fixes to 2.4.20 and rebooting with
data=journal, I get the following message in dmesg which does not
appear with clean 2.4.20 (no matter whether data=ordered or
data=journal):

blk: queue c0370520, I/O limit 4095Mb (mask 0xffffffff)

It appears just after the messages for mounting my ext3 filesystems:

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with journal data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 256k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,71), internal journal
EXT3-fs: mounted filesystem with journal data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,69), internal journal
EXT3-fs: mounted filesystem with journal data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,70), internal journal
EXT3-fs: mounted filesystem with journal data mode.

Is the message just for information or should I worry?

-- 
Ciao,
Pascal
