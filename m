Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEVQv>; Fri, 5 Jan 2001 16:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRAEVQl>; Fri, 5 Jan 2001 16:16:41 -0500
Received: from pm3-3-46.apex.net ([209.250.40.206]:22790 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129267AbRAEVQe>; Fri, 5 Jan 2001 16:16:34 -0500
Date: Fri, 5 Jan 2001 15:16:43 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Chris Kloiber <ckloiber@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
Message-ID: <20010105151643.A4369@hapablap.dyn.dhs.org>
Mail-Followup-To: Chris Kloiber <ckloiber@rochester.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu> <3A55F6DB.24041B4C@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A55F6DB.24041B4C@rochester.rr.com>; from ckloiber@rochester.rr.com on Fri, Jan 05, 2001 at 11:31:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 11:31:23AM -0500, Chris Kloiber wrote:
> 
> Possibly related symptoms:
> 
> kernel 2.4.0-ac1 compiled with gcc version 2.96 20000731 (Red Hat Linux
> 7.0)
> 
> last 2 lines in dmesg output:
> mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000
> mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000
> 
> cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> reg01: base=0xd8000000 (3456MB), size=  16MB: write-combining, count=1
> reg05: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
>  
> 
> My video card is Voodoo3/3000/AGP and my motherboard is an MSI-6330
> (Athlon Tbird 800)
> I am experiencing text console video corruption. In tdfxfb mode or
> regular vesafb it looks like a horizontal line of color pixels that
> grows, in 'regular' text mode I get flashing characters or the font
> degrades into unreadable mess. X is fine.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

I can confirm these symptoms on my system with a Voodoo3/3000/PCI and a
SiS530 motherboard (AMD K6/2).  I get both the "mtrr: ... overlaps
existing ..." message some extent of the text corruption.  With VESA fb,
I get the random lines of colored pixels.  With tdfxfb, the most
noticable problem is that the cursor is several times larger than it
should be (like 1"x1").  Additionally, with the standard console, upon
switching from X, 1 or 2 cells with have randomly colored letters in
them, and some letters ("h" particularly) always appear incorrectly.

-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
