Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbRAPUCR>; Tue, 16 Jan 2001 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130575AbRAPUCI>; Tue, 16 Jan 2001 15:02:08 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:5108 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129789AbRAPUCA>; Tue, 16 Jan 2001 15:02:00 -0500
Date: Tue, 16 Jan 2001 12:01:12 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
cc: "'Dominik Kubla'" <dominik.kubla@uni-mainz.de>,
        "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1>
Message-ID: <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Venkatesh Ramamurthy wrote:

> > This is due to the fixed ordering of the scsi drivers. You can change the
> > order of the scsi hosts with the "scsihosts" kernel parameter. See
> > linux/drivers/scsi/scsi.c
> 	[Venkatesh Ramamurthy]  I think it would be a nice idea if we can
> make this process automatic , with out user typing in the order and
> remembering it. The fact that a kernel developer is not using the machines
> daily to get his work done should be in our minds. If we do this Linux would
> become more user friendly

you're forgetting that in /etc/lilo.conf there is a directive called
'append='... all the user has to do is merely add
'append="scsihosts=whatever,whatever"' into their config file and rerun
lilo. problem solved

besides, how many 'end-users' do you know of that will have multiple scsi
adapters in one system? how many end-users -period- will have even a
*single* scsi adapter in their systems? do we need to bloat the kernel
with automatic things like this? no... i think it is handled fine the way
it is. if the user wants to add more than one scsi adapter into his
system, let him read some documentation on how to do so. (is this even a
documented feature? if not, i think it should be added to the docs...)

just my thoughts on the matter....

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
