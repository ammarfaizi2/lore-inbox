Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbTCAGLn>; Sat, 1 Mar 2003 01:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268515AbTCAGLn>; Sat, 1 Mar 2003 01:11:43 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:11908 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S268514AbTCAGLm>; Sat, 1 Mar 2003 01:11:42 -0500
Date: Fri, 28 Feb 2003 22:22:00 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: kernel BUG at mm/memory.c:757! (2.5.62-mjb2)
Message-ID: <20030301062200.GA4523@gnuppy.monkey.org>
References: <4450000.1045526067@flay> <4610000.1045583440@[10.10.2.4]> <20030223034730.GA3136@gnuppy.monkey.org> <20030223035048.GA3223@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223035048.GA3223@gnuppy.monkey.org>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 07:50:48PM -0800, Bill Huey wrote:
> > Feb 22 04:02:08 gnuppy kernel:  ------------[ cut here ]------------
> > Feb 22 04:02:08 gnuppy kernel: kernel BUG at mm/memory.c:757!
> > Feb 22 04:02:08 gnuppy kernel: invalid operand: 0000
> > Feb 22 04:02:08 gnuppy kernel: CPU:    0
> > Feb 22 04:02:08 gnuppy kernel: EIP:    0060:[unmap_all_pages+757/832] Tainted: PF 
> > Feb 22 04:02:08 gnuppy kernel: EFLAGS: 00210202
> > Feb 22 04:02:08 gnuppy kernel: EIP is at unmap_all_pages+0x2f5/0x340
> > Feb 22 04:02:08 gnuppy kernel: eax: 00000001   ebx: 0f7a8067   ecx: d612c360   edx: c039f4a0
> > Feb 22 04:02:08 gnuppy kernel: esi: c0000000   edi: d1152ffc   ebp: d122ff58   esp: d122fed8
> > Feb 22 04:02:08 gnuppy kernel: ds: 007b   es: 007b   ss: 0068
> > Feb 22 04:02:08 gnuppy kernel: Process xchat (pid: 743, threadinfo=d122e000 task=d12512a0)
> > Feb 22 04:02:08 gnuppy kernel: Stack: d122ff0c 00000000 00000010 d12512a0 c126b240 c0000000 c0000000 c0000000 
> > Feb 22 04:02:08 gnuppy kernel:        0000000c c12ab4d0 d1971c00 d1971c00 00000000 c1289920 c1274318 c12765a0 
> > Feb 22 04:02:08 gnuppy kernel:        c12b7190 c1267de8 c1269cb0 c126b9e8 c126a098 c128a320 c126acf0 c126af98 
> > Feb 22 04:02:08 gnuppy kernel: Call Trace:
> > Feb 22 04:02:08 gnuppy kernel:  [exit_mmap+24/224] exit_mmap+0x18/0xe0
> > Feb 22 04:02:08 gnuppy kernel:  [mmput+85/176] mmput+0x55/0xb0
> > Feb 22 04:02:08 gnuppy kernel:  [do_exit+273/768] do_exit+0x111/0x300
> > Feb 22 04:02:08 gnuppy kernel:  [do_group_exit+123/192] do_group_exit+0x7b/0xc0
> > Feb 22 04:02:08 gnuppy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> > Feb 22 04:02:08 gnuppy kernel: 
> > Feb 22 04:02:08 gnuppy kernel: Code: 0f 0b f5 02 9f ab 34 c0 b8 00 e0 ff ff 8b 55 08 21 e0 8b 00 
> > Feb 22 04:02:11 gnuppy kernel:  ------------[ cut here ]------------
> 
> I just found out that it could likely be related to the NVidia driver module
> from Rik van Riel. Ooops.

Again, correction, I get a tons of these even without the NVidia driver
module, so that's not the problem.

This problem is still pretty live unfortunately. Fixed in the new patchset ?

The problem doesn't seems fatal and the machine doesn't crash hard, but it's
still a bug.

Thanks

bill

