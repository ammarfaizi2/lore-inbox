Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263665AbTCURHB>; Fri, 21 Mar 2003 12:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263666AbTCURHA>; Fri, 21 Mar 2003 12:07:00 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15765 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263665AbTCURG7>; Fri, 21 Mar 2003 12:06:59 -0500
Date: Fri, 21 Mar 2003 09:17:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 482] New: slab error in check_poison_obj(): cache `task_struct': object was modified after freeing
Message-ID: <335860000.1048267078@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=482

           Summary: slab error in check_poison_obj(): cache `task_struct':
                    object was modified after freeing
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: jochen@jochen.org


Distribution: Debian Sarge
Hardware Environment: IBM Thinkpad 600

Problem Description:

The kernel log contains:
ALSA sound/isa/cs423x/cs4236_lib.c:302: CS4236: [0x538] C1 (version) = 0xe8, ext = 0xe8
Slab corruption: start=c46acd60, expend=c46ad36f, problemat=c46acd68
Data: ********6A
***************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************************************************! *************************************************************************************************************************************************************************************************************************************************************************<7>eth0: no IPv6 routers present
*****************************************************************************************************************************************************************************************************************************************************************************************************************A5
Next: 01 00 00 00 00 00 3C C4 04 00 00 00 00 00 00 00 00 00 00 00 FF FF FF FF 7B 00 00 00 78 00 00 00
slab error in check_poison_obj(): cache `task_struct': object was modified after freeing
Call Trace:
 [<c0130a7d>] __slab_error+0x21/0x28
 [<c0130e6c>] check_poison_obj+0x174/0x180
 [<c0131fc9>] kmem_cache_alloc+0x8d/0x128
 [<c0116a04>] dup_task_struct+0x70/0xd0
 [<c0116a04>] dup_task_struct+0x70/0xd0
 [<c0117475>] copy_process+0x99/0xb40
 [<c0117f96>] do_fork+0x7a/0x148
 [<c01077c0>] sys_fork+0x18/0x28
 [<c0108d3b>] syscall_call+0x7/0xb


Steps to reproduce:
This is when booting the system; I've not yet rebooted and will try again.


