Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265584AbSJXSLe>; Thu, 24 Oct 2002 14:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265585AbSJXSLe>; Thu, 24 Oct 2002 14:11:34 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:59596 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S265584AbSJXSLc>;
	Thu, 24 Oct 2002 14:11:32 -0400
Date: Thu, 24 Oct 2002 20:17:44 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, <arjanv@redhat.com>
Subject: Re: [CFT] faster athlon/duron memory copy implementation
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0210242013400.9648-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Oct 2002, Manfred Spraul wrote:
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu,
> chipset and memory type?

vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 841.223  <--- 8 * 105MHz FSB
cache size	: 64 KB

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)

Memory: 256 + 128Mb PC133 SDRAM


Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 18450 cycles per page
copy_page function '2.4 non MMX'	 took 22432 cycles per page
copy_page function '2.4 MMX fallback'	 took 22448 cycles per page
copy_page function '2.4 MMX version'	 took 17096 cycles per page
copy_page function 'faster_copy'	 took 11092 cycles per page
copy_page function 'even_faster'	 took 10770 cycles per page
copy_page function 'no_prefetch'	 took 10323 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 17674 cycles per page
copy_page function '2.4 non MMX'	 took 21895 cycles per page
copy_page function '2.4 MMX fallback'	 took 21774 cycles per page
copy_page function '2.4 MMX version'	 took 17683 cycles per page
copy_page function 'faster_copy'	 took 10954 cycles per page
copy_page function 'even_faster'	 took 10697 cycles per page
copy_page function 'no_prefetch'	 took 10309 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 17985 cycles per page
copy_page function '2.4 non MMX'	 took 22498 cycles per page
copy_page function '2.4 MMX fallback'	 took 21063 cycles per page
copy_page function '2.4 MMX version'	 took 17415 cycles per page
copy_page function 'faster_copy'	 took 12003 cycles per page
copy_page function 'even_faster'	 took 11297 cycles per page
copy_page function 'no_prefetch'	 took 10440 cycles per page

Eric


