Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319023AbSHMN7K>; Tue, 13 Aug 2002 09:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319024AbSHMN7K>; Tue, 13 Aug 2002 09:59:10 -0400
Received: from brynhild.MtRoyal.AB.CA ([142.109.10.24]:12675 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S319023AbSHMN7I>; Tue, 13 Aug 2002 09:59:08 -0400
Date: Tue, 13 Aug 2002 08:02:28 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: Ingo Molnar <mingo@elte.hu>, Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: searching for dell 2650 PERC3-DI driver
In-Reply-To: <004401c242c7$842222f0$0b2b0a0a@zeusinc.com>
Message-ID: <Pine.LNX.4.44.0208130749110.23949-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Tom Sightler wrote:

> On Tue, 13 Aug 2002, Jeff Chua wrote:
> > I'm buying a Dell PowerEdge 2650 and need to know where to get driver for
> > the RAID controller
> >
> >         PERC3-DI, PERC3-DC, or PERC3-QC
> >
> > Does anyone know what kind of network adaptor is on the board?
> 
> The best place that I know of for information about ANY Dell server and
> Linux is at http://www.domsch.com/linux/.  There are instructions there on
> how to get recent versions of the aacraid driver to recognize this card
> during boot, assuming a fairly recent distribution.
> 
> The onboard network adapter is Broadcom NeXtreme Gigabit adapter.  I believe
> this is supported in recent distributions/kernels by the tg3 driver and Dell
> provides binary drivers from Broadcom as well.

FYI, we do have this sytem up and running.

If it's a PERC3-DI, then the raid driver is the aacraid as this is the
ROMB raid, basically a firmware addon to the adaptec scsi on board (IIRC).
For PERC3-DC or PERC3-QC the driver is the AMI megaraid driver.

The tg3 driver included with 2.4.19 works for the Broadcom
NetXtreame BCM5701 (Broadcom 570x).

This system has the ServerWorks GC and is a P4 therefore hyperthreading
does work.  2.4.19 so far seems very stable, but to balance IRQs
across all the CPUs you will need Ingo Molnars IRQ balancing patches.  His
patch, as applied to 2.4.19, can be found at
http://www.hardrock.org/kernel/irqbalance-2.4.19-MRC.patch

Also, remember to compile in support for IDE CD and the CSB5 IDE chipset.

This is the patch that I am currently testing on a single system.
With heavy load on the disk, memory, and CPU (~19 load average for the
past 3 days now) the system is still responsive and seems very stable.

I can send the .config I am currently using if you wish.

Regards
James Bourne

> 
> Later,
> Tom
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."




