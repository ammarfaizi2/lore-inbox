Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275077AbTHNSs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275302AbTHNSsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:48:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:6238 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275077AbTHNSsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:48:18 -0400
Date: Thu, 14 Aug 2003 19:47:41 +0100
From: Dave Jones <davej@redhat.com>
To: Jonathan Morton <chromi@chromatix.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart failure on KT400
Message-ID: <20030814184741.GA10901@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jonathan Morton <chromi@chromatix.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <779ACC8A-CE86-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779ACC8A-CE86-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 07:38:15PM +0100, Jonathan Morton wrote:
 > I recently upgraded to a m/board using the KT400 chipset - specifically 
 > an Abit KD7-G - and now find that I can't load agpgart.  The relevant 
 > kernel messages:
 > 
 > agpgart: Maximum main memory to use for agp memory: 941M
 > agpgart: Detected Via Apollo Pro KT400 chipset
 > agpgart: unable to determine aperture size.
 > 
 > This results in my inability to load XFree86, using the proprietary ATI 
 > drivers, which appear to require AGP support.  Note that the same 
 > problem appears using ATI's "internal agpgart module", just to show I 
 > know the difference.  The regular XFree86 drivers probably work without 
 > AGP - I haven't bothered trying yet.
 > 
 > NB: I tried sending this to Jeff Hartmann, but his address at 
 > precisioninsight.com is dead.  Please CC me, I'm not subscribed to the 
 > list.  Better still, refer me to someone who actually knows what to do 
 > about it.
 > 
 > The BIOS is set up for either a 256MB or 64MB AGP aperture - whichever 
 > of the two settings makes no difference.  The video card is a Radeon 
 > 9700 Pro, 128MB.  The kernel configuration includes ACPI and 
 > HIGHMEM-4GB support, if that is at all relevant.
 > 
 > This problem is identically present in 2.4.21 and 2.4.22-rc2.

For 2.4, you're stuck. It needs AGP3 support. The KT400 stuff in
2.4 only works if you shove an AGP2.x gfx card in the slot.
As soon as you put a 3.x capable card in there the chipset changes
mode, and as there's no AGP3 support in 2.4 yet, you're pooched.

The code in 2.6test should work, but before you (or anyone else) asks,
no, it won't work without a bit of bending in 2.4, and I don't have
a backport, or plans to do so any time soon.

Sorry,

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
