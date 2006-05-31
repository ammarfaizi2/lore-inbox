Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWEaTcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWEaTcp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWEaTcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:32:45 -0400
Received: from smtp-out.google.com ([216.239.45.12]:32573 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965123AbWEaTco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:32:44 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=EFTYA1E01iufcExq9gLBYATg8KP5BR8V8OiwSJYMWKjVv0cLfYanAWa9PZw+59M5Y
	kG10RSFVoljKbDk4KNNOw==
Message-ID: <447DEF47.6010908@google.com>
Date: Wed, 31 May 2006 12:32:23 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Subject: 2.6.17-rc5-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another panic. This time on x440.

M.

http://test.kernel.org/abat/33803/debug/console.log

BUG: unable to handle kernel paging request at virtual address 22222232
  printing eip:
c012b6eb
*pde = 15621001
*pte = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /class/vc/vcs1/dev
CPU:    1
EIP:    0060:[<c012b6eb>]    Not tainted VLI
EFLAGS: 00010002   (2.6.17-rc5-mm1-autokern1 #1)
EIP is at check_deadlock+0x15/0xe0
eax: 22222222   ebx: 00000001   ecx: d4996000   edx: 00000001
esi: d686f550   edi: 22222222   ebp: 22222222   esp: d5bdfec8
ds: 007b   es: 007b   ss: 0068
Process mkdir09 (pid: 18867, threadinfo=d5bdf000 task=d5c0e000)
Stack: 00000000 d686f550 d3960568 22222222 c012b77b d3960568 d5bdf000 
d5bdff00
        d5c0e000 c012b922 d5bdff48 d3960568 00000246 c02d50de d5bdff00 
d5bdff00
        11111111 11111111 d5bdff00 ffffff9c d5bdff48 00000000 d5bdff48 
ffffffef
Call Trace:
  <c012b77b> check_deadlock+0xa5/0xe0  <c012b922> 
debug_mutex_add_waiter+0x46/0x55
  <c02d50de> __mutex_lock_slowpath+0x9e/0x1c0  <c0160061> 
lookup_create+0x19/0x5b
  <c016043a> sys_mkdirat+0x4c/0xc3  <c01604c0> sys_mkdir+0xf/0x13
  <c02d6217> syscall_call+0x7/0xb
