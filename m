Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSKVQdw>; Fri, 22 Nov 2002 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265023AbSKVQdw>; Fri, 22 Nov 2002 11:33:52 -0500
Received: from host194.steeleye.com ([66.206.164.34]:26896 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265019AbSKVQdv>; Fri, 22 Nov 2002 11:33:51 -0500
Message-Id: <200211221640.gAMGetJ02979@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup 
In-Reply-To: Message from "Martin J. Bligh" <mbligh@aracnet.com> 
   of "Fri, 22 Nov 2002 07:42:19 PST." <1047956111.1037950936@[10.10.2.3]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Nov 2002 10:40:55 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbligh@aracnet.com said:
> That's not true either. There are lots of header files under the
> include tree that aren't externally useful.

It may be honoured more in the breach than the observance, but it's a custom 
nonetheless.

> And every other header file is under the include path ... putting them
> all mixed in with C files is just making a mess.

No, look at e.g. SCSI.  We have a scsi.h file in drivers/scsi which defines 
subsystem specific things that we only use within SCSI.  We have 
include/scsi/scsi.h which defines things other subsystems can use.

> Que? How is include/asm-i386 any more "kernel core" than arch/i386? 

Because the files are spreading.  I think there's value to keeping something 
tightly contained unless you're going to encourage others to use it.  
Interfaces are dangerous things: If you release them into the wild 
willy-nilly, they can come back and bite you (athough more often they just 
bite other people).

James


