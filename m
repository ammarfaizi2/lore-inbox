Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130651AbRBSEMU>; Sun, 18 Feb 2001 23:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130944AbRBSEMI>; Sun, 18 Feb 2001 23:12:08 -0500
Received: from server1.cosmoslink.net ([208.179.167.101]:14876 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S130684AbRBSEL5>; Sun, 18 Feb 2001 23:11:57 -0500
Message-ID: <01e701c09a2a$21e789a0$bba6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: <peterw@dascom.com.au>, "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: <linux-kernel@vger.kernel.org>,
        "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <XFMail.20010219124909.peterw@dascom.com.au>
Subject: Re: Kernel executation from ROM
Date: Sun, 18 Feb 2001 20:12:10 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sirs,

Thanks for your help,

I see . The biggest negative point of running kernel from ROM is that ROM
speed is slow :(

Any how , thanks for your help,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.


----- Original Message -----
From: "Peter Waltenberg" <peterw@dascom.com.au>
To: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Sent: Sunday, February 18, 2001 6:49 PM
Subject: RE: Kernel executation from ROM


>
> You can laod the kernel from ROM, but it'll need RAM to execute. If you
get to
> be very good with the linker and loader, you can probably make a large
part of
> the kernel ROM resident, but it will still need significant amounts of RAM
to
> be usable.
> It's probably easier not to bother and do what everyone else does and copy
from
> ROM->RAM at startup.
>
> Peter
>
> On 19-Feb-2001 Jaswinder Singh wrote:
> > Dear Kernel mailing list ,
> >
> > what changes i have to made in kernel so that i can
> > run kernel from ROM, means i keep my kernel in ROM
> > and i execute my kernel from ROM .
> >
> > Thanks ,
> >
> > Happy Hacking,
> >
> > Jaswinder.
> > --
> > These are my opinions not 3Di.
>
---------------------

----- Original Message -----
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Sent: Sunday, February 18, 2001 6:57 PM
Subject: Re: Kernel executation from ROM


> > what changes i have to made in kernel so that i can
> > run kernel from ROM, means i keep my kernel in ROM
> > and i execute my kernel from ROM .
>
> 1. write boot code to copy initialized variables into RAM
> 2. adjust the linker script to know about the above
> 3. adjust the linker script for other sections too
>
> For better performance, assuming ROM is slow and costly:
>
> 1. compress the "__init" code and data; use it in RAM
> 2. profile your kernel; put the critical parts in RAM
>
> If you want the details, take Red Hat's embedded systems
> development class. If you have a dozen people, get the class
> done at your location and have it modified to fit your needs.
> I just took the class; it was pretty good. It is "RHD248".
>

