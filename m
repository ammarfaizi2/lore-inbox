Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVLaQsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVLaQsp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVLaQsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:48:45 -0500
Received: from [202.67.154.148] ([202.67.154.148]:35464 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S965020AbVLaQso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:48:44 -0500
Message-ID: <43B6B669.6020500@ns666.com>
Date: Sat, 31 Dec 2005 17:48:41 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <200512310027.47757.s0348365@sms.ed.ac.uk> <43B5D3ED.3080504@ns666.com> <200512310051.03603.s0348365@sms.ed.ac.uk> <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com> <20051231163414.GE3214@m.safari.iki.fi>
In-Reply-To: <20051231163414.GE3214@m.safari.iki.fi>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> On Sat, Dec 31, 2005 at 04:18:38PM +0100, Mark v Wolher wrote:
> ...
> 
>>Here is new data, this time it had to do with bttv:
>>
>>Dec 31 16:11:35 localhost kernel: Unable to handle kernel paging request at
>>virtual address d162e000
>>Dec 31 16:11:35 localhost kernel: printing eip:
>>Dec 31 16:11:35 localhost kernel: c036037a
>>Dec 31 16:11:35 localhost kernel: *pgd = 46063
>>Dec 31 16:11:35 localhost kernel: *pmd = 46063
>>Dec 31 16:11:35 localhost kernel: *pte = 1162e000
>>Dec 31 16:11:35 localhost kernel: Oops: 0002 [#1]
>>Dec 31 16:11:35 localhost kernel: SMP DEBUG_PAGEALLOC
>>Dec 31 16:11:35 localhost kernel: Modules linked in: nv
>>Dec 31 16:11:35 localhost kernel: CPU:    2
>>Dec 31 16:11:35 localhost kernel: EIP:    0060:[bttv_risc_packed+394/432]
> 
> 
> Can you try how many seconds it takes to get Oops/crash when you start
> pressing 'v' in xawtv (video capture on/off).
> For me, not very many.
> 
> This happens with every 2.6 kernel.  And my hardware is OK.
> 
> 
>>Not tainted VLI
>>Dec 31 16:11:35 localhost kernel: EFLAGS: 00210202   (2.6.14.5)
>>Dec 31 16:11:35 localhost kernel: eax: 14000008   ebx: d5ce9800   ecx:
>>d162e000   edx: 00000008
>>Dec 31 16:11:35 localhost kernel: esi: 00000008   edi: 000000ff   ebp:
>>cd06dde8   esp: cd06ddd0
>>Dec 31 16:11:35 localhost kernel: ds: 007b   es: 007b   ss: 0068
>>Dec 31 16:11:35 localhost kernel: Process xawtv (pid: 31110,
>>threadinfo=cd06c000 task=ca871aa0)
>>Dec 31 16:11:35 localhost kernel: Stack: df80bbf8 c3b25fbc 00000fd0 00000c00
>>000d8000 c3b25ef8 cd06de40 c0361b0b
>>Dec 31 16:11:35 localhost kernel: c06ccba0 c3b25fbc d5ce8000 00000c00
>>00000c00 00000c00 00000120 000001b1
>>Dec 31 16:11:35 localhost kernel: 00000008 c3b25f1c c06cd168 00000000
>>cd06de40 c037022a df80bbf8 c3b25f1c
>>Dec 31 16:11:35 localhost kernel: Call Trace:
>>Dec 31 16:11:35 localhost kernel: [show_stack+127/160]
>>Dec 31 16:11:35 localhost kernel: [show_registers+347/448]
>>Dec 31 16:11:35 localhost kernel: [die+256/384]
>>Dec 31 16:11:35 localhost kernel: [do_page_fault+1084/2083]
>>Dec 31 16:11:35 localhost kernel: [error_code+79/96]
>>Dec 31 16:11:35 localhost kernel: [bttv_buffer_risc+1371/1696]
>>Dec 31 16:11:35 localhost kernel: [bttv_prepare_buffer+268/464]
>>Dec 31 16:11:35 localhost kernel: [buffer_prepare+69/80]
>>Dec 31 16:11:35 localhost kernel: [videobuf_read_zerocopy+108/304]
>>Dec 31 16:11:35 localhost kernel: [videobuf_read_one+522/560]
>>Dec 31 16:11:35 localhost kernel: [bttv_read+272/352]
>>Dec 31 16:11:35 localhost kernel: [vfs_read+213/432]
>>Dec 31 16:11:35 localhost kernel: [sys_read+75/128]
>>Dec 31 16:11:35 localhost kernel: [syscall_call+7/11]
>>Dec 31 16:11:35 localhost kernel: Code: 00 0d 00 00 00 10 89 01 8b 43 08 83
>>c1 04 89 01 8b 43 0c 83 c1 04 83 c3 10 29 c2 8b 43 0c 39 c2 77 df 89 d0 89
>>d6 0d 00 00 00 14 <89> 01 8b 43 08 83 c1 04 89 01 83 c1 04 eb 8a 8d b4 26 00
>>00 00
> 
> 

Hi Sami,

That caused also a crash, i kept pressing the v key and within 15
seconds it crashed, then i saw the crash-info appear in the log and when
i clicked on mozilla then it crashed too but without crahs info and
system froze totally.

Below the crash info:

Dec 31 17:38:32 localhost kernel: Unable to handle kernel paging request
at virtual address c8111000
Dec 31 17:38:32 localhost kernel:  printing eip:
Dec 31 17:38:32 localhost kernel: c036037a
Dec 31 17:38:32 localhost kernel: *pgd = 21063
Dec 31 17:38:32 localhost kernel: *pmd = 21063
Dec 31 17:38:32 localhost kernel: *pte = 8111000
Dec 31 17:38:32 localhost kernel: Oops: 0002 [#4]
Dec 31 17:38:32 localhost kernel: SMP DEBUG_PAGEALLOC
Dec 31 17:38:32 localhost kernel: Modules linked in:
Dec 31 17:38:32 localhost kernel: CPU:    3
Dec 31 17:38:32 localhost kernel: EIP:
0060:[bttv_risc_packed+394/432]    Not tainted VLI
Dec 31 17:38:32 localhost kernel: EFLAGS: 00210202   (2.6.14.5)
Dec 31 17:38:32 localhost kernel: eax: 14000008   ebx: d3a09800   ecx:
c8111000   edx: 00000008
Dec 31 17:38:32 localhost kernel: esi: 00000008   edi: 000000ff   ebp:
d3c0be38   esp: d3c0be20
Dec 31 17:38:32 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 31 17:38:32 localhost kernel: Process xawtv (pid: 1703,
threadinfo=d3c0a000 task=cfba2aa0)
Dec 31 17:38:32 localhost kernel: Stack: df80bbf8 c6a5cfbc 00000fd0
00000c00 000d8000 c6a5cef8 d3c0be90 c0361b0b
Dec 31 17:38:32 localhost kernel:        c06ccba0 c6a5cfbc d3a08000
00000c00 00000c00 00000c00 00000120 000001b1
Dec 31 17:38:32 localhost kernel:        00000008 c6a5cf1c c06cd168
00000000 d3c0be90 c037022a df80bbf8 c6a5cf1c
Dec 31 17:38:32 localhost kernel: Call Trace:
Dec 31 17:38:32 localhost kernel:  [show_stack+127/160]
Dec 31 17:38:32 localhost kernel:  [show_registers+347/448]
Dec 31 17:38:32 localhost kernel:  [die+256/384]
Dec 31 17:38:32 localhost kernel:  [do_page_fault+1084/2083]
Dec 31 17:38:32 localhost kernel:  [error_code+79/96]
Dec 31 17:38:32 localhost kernel:  [bttv_buffer_risc+1371/1696]
Dec 31 17:38:32 localhost kernel:  [bttv_prepare_buffer+268/464]
Dec 31 17:38:32 localhost kernel:  [buffer_prepare+69/80]
Dec 31 17:38:32 localhost kernel:  [videobuf_read_zerocopy+108/304]
Dec 31 17:38:32 localhost kernel:  [videobuf_read_one+522/560]
Dec 31 17:38:32 localhost kernel:  [bttv_read+272/352]
Dec 31 17:38:32 localhost kernel:  [vfs_read+213/432]
Dec 31 17:38:32 localhost kernel:  [sys_read+75/128]
Dec 31 17:38:32 localhost kernel:  [syscall_call+7/11]
Dec 31 17:38:32 localhost kernel: Code: 00 0d 00 00 00 10 89 01 8b 43 08
83 c1 04 89 01 8b 43 0c 83 c1 04 83 c3 10 29 c2 8b 43 0c 39 c2 77 df 89
d0 89 d


