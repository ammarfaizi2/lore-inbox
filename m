Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUIJK4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUIJK4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUIJK4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:56:05 -0400
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:23264 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S267354AbUIJKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:55:32 -0400
Message-ID: <4141881D.2060400@bigpond.net.au>
Date: Fri, 10 Sep 2004 20:55:25 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
References: <413FA9AE.90304@bigpond.net.au> <20040909010610.28ca50e1.akpm@osdl.org> <4140EE3E.5040602@bigpond.net.au> <20040909171450.6546ee7a.akpm@osdl.org> <4141092B.2090608@bigpond.net.au> <20040909200650.787001fc.akpm@osdl.org> <41413F64.40504@bigpond.net.au> <20040909231858.770ab381.akpm@osdl.org> <414149A0.1050006@bigpond.net.au> <20040909235217.5a170840.akpm@osdl.org> <41415B15.1050402@bigpond.net.au> <20040910005454.23bbf9fb.akpm@osdl.org> <4141621D.7020301@bigpond.net.au> <414169F0.1040202@bigpond.net.au> <20040910015436.343c9a4d.akpm@osdl.org>
In-Reply-To: <20040910015436.343c9a4d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030809080201050409000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030809080201050409000506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>> >  I 
>> > still have the original four patches applied.  I'll try again with an 
>> > unpatched bk16 and let you know the results shortly.
>> > 
>>
>> With out of the box bk16 plus your rock.c patch and with 
>> CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC selected I get no oops in 
>> in_groupse_p() or kfree() but I still get the scheduling while atomic 
>> messages when I do "make install".
> 
> 
> OK.  Could you please resend one of the scheduling-while-atomic messages?

Attached.

> 
> Also, try disabling CONFIG_DEBUG_SLAB, and then reenable it and try
> disabling CONFIG_DEBUG_PAGEALLOC.  ie: one at a time, not both at the same
> time.
> 

OK.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------030809080201050409000506
Content-Type: text/plain;
 name="schedatomic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedatomic.txt"

Sep 10 18:38:10 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:10 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:10 mudlark kernel:  [<c0132cfd>] generic_file_write_nolock+0xad/0xc5
Sep 10 18:38:10 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:10 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:10 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:10 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:10 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:10 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:10 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:10 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:10 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:10 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:12 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:12 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:12 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:12 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:12 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:12 mudlark kernel: b85>] sys_read+0x51/0x80
Sep 10 18:38:12 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:12 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:12 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:12 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:12 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:12 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:12 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:12 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:12 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:12 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:12 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:12 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:12 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:12 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:12 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:12 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:12 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:12 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:12 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:12 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:12 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:12 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:12 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:12 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:12 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:12 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:12 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:12 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:12 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:12 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:12 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:12 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:12 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014e026>] sys_open+0x6c/0x89
Sep 10 18:38:13 mudlark kernel:  [<c014e026>] sys_open+0x6c/0x89
Sep 10 18:38:13 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:13 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:13 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:13 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:13 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:13 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:13 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:13 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:13 mudlark kernel:  [<c011b7d6>] __do_softirq+0x7e/0x87
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:14 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:14 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:14 mudlark kernel:  [<c011b7d6>] __do_softirq+0x7e/0x87
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:14 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:14 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:14 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:14 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:14 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:14 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:14 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:14 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:14 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:14 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:14 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:14 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:14 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:14 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:14 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:14 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:14 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:14 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:14 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:14 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:14 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:14 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:14 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:14 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:15 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:15 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:15 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:15 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:15 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:15 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:15 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:15 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:15 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:15 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:15 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:15 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:15 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:15 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:15 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:15 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:15 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:15 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:15 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:15 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:15 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:15 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:15 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:15 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:15 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:15 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:15 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:15 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:15 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:15 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:15 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:15 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:15 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:15 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:15 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:15 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:15 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:15 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:15 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:15 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:15 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:16 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:16 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:16 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:16 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:16 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:16 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:16 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:16 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:16 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:16 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:16 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:16 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:16 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:16 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:16 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:16 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:16 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:16 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:16 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:16 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:16 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:16 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c0114ca9>] autoremove_wake_function+0x2f/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a577>] pipe_wait+0x7b/0x9a
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c0114c7a>] autoremove_wake_function+0x0/0x57
Sep 10 18:38:16 mudlark kernel:  [<c015a729>] pipe_readv+0x193/0x296
Sep 10 18:38:16 mudlark kernel:  [<c015a863>] pipe_read+0x37/0x3b
Sep 10 18:38:16 mudlark kernel:  [<c014e8c4>] vfs_read+0xb0/0x119
Sep 10 18:38:16 mudlark kernel:  [<c03799b4>] schedule+0x348/0x571
Sep 10 18:38:16 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:16 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 18:38:16 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c014eb85>] sys_read+0x51/0x80
Sep 10 18:38:16 mudlark kernel:  [<c0104026>] work_resched+0x5/0x16
Sep 10 18:38:16 mudlark kernel: bad: scheduling while atomic!
Sep 10 18:38:16 mudlark kernel:  [<c0379bd8>] schedule+0x56c/0x571
Sep 10 18:38:16 mudlark kernel:  [<c01127c1>] __change_page_attr+0x2f/0x169
Sep 10 18:38:16 mudlark kernel:  [<c01127c1>] __change_page_attr+0x2f/0x169
Sep 10 18:38:16 mudlark kernel:  [<c011446b>] sys_sched_yield+0x71/0x96
Sep 10 18:38:16 mudlark kernel:  [<c015a1f9>] coredump_wait+0x39/0x9f
Sep 10 18:38:16 mudlark kernel:  [<c015a327>] do_coredump+0xc8/0x212
Sep 10 18:38:16 mudlark kernel:  [<c01203f6>] __dequeue_signal+0x111/0x18f
Sep 10 18:38:16 mudlark kernel:  [<c01203c4>] __dequeue_signal+0xdf/0x18f
Sep 10 18:38:16 mudlark kernel:  [<c01204a9>] dequeue_signal+0x35/0x90
Sep 10 18:38:16 mudlark kernel:  [<c0122116>] get_signal_to_deliver+0x215/0x337
Sep 10 18:38:16 mudlark kernel:  [<c0103daf>] do_signal+0x98/0x122
Sep 10 18:38:16 mudlark kernel:  [<c0165228>] dput+0x24/0x214
Sep 10 18:38:16 mudlark kernel:  [<c015b772>] path_release+0x15/0x45
Sep 10 18:38:16 mudlark kernel:  [<c014db3a>] sys_chown+0x59/0x5b
Sep 10 18:38:16 mudlark kernel:  [<c0111b24>] do_page_fault+0x0/0x59b
Sep 10 18:38:16 mudlark kernel:  [<c0103e6e>] do_notify_resume+0x35/0x37
Sep 10 18:38:16 mudlark kernel:  [<c010404a>] work_notifysig+0x13/0x15
Sep 10 18:38:16 mudlark kernel: note: tar[3706] exited with preempt_count 6

--------------030809080201050409000506--

