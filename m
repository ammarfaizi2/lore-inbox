Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUESCHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUESCHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 22:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUESCHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 22:07:52 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:45187 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263731AbUESCHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 22:07:51 -0400
Message-ID: <40AAC179.7040309@backtobasicsmgmt.com>
Date: Tue, 18 May 2004 19:07:53 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Strange (short) oops with 2.6.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a very weird one: just a single oops, killed one process, has not 
  reoccurred since (yesterday morning).

alpha.access.internal login: Oops: 0000 [#1]
SMP
CPU:    1
EIP:    0060:[<c0158e30>]    Not tainted
EFLAGS: 00010206   (2.6.6)
EIP is at poll_freewait+0x10/0x50
eax: c11bb5d0   ebx: cddae008   ecx: c0392380   edx: c11b19f0
esi: cddae008   edi: 5d020000   ebp: 00000018   esp: cde55ee0
ds: 007b   es: 007b   ss: 0068
Process smbd (pid: 252, threadinfo=cde54000 task=df973790)
Stack: 00000000 00000000 00000018 c0159201 cde55f40 00000000 00000000 
00000000
        00000000 00000104 00c00020 00000000 00000000 00c00020 cde54000 
dffc2f28
        dffc2f24 dffc2f20 dffc2f34 dffc2f30 dffc2f2c 00000000 00000000 
00000000
Call Trace:
  [<c0159201>] do_select+0x1c1/0x2e0
  [<c0158e70>] __pollwait+0x0/0xd0
  [<c015964b>] sys_select+0x2fb/0x520
  [<c0150657>] sys_fstat64+0x37/0x40
  [<c010402f>] syscall_call+0x7/0xb

Code: 8b 5f 04 8d 77 08 8d 76 00 8d bc 27 00 00 00 00 83 eb 1c 8b
