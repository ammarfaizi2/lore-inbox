Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRAPUbI>; Tue, 16 Jan 2001 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRAPUa6>; Tue, 16 Jan 2001 15:30:58 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:17909 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129780AbRAPUan>; Tue, 16 Jan 2001 15:30:43 -0500
Date: Tue, 16 Jan 2001 12:30:34 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95198@ATL_MS1>
Message-ID: <Pine.LNX.4.21.0101161221530.17397-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Venkatesh Ramamurthy wrote:

> 	[Venkatesh Ramamurthy]  Dont you think that mounting and booting
> based on disk label names is better, then relying on device nodes which can
> change when a new card is added?. The existing patch for 2.2.xx is quite
> small and it does not bloat the kernel too much either. I think we can port
> it for 2.4.XX with ease.In my words it is worth the effort 

Of course that would be better. The only complaint I have with such a
system is that of backwards compatibility...as long as the legacy device
names are still supported i would have no problem with it at all. 

however, this brings up an interesting question: what happens if two disks
(presumably from two different machines) have the same disk label? what
happens then? for instance, i have several linux machines both at my
workplace and my home. if for some reason one of these machines dies due
to hardware failure and i want to get stuff off the drives, i put the disk
containing the /home partition on the failed machine into a working
machine and reboot. What /home gets mounted then? the original /home or
the new one from the dead machine? (and don't say end users wouldn't
possibly do that... if they are adding hardware into their systems this is
by no means beyond their capabilities)

at least with physical device nodes i can say 'computer, you will mount
this partition on this mountpoint!' and be done with it.

so tell me then, how would one discern between two partitions with the
same label?

just a thought....

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
