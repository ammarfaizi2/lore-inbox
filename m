Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVDDW4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVDDW4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVDDW4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:56:05 -0400
Received: from nn7.excitenetwork.com ([207.159.120.61]:2082 "EHLO excite.com")
	by vger.kernel.org with ESMTP id S261463AbVDDWys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:54:48 -0400
To: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Adding a field to ext2_dir_entry_2 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 879b4ea53dbad4bbc16ad4568876f5e4
Reply-To: vintya@excite.com
From: "Vineet Joglekar" <vintya@excite.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20050404225442.52A7AB730@xprdmailfe18.nwk.excite.com>
Date: Mon,  4 Apr 2005 18:54:42 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi All,

I working with linux kernel 2.4.28. I want to add 1 more field to ext2_dir_entry_2 - the new version of directory entry for ext2fs.

I did add the __u32 field to the struct ext2_dir_entry_2 defined in  ext2_fs.h I also modified the EXT2_DIR_REC_LEN macro to:

(((name_len) + 12 + EXT2_DIR_ROUND) & ~EXT2_DIR_ROUND)

(+12 instead of +8) to incorporate newly added 4 bytes field.

I made the similar changes to the mke2fs utility also.

When I try to copy a file on that file system, I am getting the following error:

"ext2-fs error (device fd(2,0)): ext2_check_page: bad entry in directory #2: unaligned directory entry - offset=0, inode=2, rec_len=46, name_len=0"

Can someone please tell me where am I going wrong or what other changes do I need to do to add the field I want?

Thanks and regards,

Vineet Joglekar

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!
