Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265613AbSJXTN7>; Thu, 24 Oct 2002 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265614AbSJXTN7>; Thu, 24 Oct 2002 15:13:59 -0400
Received: from quark.didntduck.org ([216.43.55.190]:15629 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S265613AbSJXTN5>; Thu, 24 Oct 2002 15:13:57 -0400
Message-ID: <3DB847DC.4090601@didntduck.org>
Date: Thu, 24 Oct 2002 15:19:56 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
References: <3DB82ABF.8030706@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations 
> instead of prefetch.
> 
> http://208.15.46.63/events/gdc2002.htm
> 
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 
> Please run 2 or 3 times.
> 

Athlon XP 1600+ (1400 MHz)
512 MB PC-133 memory
Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1410.668
cache size      : 256 KB

copy_page() tests
copy_page function 'warm up run'         took 21428 cycles per page
copy_page function '2.4 non MMX'         took 22404 cycles per page
copy_page function '2.4 MMX fallback'    took 22426 cycles per page
copy_page function '2.4 MMX version'     took 21472 cycles per page
copy_page function 'faster_copy'         took 13618 cycles per page
copy_page function 'even_faster'         took 13284 cycles per page
copy_page function 'no_prefetch'         took 11943 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 21640 cycles per page
copy_page function '2.4 non MMX'         took 22865 cycles per page
copy_page function '2.4 MMX fallback'    took 22843 cycles per page
copy_page function '2.4 MMX version'     took 21597 cycles per page
copy_page function 'faster_copy'         took 13751 cycles per page
copy_page function 'even_faster'         took 13407 cycles per page
copy_page function 'no_prefetch'         took 11952 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 21681 cycles per page
copy_page function '2.4 non MMX'         took 22900 cycles per page
copy_page function '2.4 MMX fallback'    took 22999 cycles per page
copy_page function '2.4 MMX version'     took 21679 cycles per page
copy_page function 'faster_copy'         took 13782 cycles per page
copy_page function 'even_faster'         took 13481 cycles per page
copy_page function 'no_prefetch'         took 11969 cycles per page



