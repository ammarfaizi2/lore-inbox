Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275346AbTHMTkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275349AbTHMTkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:40:35 -0400
Received: from rosdorff.xs4all.nl ([213.84.29.108]:15373 "EHLO
	rosdorff.xs4all.nl") by vger.kernel.org with ESMTP id S275346AbTHMTkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:40:25 -0400
Date: Wed, 13 Aug 2003 21:40:19 +0200 (CEST)
From: Coen Rosdorff <coen@rosdorff.dyndns.org>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM: killing process amavis
In-Reply-To: <Pine.LNX.4.44.0308131633420.2029-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0308132119140.4138-100000@rosdorff.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Hugh Dickins wrote:

> It really would be worth giving memtest86 a good long run.
> 
> 02000000 looks very much like a single-bit memory error,
> and swap_free is exactly where such errors often show up.

I had the same problem before on the previous server. Running memtest for 
19 days didn't showed any memory problems.

After replacing the motherboard cpu and ram, now I have the same problem.

Previous motherboard:
swap_free: Unused swap offset entry 00000100

Apr 26 09:40:05 rosdorff kernel: kernel BUG at dcache.c:345!
Apr 26 09:40:05 rosdorff kernel: invalid operand: 0000
Apr 26 09:40:05 rosdorff kernel: CPU:    0
Apr 26 09:40:05 rosdorff kernel: EIP:    0010:[<c0141764>]    Not tainted
Apr 26 09:40:05 rosdorff kernel: EFLAGS: 00010206
Apr 26 09:40:05 rosdorff kernel: eax: 00000100   ebx: c17a8958   ecx: c1127f84   edx: c17a89d8
Apr 26 09:40:05 rosdorff kernel: esi: c17a8940   edi: 0000064d   ebp: 00000113   esp: c1147f20
Apr 26 09:40:05 rosdorff kernel: ds: 0018   es: 0018   ss: 0018
Apr 26 09:40:05 rosdorff kernel: Process kswapd (pid: 4, stackpage=c1147000)

May 11 14:40:05 rosdorff kernel: kernel BUG at dcache.c:345!
May 11 14:40:05 rosdorff kernel: invalid operand: 0000
May 11 14:40:05 rosdorff kernel: CPU:    0
May 11 14:40:05 rosdorff kernel: EIP:    0010:[<c0141b84>]    Not tainted
May 11 14:40:05 rosdorff kernel: EFLAGS: 00010206
May 11 14:40:05 rosdorff kernel: eax: 00000100   ebx: c17a8958   ecx: c1127f84   edx: c4d2a6d8
May 11 14:40:05 rosdorff kernel: esi: c17a8940   edi: 000011aa   ebp: 0000021b   esp: c114bf20
May 11 14:40:05 rosdorff kernel: ds: 0018   es: 0018   ss: 0018
May 11 14:40:05 rosdorff kernel: Process kswapd (pid: 4, stackpage=c114b000)

Jun 18 05:00:06 rosdorff kernel: kernel BUG at dcache.c:345!
Jun 18 05:00:06 rosdorff kernel: invalid operand: 0000
Jun 18 05:00:06 rosdorff kernel: CPU:    0
Jun 18 05:00:06 rosdorff kernel: EIP:    0010:[<c0141264>]    Not tainted
Jun 18 05:00:06 rosdorff kernel: EFLAGS: 00010206
Jun 18 05:00:06 rosdorff kernel: eax: 00000100   ebx: c17a8958   ecx: c110ff84   edx: c17a89d8
Jun 18 05:00:06 rosdorff kernel: esi: c17a8940   edi: 000019c1   ebp: 00000393   esp: c1163f20
Jun 18 05:00:06 rosdorff kernel: ds: 0018   es: 0018   ss: 0018
Jun 18 05:00:06 rosdorff kernel: Process kswapd (pid: 4, stackpage=c1163000)


Current motherboard:
Jul  8 08:31:53 rosdorff kernel: memory.c:100: bad pmd 02000000

Jul 15 04:05:16 rosdorff kernel: Unable to handle kernel paging request at virtual address 02000000
Jul 15 04:05:16 rosdorff kernel:  printing eip:
Jul 15 04:05:16 rosdorff kernel: c0131614
Jul 15 04:05:16 rosdorff kernel: *pde = 00000000
Jul 15 04:05:16 rosdorff kernel: Oops: 0002
Jul 15 04:05:16 rosdorff kernel: CPU:    0
Jul 15 04:05:16 rosdorff kernel: EIP:    0010:[<c0131614>]    Not tainted
Jul 15 04:05:16 rosdorff kernel: EFLAGS: 00010256
Jul 15 04:05:16 rosdorff kernel: eax: 00000000   ebx: c36cf3e0   ecx: c36cf3e0   edx: 02000000
Jul 15 04:05:16 rosdorff kernel: esi: c36cf3e0   edi: c36cf3e0   ebp: c11b5970   esp: c136df00
Jul 15 04:05:16 rosdorff kernel: ds: 0018   es: 0018   ss: 0018
Jul 15 04:05:16 rosdorff kernel: Process kswapd (pid: 4, stackpage=c136d000)

Aug 13 10:12:51 rosdorff kernel: VM: killing process amavis
Aug 13 10:12:51 rosdorff kernel: swap_free: Unused swap offset entry 02000000


So the problem moved from 00000100 to 02000000

The networkcards and the 3ware raid controler moved form the old to the 
new box. Could one of them be the problem?

I am running out of options.


TIA,
Coen Rosdorff

