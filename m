Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSL0PFo>; Fri, 27 Dec 2002 10:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSL0PFo>; Fri, 27 Dec 2002 10:05:44 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:23561 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S264963AbSL0PFm>; Fri, 27 Dec 2002 10:05:42 -0500
Date: Fri, 27 Dec 2002 07:13:53 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
Message-ID: <20021227071353.A4614@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1040815160.533.6.camel@devcon-x> <20021225115820.GB7348@louise.pinerecords.com> <20021226123710.GA2442@iapetus.localdomain> <1040994876.518.13.camel@devcon-x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1040994876.518.13.camel@devcon-x>; from mikael@netgineers.se on Fri, Dec 27, 2002 at 02:14:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 02:14:45PM +0100, Mikael Olenfalk wrote:
> I can only set UDMA3,4,5 if I pass the ide{1,2}=ata66 kernel boot
> parameter. Actually I don't really care that much about the speed for
> now, I would rather like the thing to work at all :)
> 
> The PDC20268 sporadically gives me DMA errors when doing the first
> parity sync of my software RAID5. The last few times it has always been
> the same disk, but that is no requirement (sometimes hde 02:00, hdg
> 03:00, not so often one of the slave disks on the channel).
> 
> But the only system seems to be that It either always bails out at
> 30-36% percent of the parity sync or in case it does not bail out the
> speed goes down to 60-80kB/sec, which will finish the sync after 16,000
> or so minutes (definitely too long).
> 
> I thought of returning the IBM drives and getting MAXTOR instead, as I
> have heard rumors about the bad quality of the IBM drives. Still this
> seems to be a problem with the controller and/or in combination with MD.
> The drives gives me NO problems when just writing and/or reading them
> with dd if=/dev/zero of=/dev/hd[efgh]. Even running the bonnie++
> benchmark on them with a 20GB file gives no errors (simultaneously).

I'm a bit suprised noone else has mentioned this so i will.
Your RAID description seems to indicate it is built of four
drives on a two channel HBA.  In other words you have two
pairs of drives each pair sharing a cable (master/slave).
It is my understanding that that is at best a recepe for
poor performance.  From what i have heard ata66 and above is
problematic (out of spec) in that configuration.  I imagine
such a configuration might also cause poor interactions
between the drives.  

Aside from the reputed problems with PDC and with the IBM
"deathstar" drives you might first try adding another HBA
and use better cables before you scrap the drives.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
