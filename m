Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132046AbRDPU1v>; Mon, 16 Apr 2001 16:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132053AbRDPU1l>; Mon, 16 Apr 2001 16:27:41 -0400
Received: from pop.gmx.net ([194.221.183.20]:50791 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132046AbRDPU1Y>;
	Mon, 16 Apr 2001 16:27:24 -0400
Message-ID: <3ADB5720.208150E8@gmx.at>
Date: Mon, 16 Apr 2001 22:33:36 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>
CC: Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <m14o9LX-000Od4C@amadeus.home.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> In article <3AD6B422.EEC092F0@ftel.co.uk> you wrote:
> > Andre Hedrick wrote:
> 
> > However as far as I can see everyone who has a FastTrak which is "stuck"
> > in RAID mode[1] would be happy if it worked as a normal IDE controller
> > in Linux, which is (usually?) not the case - eg on the MSI board where
> > only the first channel is seen.
> 
> I have a patch to work around that. However the better solution would be to
> have a native driver for the raid; I plan to start working on that next
> week...

I am doing the same for the HighPoint-Tech 370 (talking about the RAID driver). Disk-striping is
working so far. My code is based on the kernel patches for MDs from Neil Brown. I created an own
RAID-personality for the module.
When I looked at the FreeBSD implementation I had the idea of making a "supermodule" which could
contain serveral IDE-RAID drivers (e.g.: Proise FastTrack + HPT370). There would be a super
personality for ATA-RAID and several low-level drivers for the individual controllers.

Interrested? Ideas? Hints, Tips, ...? Wanna team up? <8)

> 
> Greetings,
>   Arjan van de Ven

regards,
Wilfried

PS: An uppercase THANX goes to Nail Brown!

-- 
Wilfried Weissmann ( mailto:Wilfried.Weissmann@gmx.at )
Mobile: +43 676 9444465
