Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275342AbTHMUNC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275368AbTHMUNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:13:02 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:55457 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275342AbTHMUNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:13:00 -0400
Date: Wed, 13 Aug 2003 21:12:20 +0100
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813201220.GH12953@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel> <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365l17o70.fsf@oldwotan.suse.de> <1060778924.8008.39.camel@localhost.localdomain> <20030813131457.GD32290@wotan.suse.de> <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk> <20030813142055.GC9179@wotan.suse.de> <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk> <20030813163927.GE2184@redhat.com> <1060799674.9129.21.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060799674.9129.21.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 07:34:36PM +0100, Alan Cox wrote:
 > pre VIA Cyrixen have MMX and CXMMX. The CPU also set bit 31 but doesn't
 > have 3dnow (which fooled me but the kernel does know about). C3's seem
 > to have prefetch/prefetchw (but not prefetchnta). I don't have a nemeiah
 > but I assume Nemeiah has prefetchnta too ?

With Nehemiah, they dropped 3dnow, and went with SSE.

 > MMX:  Pentium (later only), Cyrix MediaGX (later only), Cyrix 6x86/MII
 >       Intel PII/PIII/PIV, AMD K6/Athlon/Opteron, VIA Cyrix III, VIA C3
 > CXMMX: Extended MMX - Cyrix MII/AMD K6(II+ ?)/K7/Opteron
 > 3DNOW: AMD K6-II/III(not original K6),K7/,Opteron, VIA Cyrix III, 
 > VIA C3 (pre Nemiah only ??)

"Nehemiah".
+ Winchip-2A (though as mentioned, prefetch is a nop, the rest of 3dnow worked
				though iirc).

 > "Enhanced" 3DNow: Athlon Tbird
 > SSE: Intel PII, PIII, Athlon (XP, Duron >=1Gz only)
 > SSE2: Pentium IV

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
