Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbULOQly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbULOQly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbULOQlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:41:53 -0500
Received: from nn7.excitenetwork.com ([207.159.120.61]:33570 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S262388AbULOQlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:41:05 -0500
To: linux-kernel@vger.kernel.org
Subject: is there any prob in accessing new field added to inode mem structure, in some other functions?
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 41790ee39c7967bbf4ef314fad615410
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20041215164101.A52C3B740@xprdmailfe18.nwk.excite.com>
Date: Wed, 15 Dec 2004 11:41:01 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi all,

I am using linux 2.4.21 and I am trying to play with the etx2 file system. My aim is to allocate a data structure dynamically to every file that is opened, at the time of opening.
What I tried to do was: added the structure pointer in the inode data structure "ext2_inode" say "x_ptr". In the function "ext2_read_inode" which reads the hard disk copy of inode into memory, I allocated memory to this pointer and filled the appropriate value. I chose this function as I thought when a file is opened, this function will be always called once. Upto this is working fine.

Now when I try to use this pointer "x_ptr" in some other function, that is, "do_generic_file_read" - which is called while reading a file, I am not getting any value in that pointer, but a null. (which is supposed to be there as I am filling up appropriate value in function ext2_read_inode)
In the do_generic_file_read, VFS inode is availavle, so I am trying to access my pointer as inode->u.ext2_i.x_ptr and I had accessed this pointer in the same way while allocating memory for it in read_inode. At the same time, in do_generic_file_read, I can access other inode parameters, but not this new one added.

Can someone please tell me where am I going wrong, or what could be the alternate solution to achieve this? This is very important for me.

Thanks and regards,

Vineet


_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
