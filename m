Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTAEKkF>; Sun, 5 Jan 2003 05:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbTAEKkF>; Sun, 5 Jan 2003 05:40:05 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:47574 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S264644AbTAEKj6>; Sun, 5 Jan 2003 05:39:58 -0500
Date: Sun, 05 Jan 2003 23:47:58 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
Message-ID: <2043540000.1041763678@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.10.10301042123450.421-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10301042123450.421-100000@master.linux-ide.org>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, that's nice!

Presumably you could substitute DCCP or whatever for TCP.  I like it.

So how about this, the result of a corridor conversation at an IETF:

It is perfectly doable, using HIP and some (admittedly expensive) hardware 
crypto gear to run iSCSI encrypted at Gigabit Ethernet rates and faster, 
while being able to attach endpoints more or less at random in IP space and 
move them around freely while connected.  Mobile hotplug IP storage :-)


HIP is the Host Identity Payload, which can be seen as different things 
depending on which features you like.  The idea starts from distinguishing 
the IP address, which basically represents a location in the net, from the 
Host Identity, which is a public key that identifies an endpoint.

By some machinations, you end up being IP numbering and version agnostic, 
while having an extremely lightweight opportunistic key exchange protocol.

There are several implementations and all the specs linked to at 
http://www.hip4inter.net/, not presently including my own, which is purely 
userspace (everything I have so far needed is provided by standard kernels, 
except ESP and that is now in too), BSD licensed and written in Python and 
which will be released soon, for some value of soon.

This is a less mature protocol than iSCSI at this point, but I think there 
are some very interesting possibilities by combining the two.

Andrew

--On Saturday, January 04, 2003 21:31:39 -0800 Andre Hedrick 
<andre@linux-ide.org> wrote:

> On Sun, 5 Jan 2003, Andrew McGregor wrote:
>
>> By the way, I'm principally a developer of communications standards and
>> hardware, not so much software.
>
> I forgot to mention the template model on each side of the iSCSI protocol
> state machine we have developed is agnostic?
>
> Initiator --- Transport --- Target --- Spindle
>
> 		TCP			SCSI
> 		Quads			ATA
> 		SCI			SATA
> 		Myrinet			MD
> 		InfiniBand		LVM
> 		TELCO			USB
> 		CARRIER			1394
> 					SAS
> 					Fibre Channel
>
> 					FLOPPY, for emergencies.
>
> 	Create Your Own		Create Your Own
>
> Yeah, I am nutter than a fruitcake, but it works!
>
> This is for Larry McVoy, it is the closest thing you will ever see today
> which looks like a disk with an RJ-45 port.
>
> Cheers,
>
> Andre Hedrick
> LAD Storage Consulting Group
>
>

