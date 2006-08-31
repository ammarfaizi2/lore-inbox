Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWHaHe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWHaHe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHaHe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:34:29 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:48561 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751177AbWHaHe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:34:28 -0400
Message-Id: <44F6AD47.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 31 Aug 2006 09:35:03 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Badari Pulavarty" <pbadari@gmail.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, <petkov@math.uni-muenster.de>,
       <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
 <44E97353.76E4.0078.0@novell.com> <20060829085338.GA8225@gollum.tnic>
 <44F42BB1.76E4.0078.0@novell.com> <20060829110109.GA10944@gollum.tnic>
 <44F43C67.76E4.0078.0@novell.com>
 <1156974410.16136.1.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1156974410.16136.1.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi submitted a fix for this to Linus, but that's post-rc5. Jan

>>> Badari Pulavarty <pbadari@gmail.com> 30.08.06 23:46 >>>
I ran into another (small) issue with the trace - it looks like 
for some reason trace repeats twice. Do you know, why ?

Thanks,
Badari

Call Trace:
 [<ffffffff8020b395>] show_trace+0xb5/0x370
 [<ffffffff8020b665>] dump_stack+0x15/0x20
 [<ffffffff8030d3b9>] journal_invalidatepage+0x309/0x3b0
 [<ffffffff802fe898>] ext3_invalidatepage+0x38/0x40
 [<ffffffff80282750>] do_invalidatepage+0x20/0x30
 [<ffffffff80260820>] truncate_inode_pages_range+0x1e0/0x300
 [<ffffffff80260950>] truncate_inode_pages+0x10/0x20
 [<ffffffff802686ff>] vmtruncate+0x5f/0x100
 [<ffffffff8029d7d0>] inode_setattr+0x30/0x140
 [<ffffffff802ff81b>] ext3_setattr+0x1bb/0x230
 [<ffffffff8029da3e>] notify_change+0x15e/0x320
 [<ffffffff8027f973>] do_truncate+0x53/0x80
 [<ffffffff802800f8>] sys_ftruncate+0xf8/0x130
 [<ffffffff80209d5a>] system_call+0x7e/0x83
 [<00002b40b67e1c47>]
 [<ffffffff8030d3b9>] journal_invalidatepage+0x309/0x3b0
 [<ffffffff802fe898>] ext3_invalidatepage+0x38/0x40
 [<ffffffff80282750>] do_invalidatepage+0x20/0x30
 [<ffffffff80260820>] truncate_inode_pages_range+0x1e0/0x300
 [<ffffffff802fc203>] __ext3_get_inode_loc+0x163/0x350
 [<ffffffff80260950>] truncate_inode_pages+0x10/0x20
 [<ffffffff802686ff>] vmtruncate+0x5f/0x100
 [<ffffffff8029d7d0>] inode_setattr+0x30/0x140
 [<ffffffff802ff81b>] ext3_setattr+0x1bb/0x230
 [<ffffffff8029da3e>] notify_change+0x15e/0x320
 [<ffffffff8027f973>] do_truncate+0x53/0x80
 [<ffffffff80281af1>] generic_file_llseek+0x91/0xb0
 [<ffffffff802800f8>] sys_ftruncate+0xf8/0x130
 [<ffffffff80209d5a>] system_call+0x7e/0x83




