Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbQKPSBd>; Thu, 16 Nov 2000 13:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbQKPSBN>; Thu, 16 Nov 2000 13:01:13 -0500
Received: from [213.128.193.82] ([213.128.193.82]:13832 "EHLO
	mail.ixcelerator.com") by vger.kernel.org with ESMTP
	id <S131221AbQKPSBC>; Thu, 16 Nov 2000 13:01:02 -0500
Date: Thu, 16 Nov 2000 20:29:26 +0300
From: Oleg Drokin <green@ixcelerator.com>
To: linux-kernel@vger.kernel.org
Subject: ramfs always reports filesize in blocks to be 0
Message-ID: <20001116202926.A18336@iXcelerator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Subject says it all, inode->i_blocks always 0, in ramfs, and never updated
   (the only updated thing is inode->i_size).
   This breaks at least du(1). Ain't it should count blocks too, so that one
   can find how much ramfs is consuming in terms of memory by simply issuing
   du -ks ramfs_mount_point

Bye,
    Oleg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
