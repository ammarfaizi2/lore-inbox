Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSJXR7h>; Thu, 24 Oct 2002 13:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265588AbSJXR7g>; Thu, 24 Oct 2002 13:59:36 -0400
Received: from bitchcake.off.net ([216.138.242.5]:151 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S265587AbSJXR7d>;
	Thu, 24 Oct 2002 13:59:33 -0400
Date: Thu, 24 Oct 2002 14:05:46 -0400
From: Zach Brown <zab@zabbo.net>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Cc: arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024140546.Q12512@bitchcake.off.net>
References: <3DB82ABF.8030706@colorfullife.com> <1035481054.735.52.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035481054.735.52.camel@phantasy>; from rml@tech9.net on Thu, Oct 24, 2002 at 01:37:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2002-10-24 at 13:15, Manfred Spraul wrote:
> 
> > Attached is a test app that compares several memory copy implementations.
> > Could you run it and report the results to me, together with cpu, 
> > chipset and memory type?

CPU0: AMD Athlon(tm) MP 1800+ stepping 02

in a tyan tiger mpx (amd762 north bridge), two 512m non-buffered
pc2100 ddr sticks, in a mostly-idle dual workstation:

copy_page() tests 
copy_page function 'warm up run'	 took 16543 cycles per page
copy_page function '2.4 non MMX'	 took 18241 cycles per page
copy_page function '2.4 MMX fallback'	 took 18144 cycles per page
copy_page function '2.4 MMX version'	 took 16551 cycles per page
copy_page function 'faster_copy'	 took 10099 cycles per page
copy_page function 'even_faster'	 took 10218 cycles per page
copy_page function 'no_prefetch'	 took 9618 cycles per page

copy_page() tests 
copy_page function 'warm up run'	 took 16618 cycles per page
copy_page function '2.4 non MMX'	 took 18274 cycles per page
copy_page function '2.4 MMX fallback'	 took 18126 cycles per page
copy_page function '2.4 MMX version'	 took 16649 cycles per page
copy_page function 'faster_copy'	 took 10100 cycles per page
copy_page function 'even_faster'	 took 10219 cycles per page
copy_page function 'no_prefetch'	 took 9571 cycles per page

copy_page() tests 
copy_page function 'warm up run'	 took 16571 cycles per page
copy_page function '2.4 non MMX'	 took 18265 cycles per page
copy_page function '2.4 MMX fallback'	 took 18076 cycles per page
copy_page function '2.4 MMX version'	 took 16558 cycles per page
copy_page function 'faster_copy'	 took 10112 cycles per page
copy_page function 'even_faster'	 took 10207 cycles per page
copy_page function 'no_prefetch'	 took 9582 cycles per page

- z

