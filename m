Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYOst>; Thu, 25 Jan 2001 09:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRAYOsj>; Thu, 25 Jan 2001 09:48:39 -0500
Received: from mcdc-us-smtp4.cdc.gov ([198.246.97.20]:22288 "EHLO
	mcdc-us-smtp4.cdc.gov") by vger.kernel.org with ESMTP
	id <S129051AbRAYOs0>; Thu, 25 Jan 2001 09:48:26 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2049E805B@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'Venkatesh Ramamurthy'" <Venkateshr@ami.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: megaraid 1.14e still broken
Date: Thu, 25 Jan 2001 09:29:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh,

megaraid version 1.14e breaks
I rebooted to 2.4.0 and it's older
megaraid v107 works fine

the raid controller was oem'ed 
Dell-AMI so there's not an obvious
upgrade I can burn into it from AMI
page because the product isn't listed
there

when the box boots and before lilo
takes over the message is:
 "PowerEdge Expandable RAID Controller BIOS 1.25"
with an option to go into a configuration utility
program

the box is a Dell PowerEdge server 2300/450, 
2 CPU, 1G RAM

Venkatesh, I appreciate your adding debugging
info to the driver to capture this, I didn't
write the full register dump
but did capture the first few debugging lines.
megaraid: v1.14e (Release Date: Jan 23, 2001, 17:55)
unable to handle kernel NULL pointer dereference 
  at virtual addrss 000002cc
printing eip: c01e10bc
*pde=00000000
Ooops: 0000
(followed by full register dump that I didn't copy)

Let me know where to go next.

Heitzso
xxh1@cdc.gov



-----Original Message-----
From: Venkatesh Ramamurthy [mailto:Venkateshr@ami.com]
Sent: Wednesday, January 24, 2001 2:12 PM
To: 'Heitzso'
Subject: RE: fyi megaraid problems


Try this 1.14e version of the driver and i would be glad if you could let me
know the result.
Thanks
Venkatesh

 <<m114e.tar.gz>> 


> -----Original Message-----
> From:	Heitzso [SMTP:xxh1@cdc.gov]
> Sent:	Wednesday, January 24, 2001 1:09 PM
> To:	'Venkatesh Ramamurthy'
> Subject:	RE: fyi megaraid problems
> 
> <flagging strangeness that latest greatest
> kernel, 2.4.1 pre 10, shipping with older 
> megaraid module, but one that works on our
> box!>
> 
> kernel 2.2.13 ships with v1.04, aug '99, WORKS
> kernel 2.2.16 didn't ftp down kernel and check
> kernel 2.2.18 ships with v1.11, BROKEN
> kernel 2.4.1pre10 ships with v1.07b, WORKS
> 
> 
> 
> -----Original Message-----
> From: Venkatesh Ramamurthy [mailto:Venkateshr@ami.com]
> Sent: Wednesday, January 24, 2001 12:07 PM
> To: 'Heitzso'
> Subject: RE: fyi megaraid problems
> 
> 
> Can i have the driver version number so that i can see whether we have
> already fixed that problem?
> Also you can send me the dmesg output from working system ( 2.2.13,
> 2.4.1pre10). This could gave me some additional data points.
> Thanks
> Venkatesh
> 
> > -----Original Message-----
> > From:	Heitzso [SMTP:xxh1@cdc.gov]
> > Sent:	Wednesday, January 24, 2001 12:07 PM
> > To:	'Venkatesh Ramamurthy'
> > Subject:	RE: fyi megaraid problems
> > 
> > can't ...
> > 
> > because the hard drive is never accessed 
> > so the boot messages are never written out
> > 
> > message was an oops, quick recap
> >  2.2.13 works (RH6.1 env)
> >  2.2.16 breaks (RH7 env)
> >  2.2.18 breaks (RH7 env)
> >  2.4.1pre10 works (RH7 env)
> > 
> > I don't know if the bug's in megaraid or
> > in the RH7 compiler environment, hence my
> > stressing that component
> > 
> > Heitzso
> > 
> > -----Original Message-----
> > From: Venkatesh Ramamurthy [mailto:Venkateshr@ami.com]
> > Sent: Wednesday, January 24, 2001 11:59 AM
> > To: 'xxh1@cdc.gov'
> > Subject: RE: fyi megaraid problems
> > 
> > 
> > 	Hi,
> > 	Can you send me the 'dmesg' output of the failing combination. I
> > would look into the problem ASAP once i get it.
> > 	Thanks
> > 	Venkatesh
> > 
> > > -----Original Message-----
> > > From: Heitzso [mailto:xxh1@cdc.gov]
> > > Sent: Wednesday, January 24, 2001 11:51 AM
> > > To: 'linux-kernel@vger.kernel.org'
> > > Subject: fyi megaraid problems
> > > 
> > > 
> > > don't know if this has been covered/studied
> > > 
> > > datapoints I've run across re the megaraid
> > > (scsi raid driver, american megatrends)
> > > 
> > > box: Dell PowerEdge 2300, 2 cpus, 1G RAM
> > > 
> > > hard drive setup as single drive via raid
> > > controller
> > > 
> > > RH6.1, compiled 2.2.13, megaraid works!
> > > 
> > > RH7.0 install/upgrade breaks on megaraid
> > > then, after forcing RH7.0 upgrade by hand 
> > >  (completely snuffed up with all updates as of jan 23 am ...)
> > > RH7.0 kernel (out of the rpm box 686 smp) breaks on megaraid
> > > RH7.0 2.2.16 kernel source from rpm 
> > >  compiled using 2.2.13 .config file
> > >  and make oldconfig generates kernel that
> > >  breaks on megaraid (used RH provided
> > >  scripts to compile with kgcc)
> > > 2.2.18 kernel (kernel.org) compiled with gcc on RH7.0
> > >  breaks on megaraid during boot
> > > 
> > > BUT! 2.4.1pre10 (kernel.org), compiled with gcc on RH7.0
> > >  the megaraid driver works again!
> > > 
> > > I was surprised that even 2.2.18 breaks
> > > then 2.4.1pre10 works, given RH's alliance
> > > with Dell.
> > > 
> > > I compiled a 2.4.0 and set it up in
> > > lilo.conf but haven't tried booting to it.
> > > 
> > > If it's useful to anyone, now that I have
> > > a good booting kernel I could recompile the
> > > old 2.2.13 setup and see whether the problem
> > > is due to a bad compiler env in RH7.0 or
> > > due to a bad megaraid module (i.e. if kernel
> > > that works fine now compiled under 6.1 
> > > breaks when recompiled under 7.0 then bug
> > > is in the RH7.0 compiler env; else bug is
> > > in megaraid shipped with 2.2.16, 2.2.18)
> > > 
> > > Let me know if someone needs a datapoint.
> > > 
> > > Heitzso
> > > xxh1@cdc.gov
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
