Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSJHPj3>; Tue, 8 Oct 2002 11:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSJHPj3>; Tue, 8 Oct 2002 11:39:29 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33728 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261228AbSJHPj3>; Tue, 8 Oct 2002 11:39:29 -0400
Date: Tue, 08 Oct 2002 08:42:45 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: might_sleep warning in both 41 and 41-mm1
Message-ID: <1455194388.1034066565@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one still happens in both 41 and 41-mm1. I'd mentioned
it before, and was told it was fixed in a later kernel, but
still seems to be there.

Debug: sleeping function called from illegal context at mm/page_alloc.c:512
Call Trace:
 [<c0115fb3>] __might_sleep+0x43/0x47
 [<c0134efc>] __alloc_pages+0x24/0x260
 [<c0112638>] pte_alloc_one+0x38/0xfc
 [<c01279cd>] pte_alloc_map+0x2d/0x1b0
 [<c012f6cc>] move_one_page+0x11c/0x2d8
 [<c012f794>] move_one_page+0x1e4/0x2d8
 [<c012f8b7>] move_page_tables+0x2f/0x74
 [<c012fe4d>] do_mremap+0x551/0x6dc
 [<c013002b>] sys_mremap+0x53/0x74
 [<c0106ff7>] syscall_call+0x7/0xb

