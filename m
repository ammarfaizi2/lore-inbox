Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266993AbSKLWth>; Tue, 12 Nov 2002 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSKLWtg>; Tue, 12 Nov 2002 17:49:36 -0500
Received: from CPE-144-132-192-174.nsw.bigpond.net.au ([144.132.192.174]:41095
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S266993AbSKLWtf>; Tue, 12 Nov 2002 17:49:35 -0500
Date: Wed, 13 Nov 2002 06:41:10 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: Priit Laes <amd@tt.ee>
Cc: Linux-kernel@vger.kernel.org, "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: GA-7VRXP is a bad motherboard [was Re: PDC20276 Linux driver]
Message-ID: <20021112224110.GA16721@anakin.wychk.org>
References: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.21.0211121649360.9631-100000@esentar.trinityteam.it> <20021112165309.GB12789@anakin.wychk.org> <1037133511.7047.12.camel@plokta.s8.com> <20021112211329.GB32036@amd-laptop.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <20021112211329.GB32036@amd-laptop.mshome.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan, Priit,

On Tue, Nov 12, 2002 at 11:13:29PM +0200, Priit Laes wrote:
> Bryan O'Sullivan (bos@serpentine.com) wrote:
> > On Tue, 2002-11-12 at 08:53, Geoffrey Lee wrote:
> > 
> > > Board is a Gigabyte GA-7VRXP which has an on-board Promise 20276.
> > 
> > The GA-7VRXP is a known bad motherboard.  It has a bad electrical
> > interface to the AGP slot, so if you're using an AGP graphics card
> > without falling back to PCI access, you are pretty much guaranteed
> > system hangs or crashes after some time, depending on load.
> > 
> > This is an issue I confirmed with AMD several (six?) months ago.  I
> > don't know of any workarounds that maintain decent graphics performance,
> > and last I checked, Gigabyte had not acknowledged the problem.
> > 
> > Either drop your video card back to not using AGP, or buy a replacement
> > motherboard.
> Well actually Gigabyte systems are aware of this bug...
> According to: www.thetechboard.com (original page has disappeared):
> 
> A good number of 1.0 versions of this motherboard barely worked at all
> with GeForce4 cards. Stability was unheard of."
> 


We do not have a GeForce4 card in there, but we do indeed have an AGP
card in there.  It is a S3 ViRGE.

I will try disabling the AGP and see what happens.

I will say, though, that the stuck processes we have seen appear to be
doing disk I/O in the /home partition (which is disk mirrored with the
PDC driver), and apart from that, it seemed to be quite stable.  If a 
"crash" or a "hang" is described as getting a stuck process in disk I/O
because of some freak accident that getting an inode pointer can be
invalid, then yes, otherwise, no.


> The 1.1 version of this board would sometimes work and sometimes not
> work. Odds are better of getting a functioning board, but if you have
> this version of the board and your GeForce4 card does NOT work,
> increasing the VCore voltage by +7.5 in the BIOS can help. The side
> effect of this can lead to higher temperatures causing a whole new batch
> of problems. Better cooling solutions (like a Volcano7 or Coolermaster
> Heatpipe AT MINIMUM) can pacify the heat issues, but I feel that long
> term usage at this high of a voltage will cause inevitable failure.
>


We do have a cooler master on the CPU fitted on with enough paste.  I thought
was the heat too, so we took it out of the server cabinet and let it stand
in the open.  Unfortuantely, we got stuck processes in disk I/O after 
a while as well.  Actually, even in the server cabinet, it is not that
hot.


> After calling Gigabyte (you would think that they should call me knowing
> that they sent me a few hundred motherboards with a "known issue")
> because I was growing very tired of all of the tech calls I was
> receiving about the board's stability issues with the GeForce4 card, I
> was told that the boards needed to be reworked. Older boards were being
> "updated" by adding a 4.7uF capacitor between the VR at Q36 and a spot
> on the board where a surface mounted capacitor could go (but isn't
> installed) at C139. A new revision (2.0) with a resistor (labeled R833)
> added is already in production and being shipped.
> 
> I've(www.thetechboard.com) already tested the 2.0 version of the board with a PowerColor brand Ti 4200 128MB DDR and things do seem to be considerably better.
> "
> Hope this helps...


I see.

I will call Gigabyte to see what are the odds of getting it fixed.  But
surely, if it was a hardware problem, others would have experienced
similar issues too (processes stuck in disk I/O uninterruptible sleep)?
I did search before, and don't recall finding similar issues.


	-- G.
-- 
char *p = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";


