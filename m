Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVBBNtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVBBNtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVBBNtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:49:05 -0500
Received: from nn3.excitenetwork.com ([207.159.120.57]:59443 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S262286AbVBBNtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:49:01 -0500
To: linux-kernel@vger.kernel.org
Subject: when and where shall I encrypt dentry?
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 41790ee39c7967bbf4ef314fad615410
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-c-programming@vger.kernel.org
Message-Id: <20050202134901.9926C3E12@xprdmailfe6.nwk.excite.com>
Date: Wed,  2 Feb 2005 08:49:01 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am trying to add some cryptographic functionality to ext2 file system for my masters project. I am working with kernel 2.4.21

Along with regular files, I intend to encrypt directory contents too. For reading I guess the function ext2_get_page in fs/ext2/dir.c is used. Hence I can put my decryption routine in that function. Is that correct?

I was trying to look for the routine which writes the dentry on disk, but was unable to find it. I found out that the function d_instantiate is used to fill in inode information for a dentry, but unable to see when it is written on disk. I suppose that I have to encrypt the dentry just before writing on to the disk, as if i encrypt it before, other functions using it wont be able to access until they decrypt. So please help me with this, that when and where shall I encrypt the directory contents.

Thanks and regards,

Vineet

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
