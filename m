Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265607AbSJXSm3>; Thu, 24 Oct 2002 14:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265609AbSJXSm3>; Thu, 24 Oct 2002 14:42:29 -0400
Received: from [217.7.64.198] ([217.7.64.198]:1718 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id <S265607AbSJXSm1>;
	Thu, 24 Oct 2002 14:42:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Date: Thu, 24 Oct 2002 20:48:36 +0200
User-Agent: KMail/1.4.3
Cc: arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com>
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210242048.36859.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 24. Oktober 2002 19:15, Manfred Spraul wrote:

> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu,
> chipset and memory type?
>
> Please run 2 or 3 times.

CPU: AMD Athlon(tm) XP 1800+ stepping 02
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3116
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
512 MB DDR266 (Mem FSB changed to 100MHz due to memory problems)

copy_page() tests
copy_page function 'warm up run'         took 20103 cycles per page
copy_page function '2.4 non MMX'         took 22612 cycles per page
copy_page function '2.4 MMX fallback'    took 22585 cycles per page
copy_page function '2.4 MMX version'     took 20088 cycles per page
copy_page function 'faster_copy'         took 12198 cycles per page
copy_page function 'even_faster'         took 12266 cycles per page
copy_page function 'no_prefetch'         took 9244 cycles per page
earny@dev:~/x> ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 20051 cycles per page
copy_page function '2.4 non MMX'         took 22580 cycles per page
copy_page function '2.4 MMX fallback'    took 22610 cycles per page
copy_page function '2.4 MMX version'     took 20124 cycles per page
copy_page function 'faster_copy'         took 12276 cycles per page
copy_page function 'even_faster'         took 12262 cycles per page
copy_page function 'no_prefetch'         took 9213 cycles per page
earny@dev:~/x> ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 20150 cycles per page
copy_page function '2.4 non MMX'         took 22646 cycles per page
copy_page function '2.4 MMX fallback'    took 22638 cycles per page
copy_page function '2.4 MMX version'     took 20073 cycles per page
copy_page function 'faster_copy'         took 12191 cycles per page
copy_page function 'even_faster'         took 12261 cycles per page
copy_page function 'no_prefetch'         took 9218 cycles per page

------------------

Wow!

<Earny>
