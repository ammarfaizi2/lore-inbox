Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVLaQeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVLaQeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVLaQeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:34:17 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:17330 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964999AbVLaQeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:34:17 -0500
Date: Sat, 31 Dec 2005 18:34:14 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Message-ID: <20051231163414.GE3214@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200512310027.47757.s0348365@sms.ed.ac.uk> <43B5D3ED.3080504@ns666.com> <200512310051.03603.s0348365@sms.ed.ac.uk> <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B6A14E.1020703@ns666.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 04:18:38PM +0100, Mark v Wolher wrote:
...
> Here is new data, this time it had to do with bttv:
> 
> Dec 31 16:11:35 localhost kernel: Unable to handle kernel paging request at
> virtual address d162e000
> Dec 31 16:11:35 localhost kernel: printing eip:
> Dec 31 16:11:35 localhost kernel: c036037a
> Dec 31 16:11:35 localhost kernel: *pgd = 46063
> Dec 31 16:11:35 localhost kernel: *pmd = 46063
> Dec 31 16:11:35 localhost kernel: *pte = 1162e000
> Dec 31 16:11:35 localhost kernel: Oops: 0002 [#1]
> Dec 31 16:11:35 localhost kernel: SMP DEBUG_PAGEALLOC
> Dec 31 16:11:35 localhost kernel: Modules linked in: nv
> Dec 31 16:11:35 localhost kernel: CPU:    2
> Dec 31 16:11:35 localhost kernel: EIP:    0060:[bttv_risc_packed+394/432]

Can you try how many seconds it takes to get Oops/crash when you start
pressing 'v' in xawtv (video capture on/off).
For me, not very many.

This happens with every 2.6 kernel.  And my hardware is OK.

> Not tainted VLI
> Dec 31 16:11:35 localhost kernel: EFLAGS: 00210202   (2.6.14.5)
> Dec 31 16:11:35 localhost kernel: eax: 14000008   ebx: d5ce9800   ecx:
> d162e000   edx: 00000008
> Dec 31 16:11:35 localhost kernel: esi: 00000008   edi: 000000ff   ebp:
> cd06dde8   esp: cd06ddd0
> Dec 31 16:11:35 localhost kernel: ds: 007b   es: 007b   ss: 0068
> Dec 31 16:11:35 localhost kernel: Process xawtv (pid: 31110,
> threadinfo=cd06c000 task=ca871aa0)
> Dec 31 16:11:35 localhost kernel: Stack: df80bbf8 c3b25fbc 00000fd0 00000c00
> 000d8000 c3b25ef8 cd06de40 c0361b0b
> Dec 31 16:11:35 localhost kernel: c06ccba0 c3b25fbc d5ce8000 00000c00
> 00000c00 00000c00 00000120 000001b1
> Dec 31 16:11:35 localhost kernel: 00000008 c3b25f1c c06cd168 00000000
> cd06de40 c037022a df80bbf8 c3b25f1c
> Dec 31 16:11:35 localhost kernel: Call Trace:
> Dec 31 16:11:35 localhost kernel: [show_stack+127/160]
> Dec 31 16:11:35 localhost kernel: [show_registers+347/448]
> Dec 31 16:11:35 localhost kernel: [die+256/384]
> Dec 31 16:11:35 localhost kernel: [do_page_fault+1084/2083]
> Dec 31 16:11:35 localhost kernel: [error_code+79/96]
> Dec 31 16:11:35 localhost kernel: [bttv_buffer_risc+1371/1696]
> Dec 31 16:11:35 localhost kernel: [bttv_prepare_buffer+268/464]
> Dec 31 16:11:35 localhost kernel: [buffer_prepare+69/80]
> Dec 31 16:11:35 localhost kernel: [videobuf_read_zerocopy+108/304]
> Dec 31 16:11:35 localhost kernel: [videobuf_read_one+522/560]
> Dec 31 16:11:35 localhost kernel: [bttv_read+272/352]
> Dec 31 16:11:35 localhost kernel: [vfs_read+213/432]
> Dec 31 16:11:35 localhost kernel: [sys_read+75/128]
> Dec 31 16:11:35 localhost kernel: [syscall_call+7/11]
> Dec 31 16:11:35 localhost kernel: Code: 00 0d 00 00 00 10 89 01 8b 43 08 83
> c1 04 89 01 8b 43 0c 83 c1 04 83 c3 10 29 c2 8b 43 0c 39 c2 77 df 89 d0 89
> d6 0d 00 00 00 14 <89> 01 8b 43 08 83 c1 04 89 01 83 c1 04 eb 8a 8d b4 26 00
> 00 00

-- 
