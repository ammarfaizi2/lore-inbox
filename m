Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265585AbSJXS2P>; Thu, 24 Oct 2002 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265590AbSJXS2O>; Thu, 24 Oct 2002 14:28:14 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62090 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265585AbSJXS2K>;
	Thu, 24 Oct 2002 14:28:10 -0400
Date: Thu, 24 Oct 2002 19:36:00 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024183600.GA10584@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:
 > AMD recommends to perform memory copies with backward read operations 
 > instead of prefetch.
 > 
 > http://208.15.46.63/events/gdc2002.htm
 > 
 > Attached is a test app that compares several memory copy implementations.
 > Could you run it and report the results to me, together with cpu, 
 > chipset and memory type?

processor	: 0
vendor_id	: AuthenticAMD
cpu family      : 6
model   	: 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 800.034
cache size      : 512 KB

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 12570 cycles per page
copy_page function '2.4 non MMX'	 took 18763 cycles per page
copy_page function '2.4 MMX fallback'    took 18764 cycles per page
copy_page function '2.4 MMX version' 	 took 12564 cycles per page
copy_page function 'faster_copy'     	 took 8001 cycles per page 
copy_page function 'even_faster'     	 took 7362 cycles per page 
copy_page function 'no_prefetch'     	 took 7536 cycles per page 

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 12583 cycles per page
copy_page function '2.4 non MMX'	 took 18768 cycles per page
copy_page function '2.4 MMX fallback'    took 21556 cycles per page
copy_page function '2.4 MMX version'     took 12636 cycles per page
copy_page function 'faster_copy'         took 7375 cycles per page 
copy_page function 'even_faster'         took 7368 cycles per page 
copy_page function 'no_prefetch'         took 7552 cycles per page 

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'	 took 12562 cycles per page
copy_page function '2.4 non MMX'	 took 18755 cycles per page
copy_page function '2.4 MMX fallback'    took 21687 cycles per page
copy_page function '2.4 MMX version'     took 12604 cycles per page
copy_page function 'faster_copy'         took 7358 cycles per page 
copy_page function 'even_faster'         took 7356 cycles per page 
copy_page function 'no_prefetch'         took 7566 cycles per page 


00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)

Memory type is unbranded PC133 SDRAM

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
