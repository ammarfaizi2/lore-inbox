Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRDPUwO>; Mon, 16 Apr 2001 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132072AbRDPUvz>; Mon, 16 Apr 2001 16:51:55 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:2057
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132057AbRDPUvn>; Mon, 16 Apr 2001 16:51:43 -0400
Date: Mon, 16 Apr 2001 13:51:15 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <3ADB5720.208150E8@gmx.at>
Message-ID: <Pine.LNX.4.10.10104161350190.19043-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wilfried,

Why a module?
Why not have the detection and flags that hook the md driver for linux and
use linux's software raid?

Cheers,

On Mon, 16 Apr 2001, Wilfried Weissmann wrote:

> Arjan van de Ven wrote:
> > 
> > In article <3AD6B422.EEC092F0@ftel.co.uk> you wrote:
> > > Andre Hedrick wrote:
> > 
> > > However as far as I can see everyone who has a FastTrak which is "stuck"
> > > in RAID mode[1] would be happy if it worked as a normal IDE controller
> > > in Linux, which is (usually?) not the case - eg on the MSI board where
> > > only the first channel is seen.
> > 
> > I have a patch to work around that. However the better solution would be to
> > have a native driver for the raid; I plan to start working on that next
> > week...
> 
> I am doing the same for the HighPoint-Tech 370 (talking about the RAID driver). Disk-striping is
> working so far. My code is based on the kernel patches for MDs from Neil Brown. I created an own
> RAID-personality for the module.
> When I looked at the FreeBSD implementation I had the idea of making a "supermodule" which could
> contain serveral IDE-RAID drivers (e.g.: Proise FastTrack + HPT370). There would be a super
> personality for ATA-RAID and several low-level drivers for the individual controllers.
> 
> Interrested? Ideas? Hints, Tips, ...? Wanna team up? <8)
> 
> > 
> > Greetings,
> >   Arjan van de Ven
> 
> regards,
> Wilfried
> 
> PS: An uppercase THANX goes to Nail Brown!
> 
> -- 
> Wilfried Weissmann ( mailto:Wilfried.Weissmann@gmx.at )
> Mobile: +43 676 9444465
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

