Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262729AbSI1FYM>; Sat, 28 Sep 2002 01:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSI1FYM>; Sat, 28 Sep 2002 01:24:12 -0400
Received: from holomorphy.com ([66.224.33.161]:64428 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262729AbSI1FYL>;
	Sat, 28 Sep 2002 01:24:11 -0400
Date: Fri, 27 Sep 2002 22:28:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: mremap() pte allocation atomicity error
Message-ID: <20020928052813.GY22942@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on something else atm.

 [<c01187b3>]__might_sleep+0x43/0x47
 [<c013b6d4>]__alloc_pages+0x24/0x20c
 [<c0133650>]file_read_actor+0x0/0x1b0
 [<c01131ed>]pte_alloc_one+0x41/0x104 
 [<c012d05d>]pte_alloc_map+0x4d/0x210
 [<c013bc73>]get_page_cache_size+0xf/0x18
 [<c0135f38>]move_one_page+0xe8/0x328    
 [<c0136061>]move_one_page+0x211/0x328
 [<c0130644>]vm_enough_memory+0x34/0xc0
 [<c01361a9>]move_page_tables+0x31/0x7c
 [<c0136860>]do_mremap+0x66c/0x7ec     
 [<c0136a30>]sys_mremap+0x50/0x73 
 [<c010748f>]syscall_call+0x7/0xb

