Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314587AbSEFQ42>; Mon, 6 May 2002 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314583AbSEFQ41>; Mon, 6 May 2002 12:56:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28992 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314587AbSEFQ40>; Mon, 6 May 2002 12:56:26 -0400
Date: Mon, 6 May 2002 18:57:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Matteo Fago <fago@venere.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with SuperMicro s2qr6
Message-ID: <20020506185731.E31998@dualathlon.random>
In-Reply-To: <003601c1f51c$15241460$1f01a8c0@venere.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 06:35:49PM +0200, Matteo Fago wrote:
> Apr 29 04:03:46 pegaso kernel: Unable to handle kernel paging request at
> virtual address 51c0347a
> Apr 29 04:03:46 pegaso kernel: c0117d1e
> Apr 29 04:03:46 pegaso kernel: *pde = 00000000
> Apr 29 04:03:46 pegaso kernel: Oops: 0000
> Apr 29 04:03:46 pegaso kernel: CPU:    2
> Apr 29 04:03:46 pegaso kernel: EIP:    0010:[__wake_up+46/256]    Not
> tainted
> Apr 29 04:03:46 pegaso kernel: EIP:    0010:[<c0117d1e>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Apr 29 04:03:46 pegaso kernel: EFLAGS: 00010002
> Apr 29 04:03:46 pegaso kernel: eax: ccf4166c   ebx: c1891770   ecx: 00000001
> edx: 00000003
> Apr 29 04:03:46 pegaso kernel: esi: 51c0347a   edi: 00000803   ebp: e0e51d80
> esp: e0e51d64
> Apr 29 04:03:46 pegaso kernel: ds: 0018   es: 0018   ss: 0018
> Apr 29 04:03:46 pegaso kernel: Process updatedb (pid: 2974,
> stackpage=e0e51000)
> Apr 29 04:03:46 pegaso kernel: Stack: 00000001 00000286 00000003 ccf4166c
> c1891770 00001000 00000803 003
> d8572
> Apr 29 04:03:46 pegaso kernel:        c0143714 c1891770 00000803 003d8573
> 00001000 00000000 e0e50000 000
> 00803
> Apr 29 04:03:46 pegaso kernel:        00001000 c01413b2 00000803 003d8572
> 00001000 ed782a60 00000000 000
> 00000
> Apr 29 04:03:46 pegaso kernel: Call Trace: [grow_buffers+212/256]
> [getblk+98/112] [ext3_getblk+189/704]
> Apr 29 04:03:46 pegaso kernel: Call Trace: [<c0143714>] [<c01413b2>]
> [<c01661dd>] [<c013643c>] [<c012f0f
> Apr 29 04:03:47 pegaso kernel:    [<c0167d94>] [<c0166402>] [<c0163ded>]
> [<c01522fc>] [<c012765e>] [<c01
> 49489>]
> Apr 29 04:03:47 pegaso kernel:    [<c014abb8>] [<c014e460>] [<c014e014>]
> [<c014e460>] [<c014e5ef>] [<c01
> 4e460>]
> Apr 29 04:03:47 pegaso kernel:    [<c013e196>] [<c0108b0b>]
> Apr 29 04:03:47 pegaso kernel: Code: 8b 16 e9 a0 00 00 00 8b 5e fc 8b 03 85
> 45 ec 0f 84 8c 00 00

Well, the first guess is that the ram is bad, or that it's a driver bug,
unfortunately with just the above oops it's hard to tell, the real bug
is going to be miles away from grow_buffers and wake-up.  Did you tried
memtest86 or cerberus? (both can report bitflips in memory)

Andrea
