Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTKTSQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTKTSQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:16:41 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:48314 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262655AbTKTSQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:16:38 -0500
Date: Thu, 20 Nov 2003 10:41:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1565] New: kernel BUG on sound, mm4, intel8x0 
Message-ID: <414450000.1069353709@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1565

           Summary: kernel BUG on sound, mm4, intel8x0
    Kernel Version: 2.6.0-test9-mm4
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: arnihr@php.is


Running a HP/Compaq nx7000. 
 
Problem Description: 
Whenever I try to play something in xmms I get the error. I was error free in 
-test9-mm3 and still am in mm3. I get this error: 
--------------------------------------------------------------- 
ov 20 16:27:59 ahrlap kernel BUG at arch/i386/mm/fault.c:357! 
Nov 20 16:27:59 ahrlap invalid operand: 0000 [#1] 
Nov 20 16:27:59 ahrlap PREEMPT DEBUG_PAGEALLOC 
Nov 20 16:27:59 ahrlap CPU:    0 
Nov 20 16:27:59 ahrlap EIP:    0060:[<c011c5fc>]    Not tainted VLI 
Nov 20 16:27:59 ahrlap EFLAGS: 00010206 
Nov 20 16:27:59 ahrlap EIP is at do_page_fault+0x18b/0x4a1 
Nov 20 16:27:59 ahrlap eax: 00000202   ebx: ceb72d30   ecx: ceb72d10   edx: 
00000202 
Nov 20 16:27:59 ahrlap esi: ceb72d10   edi: ce846950   ebp: ce82bfb4   esp: ce82bf1c 
Nov 20 16:27:59 ahrlap ds: 007b   es: 007b   ss: 0068 
Nov 20 16:27:59 ahrlap Process xmms (pid: 4716, threadinfo=ce82a000 
task=ce846950) 
Nov 20 16:27:59 ahrlap Stack: 00000001 421e8000 d4666870 e18f1ffa e1904ce0 
00030002 00000000 40396d04 
Nov 20 16:27:59 ahrlap ce813f5c ffffffe7 ce82bf8c e18f6757 e1904ce0 dd7c1ef8 
00000000 ce82bf84 
Nov 20 16:27:59 ahrlap c012e000 dcd9ed98 ce82bf6c c02e8e15 ce82bf6c ce82bf6c 
ce82bf94 00000001 
Nov 20 16:27:59 ahrlap Call Trace: 
Nov 20 16:27:59 ahrlap [<e18f1ffa>] snd_pcm_action+0x15b/0x16a [snd_pcm] 
Nov 20 16:27:59 ahrlap [<e18f6757>] snd_pcm_playback_ioctl1+0x54d/0x559 
[snd_pcm] 
Nov 20 16:27:59 ahrlap [<c012e000>] run_timer_softirq+0x25f/0x38d 
Nov 20 16:27:59 ahrlap [<c02e8e15>] rh_report_status+0x0/0x31c 
Nov 20 16:27:59 ahrlap [<c017d8a4>] sys_ioctl+0x282/0x33e 
Nov 20 16:27:59 ahrlap [<c017d955>] sys_ioctl+0x333/0x33e 
Nov 20 16:27:59 ahrlap [<c011c471>] do_page_fault+0x0/0x4a1 
Nov 20 16:27:59 ahrlap [<c03737af>] error_code+0x2f/0x38 
Nov 20 16:27:59 ahrlap 
Nov 20 16:27:59 ahrlap Code: 85 c0 7f 0b 83 f8 ff 0f 84 ea 01 00 00 eb 1c 83 f8 01 74 
07 83 f8 02 74 0a eb 10 ff 87 0c 02 00 00 eb 10 ff 87 10 02 00 00 eb 08 <0f> 0b 65 01 
95 9f 39 c0 8b 45 08 f6 40 32 02 74 21 8b 8d 6c ff 
------------------------------------------------------------- 
 
You can find kernel config, dmesg and lspci -v at www.localhost.is/~arnihr 
 
I run alsa, I tried both as modules and compiled in. It has been fine in all previous 
tested kernels. 
 
Steps to reproduce: 
Play sound.


