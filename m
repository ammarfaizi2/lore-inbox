Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbRFCQl0>; Sun, 3 Jun 2001 12:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263676AbRFCQlQ>; Sun, 3 Jun 2001 12:41:16 -0400
Received: from hera.cwi.nl ([192.16.191.8]:4796 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263174AbRFCQhL>;
	Sun, 3 Jun 2001 12:37:11 -0400
Date: Sun, 3 Jun 2001 18:36:38 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106031636.SAA183957.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: symlink_prefix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Current interface had grown an impressive collection of warts.
> Worse yet, you _can't_ put parsing into generic code.
> There are filesystems that have a binary object as 'data'.

Yes, that was a very unfortunate decision, back in the good old times
when nfs was implemented. And smb, ncp, coda followed nfs.

Nevertheless, there is no problem adding vfs_parse_mount_options().
For example, one can have a flag FS_HAS_BINARY_MOUNT_DATA in
the fs_flags field of the struct file_system_type that describes
the filesystem type, and refrain from trying to parse the mount data
when this bit is set.


Andries
