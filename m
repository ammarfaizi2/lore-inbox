Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273486AbRIVGjS>; Sat, 22 Sep 2001 02:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274014AbRIVGjI>; Sat, 22 Sep 2001 02:39:08 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:63877 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S273486AbRIVGiw>; Sat, 22 Sep 2001 02:38:52 -0400
Message-ID: <3BAC320B.219B808F@rcn.com.hk>
Date: Sat, 22 Sep 2001 14:39:07 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [zh_TW] (X11; U; Linux 2.4.4-1DC i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vfs_symlink return NULL inode
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have one question from using vfs_symlink, is it usual after I called
vfs_symlink that will return a dentry with dentry->d_inode == NULL???
The link was sucessfully created but I receive a null inode pointer. 
When creating a symlink it should also create an inode. But according to
the documentation about VFS from Richard, the symlink call of
inode_operations, should self call d_instantiate() this also means it
should automatically create an inode pointer. This shouldn't be done by
the caller???? Any hints? the vfs_create works fine and return with a
proper inode number, why vfs_symlink doesn't? Thanks.

regards,

David Chow
