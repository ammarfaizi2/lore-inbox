Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSGDW5N>; Thu, 4 Jul 2002 18:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSGDW5M>; Thu, 4 Jul 2002 18:57:12 -0400
Received: from host194.steeleye.com ([216.33.1.194]:30992 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314634AbSGDW5L>; Thu, 4 Jul 2002 18:57:11 -0400
Message-Id: <200207042259.g64MxdH03605@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andre Hedrick <andre@linux-ide.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
Subject: Re: [BUG-2.5.24-BK] DriverFS panics on boot! 
In-Reply-To: Message from Andre Hedrick <andre@linux-ide.org> 
   of "Thu, 04 Jul 2002 15:20:10 PDT." <Pine.LNX.4.10.10207041517530.19028-100000@master.linux-ide.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 18:59:39 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andre@linux-ide.org said:
> The whole reason for my replacement was to add driverfs to IDE and
> remove devfs and ultimately "de-gooch" the kernel.  So we are nearly
> 100 patches in and the primary reason for ousting is still a failure,
> NICE! 

Well, perhaps we have slightly different agendas.  I think driverfs will solve 
a whole series of enumeration and mapping problems that occur in the SCSI 
mid-layer and which get especially tortuous with Fibre Channel.  I also think 
it will help us bring the SCSI and IDE views closer together.

I persuaded Linus to put the SCSI driverfs patches in the kernel even though I 
knew they touched more than SCSI (the partitions code) and were not as modular 
as I would have liked.  The reason is that we need to get as much visibility 
on this as possible before the code freeze.  I'm fully prepared to sort out 
any problems with this as they arise (and indeed the panic is already fixed).

I believe it's a variation of a principle attributable to a wise Australian:  
get the right solution in, even if not quite the right implementation.  That 
way, everyone will be extrememly motivated to help produce the right 
implementation.

James


