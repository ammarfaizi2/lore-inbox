Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310150AbSCKPBw>; Mon, 11 Mar 2002 10:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSCKPBn>; Mon, 11 Mar 2002 10:01:43 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:2972 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S310141AbSCKPB3>; Mon, 11 Mar 2002 10:01:29 -0500
Date: Mon, 11 Mar 2002 15:01:22 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Tony Hoyle <tmh@nothing-on.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dog slow IDE
In-Reply-To: <3C8CB3EB.8070704@nothing-on.tv>
Message-ID: <Pine.LNX.4.44.0203111451260.17324-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Just a me too earlier today with 2.4.19-pre2-ac4, on a dual celeron
440BX-based system.

Im my case, I have 3 hdds in a raid-5, hda, hdb, and hdc.

hda and hdb were both performing as expected 18-22MB/sec.  hdc was 
down at the 1.8-2.2MB/sec - even after trying to use hdparm to reset
the drive transfer rates (-p, -d1 -X66, -d0 -X12 (to try pio) etc).

None of the attempts using hdparm altered the hdc transfer rate in any
noticable fashion.  I powered down the machine, and on reboot, the hdc
transfer rate returned to the expected range 18-22MB/sec), and the
raid performance went up to it's usual level from the 5MB/sec it was
showing.

I couldn't see any reason for the odd behaviour, and I had put it down
to 'just one of those things' as the 3 or 4 test reboots since haven't
produced the strangely low-transfer rate again.

Cheers,

Mark

On Mon, 11 Mar 2002, Tony Hoyle wrote:

> For some reason the my IDE is running extremely slow (which accounts for 
> why this box feels so sluggish).

<snip>

> However:
> 
> /dev/hda:
>   Timing buffered disk reads:  64 MB in 16.27 seconds =  3.93 MB/sec
> 
> /dev/hdb:
>   Timing buffered disk reads:  64 MB in 32.99 seconds =  1.94 MB/sec
> 
> 1.94MB/sec is *way* to slow for a UDMA5 hard disk surely?

Yes.  On another system, I pull 35-40MB/sec off each individual
barracuda IV drive, and 50+ from the combined raid array (I assume PCI 
bandwidth limited, as twiddling BIOS PCI settings boosted this from 41 
to 50).

Regards,

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

