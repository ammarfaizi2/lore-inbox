Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUD1UPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUD1UPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUD1UPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:15:20 -0400
Received: from nn2.excitenetwork.com ([207.159.120.56]:8467 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S262031AbUD1UOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:14:09 -0400
To: linux-kernel@vger.kernel.org
Subject: How can I allocate few bytes to a file to store info about that file?
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = ce179fefc057f62eef8bd4d0182cc843
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20040428201405.5CC7EC01E@xprdmailfe13.nwk.excite.com>
Date: Wed, 28 Apr 2004 16:14:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I was going through the functions like generic_file_write, generic_file_direct_IO, generic_direct_IO and filemap_fdatasync. I was thinking about calling these functions or calling functions written on similar lines to add new few bytes to the file when the inode is created by "ext2_create()". Can any1 please tell me how to do this? What I mean is, I want to add few bytes to the file as soon as it is created. I want to store some information regarding the file in that area.

I guess it would have been simpler to call these functions in the call sys_open() when a new file is created, but I want to make changes in kernel code only in ext2 module. playing with sys_open will be like modifying kernel code apart from the ext2 fs module which I dont want.

Thanks and regards,

Vineet

--- On Mon 04/26, Vineet Joglekar < vintya@excite.com > wrote:
From: Vineet Joglekar [mailto: vintya@excite.com]
To: linux-fsf@vger.kernel.org
Date: Mon, 26 Apr 2004 10:31:19 -0400
Subject: Can I allocate few bytes in a file to store info about that file; not visible to user?

Hi all,<br><br>In ext2fs, while creating a file, can I allocate a number of bytes for that file in advance, such that those bytes are not seen by the user? that is,<br><br>suppose I am creating a new file temp, then allocate 50 bytes immediately after creating the file. I want to use those bytes to store the file related info; accessible only to kernel. Whatever data user wants to add, will be added after the these 50 bytes. If user does lseek(fd,0,SEEK_SET), then the file pointer should point to the 51st byte. The 1st 50 bytes shouldnt be visible to user. I dont care if the file size is shown as userdata+50. Is it possible to achieve? If yes, how?<br><br>Thanks and regards,

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
