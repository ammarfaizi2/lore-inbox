Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWICDDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWICDDs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 23:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWICDDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 23:03:48 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:11568 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751952AbWICDDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 23:03:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jsGK6NCjb4q6/uJHlgcxGX2lLWiSikohfqtlapBgAifHXdrz4wahISCqxI6yzBpV0v3lK5lKVcOF+e2PoypUUxrbekbHgBEajrgveM7iXOINhFHxt8HQJMrCRcVLP9UQ6DLsH1lrgLP++2UNB5YFXmTcV1QmelTldW3+ohHtr/w=
Message-ID: <a44ae5cd0609022003i2b3157a2kb8bcd6f4f778b6c9@mail.gmail.com>
Date: Sat, 2 Sep 2006 20:03:46 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc5-mm1 + all hotfixes -- BUG: MAX_STACK_TRACE_ENTRIES too low!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Andrew.  I don't see clues here to help me target the report to
a maintainer.
I hope this helps.

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
 [<c1003c97>] dump_trace+0x69/0x1b7
 [<c1003dfa>] show_trace_log_lvl+0x15/0x28
 [<c10040f5>] show_trace+0x16/0x19
 [<c1004110>] dump_stack+0x18/0x1d
 [<c102d4d0>] save_trace+0xbb/0xc8
 [<c102d53c>] add_lock_to_list+0x5f/0x7d
 [<c102f3ce>] __lock_acquire+0x93b/0x9f8
 [<c102f75e>] lock_acquire+0x56/0x74
 [<c11dcdb0>] _spin_lock+0x24/0x32
 [<c105471f>] anon_vma_prepare+0x46/0xce
 [<c1050014>] __handle_mm_fault+0xed/0x804
 [<c1012c1a>] do_page_fault+0x214/0x4c1
 [<c11dd629>] error_code+0x39/0x40
DWARF2 unwinder stuck at error_code+0x39/0x40

Leftover inexact backtrace:

 [<c1003dfa>] show_trace_log_lvl+0x15/0x28
 [<c10040f5>] show_trace+0x16/0x19
 [<c1004110>] dump_stack+0x18/0x1d
 [<c102d4d0>] save_trace+0xbb/0xc8
 [<c102d53c>] add_lock_to_list+0x5f/0x7d
 [<c102f3ce>] __lock_acquire+0x93b/0x9f8
 [<c102f75e>] lock_acquire+0x56/0x74
 [<c11dcdb0>] _spin_lock+0x24/0x32
 [<c105471f>] anon_vma_prepare+0x46/0xce
 [<c1050014>] __handle_mm_fault+0xed/0x804
 [<c1012c1a>] do_page_fault+0x214/0x4c1
 [<c11dd629>] error_code+0x39/0x40
 [<c105fe67>] do_sync_read+0xb8/0xf2
 [<c10601e1>] vfs_read+0xa7/0x149
 [<c1060a81>] sys_read+0x3a/0x61
 [<c1002d41>] sysenter_past_esp+0x56/0x8d
 =======================

-- 
VGER BF report: H 0.0999452
