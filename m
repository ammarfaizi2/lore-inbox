Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRAYQkA>; Thu, 25 Jan 2001 11:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRAYQju>; Thu, 25 Jan 2001 11:39:50 -0500
Received: from cookiemonster.ny.genx.net ([206.64.4.77]:2063 "HELO
	cookiemonster.hq.ny.genx.net") by vger.kernel.org with SMTP
	id <S129169AbRAYQjn>; Thu, 25 Jan 2001 11:39:43 -0500
Message-ID: <BF0800DEA68DD4118B2D00B0D049C021014B2450@element.ny.genx.net>
From: "Margulies, Adam" <amarguli@hotjobs.com>
To: "'Heitzso'" <xxh1@cdc.gov>, "'Venkatesh Ramamurthy'" <Venkateshr@ami.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: megaraid 1.14e still broken
Date: Thu, 25 Jan 2001 11:33:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C086EC.97CFB670"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C086EC.97CFB670
Content-Type: text/plain;
	charset="iso-8859-1"

I've noticed that there is a module that appears to conflict with the
megaraid driver.
(I know this seems strange).

I was having trouble getting the megaraid driver to work so...
I winnowed down my kernel to an absolute bare minimum, added the megaraid
driver, rebooted.

It worked.

So, I then basically did a binary search of the kernel features I'd
disabled.
This is very time consuming, I know. I rebuilt the kernel several times,
adding
a few features each time. I never figured out exactly which module was
conflicting, if any,
(because after rebuilding the kernel 10 times, it gets really, really old).
But I believe it was the USB filesystem module, which I never reenabled,
because
I don't expect to ever use it.


adam


-----Original Message-----
From: Heitzso [mailto:xxh1@cdc.gov]
Sent: Thursday, January 25, 2001 9:30 AM
To: 'Venkatesh Ramamurthy'
Cc: 'linux-kernel@vger.kernel.org'
Subject: megaraid 1.14e still broken


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

------_=_NextPart_001_01C086EC.97CFB670
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2650.12">
<TITLE>RE: megaraid 1.14e still broken</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>I've noticed that there is a module that appears to conflict with the megaraid driver.</FONT>
<BR><FONT SIZE=2>(I know this seems strange).</FONT>
</P>

<P><FONT SIZE=2>I was having trouble getting the megaraid driver to work so...</FONT>
<BR><FONT SIZE=2>I winnowed down my kernel to an absolute bare minimum, added the megaraid driver, rebooted.</FONT>
</P>

<P><FONT SIZE=2>It worked.</FONT>
</P>

<P><FONT SIZE=2>So, I then basically did a binary search of the kernel features I'd disabled.</FONT>
<BR><FONT SIZE=2>This is very time consuming, I know. I rebuilt the kernel several times, adding</FONT>
<BR><FONT SIZE=2>a few features each time. I never figured out exactly which module was conflicting, if any,</FONT>
<BR><FONT SIZE=2>(because after rebuilding the kernel 10 times, it gets really, really old).</FONT>
<BR><FONT SIZE=2>But I believe it was the USB filesystem module, which I never reenabled, because</FONT>
<BR><FONT SIZE=2>I don't expect to ever use it.</FONT>
</P>
<BR>

<P><FONT SIZE=2>adam</FONT>
</P>
<BR>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Heitzso [<A HREF="mailto:xxh1@cdc.gov">mailto:xxh1@cdc.gov</A>]</FONT>
<BR><FONT SIZE=2>Sent: Thursday, January 25, 2001 9:30 AM</FONT>
<BR><FONT SIZE=2>To: 'Venkatesh Ramamurthy'</FONT>
<BR><FONT SIZE=2>Cc: 'linux-kernel@vger.kernel.org'</FONT>
<BR><FONT SIZE=2>Subject: megaraid 1.14e still broken</FONT>
</P>
<BR>

<P><FONT SIZE=2>Venkatesh,</FONT>
</P>

<P><FONT SIZE=2>megaraid version 1.14e breaks</FONT>
<BR><FONT SIZE=2>I rebooted to 2.4.0 and it's older</FONT>
<BR><FONT SIZE=2>megaraid v107 works fine</FONT>
</P>

<P><FONT SIZE=2>the raid controller was oem'ed </FONT>
<BR><FONT SIZE=2>Dell-AMI so there's not an obvious</FONT>
<BR><FONT SIZE=2>upgrade I can burn into it from AMI</FONT>
<BR><FONT SIZE=2>page because the product isn't listed</FONT>
<BR><FONT SIZE=2>there</FONT>
</P>

<P><FONT SIZE=2>when the box boots and before lilo</FONT>
<BR><FONT SIZE=2>takes over the message is:</FONT>
<BR><FONT SIZE=2>&nbsp;&quot;PowerEdge Expandable RAID Controller BIOS 1.25&quot;</FONT>
<BR><FONT SIZE=2>with an option to go into a configuration utility</FONT>
<BR><FONT SIZE=2>program</FONT>
</P>

<P><FONT SIZE=2>the box is a Dell PowerEdge server 2300/450, </FONT>
<BR><FONT SIZE=2>2 CPU, 1G RAM</FONT>
</P>

<P><FONT SIZE=2>Venkatesh, I appreciate your adding debugging</FONT>
<BR><FONT SIZE=2>info to the driver to capture this, I didn't</FONT>
<BR><FONT SIZE=2>write the full register dump</FONT>
<BR><FONT SIZE=2>but did capture the first few debugging lines.</FONT>
<BR><FONT SIZE=2>megaraid: v1.14e (Release Date: Jan 23, 2001, 17:55)</FONT>
<BR><FONT SIZE=2>unable to handle kernel NULL pointer dereference </FONT>
<BR><FONT SIZE=2>&nbsp; at virtual addrss 000002cc</FONT>
<BR><FONT SIZE=2>printing eip: c01e10bc</FONT>
<BR><FONT SIZE=2>*pde=00000000</FONT>
<BR><FONT SIZE=2>Ooops: 0000</FONT>
<BR><FONT SIZE=2>(followed by full register dump that I didn't copy)</FONT>
</P>

<P><FONT SIZE=2>Let me know where to go next.</FONT>
</P>

<P><FONT SIZE=2>Heitzso</FONT>
<BR><FONT SIZE=2>xxh1@cdc.gov</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Venkatesh Ramamurthy [<A HREF="mailto:Venkateshr@ami.com">mailto:Venkateshr@ami.com</A>]</FONT>
<BR><FONT SIZE=2>Sent: Wednesday, January 24, 2001 2:12 PM</FONT>
<BR><FONT SIZE=2>To: 'Heitzso'</FONT>
<BR><FONT SIZE=2>Subject: RE: fyi megaraid problems</FONT>
</P>
<BR>

<P><FONT SIZE=2>Try this 1.14e version of the driver and i would be glad if you could let me</FONT>
<BR><FONT SIZE=2>know the result.</FONT>
<BR><FONT SIZE=2>Thanks</FONT>
<BR><FONT SIZE=2>Venkatesh</FONT>
</P>

<P><FONT SIZE=2>&nbsp;&lt;&lt;m114e.tar.gz&gt;&gt; </FONT>
</P>
<BR>

<P><FONT SIZE=2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=2>&gt; From: Heitzso [SMTP:xxh1@cdc.gov]</FONT>
<BR><FONT SIZE=2>&gt; Sent: Wednesday, January 24, 2001 1:09 PM</FONT>
<BR><FONT SIZE=2>&gt; To:&nbsp;&nbsp; 'Venkatesh Ramamurthy'</FONT>
<BR><FONT SIZE=2>&gt; Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RE: fyi megaraid problems</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; &lt;flagging strangeness that latest greatest</FONT>
<BR><FONT SIZE=2>&gt; kernel, 2.4.1 pre 10, shipping with older </FONT>
<BR><FONT SIZE=2>&gt; megaraid module, but one that works on our</FONT>
<BR><FONT SIZE=2>&gt; box!&gt;</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; kernel 2.2.13 ships with v1.04, aug '99, WORKS</FONT>
<BR><FONT SIZE=2>&gt; kernel 2.2.16 didn't ftp down kernel and check</FONT>
<BR><FONT SIZE=2>&gt; kernel 2.2.18 ships with v1.11, BROKEN</FONT>
<BR><FONT SIZE=2>&gt; kernel 2.4.1pre10 ships with v1.07b, WORKS</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=2>&gt; From: Venkatesh Ramamurthy [<A HREF="mailto:Venkateshr@ami.com">mailto:Venkateshr@ami.com</A>]</FONT>
<BR><FONT SIZE=2>&gt; Sent: Wednesday, January 24, 2001 12:07 PM</FONT>
<BR><FONT SIZE=2>&gt; To: 'Heitzso'</FONT>
<BR><FONT SIZE=2>&gt; Subject: RE: fyi megaraid problems</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; Can i have the driver version number so that i can see whether we have</FONT>
<BR><FONT SIZE=2>&gt; already fixed that problem?</FONT>
<BR><FONT SIZE=2>&gt; Also you can send me the dmesg output from working system ( 2.2.13,</FONT>
<BR><FONT SIZE=2>&gt; 2.4.1pre10). This could gave me some additional data points.</FONT>
<BR><FONT SIZE=2>&gt; Thanks</FONT>
<BR><FONT SIZE=2>&gt; Venkatesh</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; -----Original Message-----</FONT>
<BR><FONT SIZE=2>&gt; &gt; From:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Heitzso [SMTP:xxh1@cdc.gov]</FONT>
<BR><FONT SIZE=2>&gt; &gt; Sent:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wednesday, January 24, 2001 12:07 PM</FONT>
<BR><FONT SIZE=2>&gt; &gt; To: 'Venkatesh Ramamurthy'</FONT>
<BR><FONT SIZE=2>&gt; &gt; Subject:&nbsp;&nbsp;&nbsp; RE: fyi megaraid problems</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; can't ...</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; because the hard drive is never accessed </FONT>
<BR><FONT SIZE=2>&gt; &gt; so the boot messages are never written out</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; message was an oops, quick recap</FONT>
<BR><FONT SIZE=2>&gt; &gt;&nbsp; 2.2.13 works (RH6.1 env)</FONT>
<BR><FONT SIZE=2>&gt; &gt;&nbsp; 2.2.16 breaks (RH7 env)</FONT>
<BR><FONT SIZE=2>&gt; &gt;&nbsp; 2.2.18 breaks (RH7 env)</FONT>
<BR><FONT SIZE=2>&gt; &gt;&nbsp; 2.4.1pre10 works (RH7 env)</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; I don't know if the bug's in megaraid or</FONT>
<BR><FONT SIZE=2>&gt; &gt; in the RH7 compiler environment, hence my</FONT>
<BR><FONT SIZE=2>&gt; &gt; stressing that component</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; Heitzso</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; -----Original Message-----</FONT>
<BR><FONT SIZE=2>&gt; &gt; From: Venkatesh Ramamurthy [<A HREF="mailto:Venkateshr@ami.com">mailto:Venkateshr@ami.com</A>]</FONT>
<BR><FONT SIZE=2>&gt; &gt; Sent: Wednesday, January 24, 2001 11:59 AM</FONT>
<BR><FONT SIZE=2>&gt; &gt; To: 'xxh1@cdc.gov'</FONT>
<BR><FONT SIZE=2>&gt; &gt; Subject: RE: fyi megaraid problems</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &nbsp;&nbsp;&nbsp; Hi,</FONT>
<BR><FONT SIZE=2>&gt; &gt; &nbsp;&nbsp;&nbsp; Can you send me the 'dmesg' output of the failing combination. I</FONT>
<BR><FONT SIZE=2>&gt; &gt; would look into the problem ASAP once i get it.</FONT>
<BR><FONT SIZE=2>&gt; &gt; &nbsp;&nbsp;&nbsp; Thanks</FONT>
<BR><FONT SIZE=2>&gt; &gt; &nbsp;&nbsp;&nbsp; Venkatesh</FONT>
<BR><FONT SIZE=2>&gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; -----Original Message-----</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; From: Heitzso [<A HREF="mailto:xxh1@cdc.gov">mailto:xxh1@cdc.gov</A>]</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; Sent: Wednesday, January 24, 2001 11:51 AM</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; To: 'linux-kernel@vger.kernel.org'</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; Subject: fyi megaraid problems</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; don't know if this has been covered/studied</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; datapoints I've run across re the megaraid</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; (scsi raid driver, american megatrends)</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; box: Dell PowerEdge 2300, 2 cpus, 1G RAM</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; hard drive setup as single drive via raid</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; controller</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; RH6.1, compiled 2.2.13, megaraid works!</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; RH7.0 install/upgrade breaks on megaraid</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; then, after forcing RH7.0 upgrade by hand </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt;&nbsp; (completely snuffed up with all updates as of jan 23 am ...)</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; RH7.0 kernel (out of the rpm box 686 smp) breaks on megaraid</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; RH7.0 2.2.16 kernel source from rpm </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt;&nbsp; compiled using 2.2.13 .config file</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt;&nbsp; and make oldconfig generates kernel that</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt;&nbsp; breaks on megaraid (used RH provided</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt;&nbsp; scripts to compile with kgcc)</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; 2.2.18 kernel (kernel.org) compiled with gcc on RH7.0</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt;&nbsp; breaks on megaraid during boot</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; BUT! 2.4.1pre10 (kernel.org), compiled with gcc on RH7.0</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt;&nbsp; the megaraid driver works again!</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; I was surprised that even 2.2.18 breaks</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; then 2.4.1pre10 works, given RH's alliance</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; with Dell.</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; I compiled a 2.4.0 and set it up in</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; lilo.conf but haven't tried booting to it.</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; If it's useful to anyone, now that I have</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; a good booting kernel I could recompile the</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; old 2.2.13 setup and see whether the problem</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; is due to a bad compiler env in RH7.0 or</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; due to a bad megaraid module (i.e. if kernel</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; that works fine now compiled under 6.1 </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; breaks when recompiled under 7.0 then bug</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; is in the RH7.0 compiler env; else bug is</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; in megaraid shipped with 2.2.16, 2.2.18)</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; Let me know if someone needs a datapoint.</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; </FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; Heitzso</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; xxh1@cdc.gov</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; -</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe</FONT>
<BR><FONT SIZE=2>&gt; linux-kernel&quot;</FONT>
<BR><FONT SIZE=2>&gt; &gt; in</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; the body of a message to majordomo@vger.kernel.org</FONT>
<BR><FONT SIZE=2>&gt; &gt; &gt; Please read the FAQ at <A HREF="http://www.tux.org/lkml/" TARGET="_blank">http://www.tux.org/lkml/</A></FONT>
<BR><FONT SIZE=2>-</FONT>
<BR><FONT SIZE=2>To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel&quot; in</FONT>
<BR><FONT SIZE=2>the body of a message to majordomo@vger.kernel.org</FONT>
<BR><FONT SIZE=2>Please read the FAQ at <A HREF="http://www.tux.org/lkml/" TARGET="_blank">http://www.tux.org/lkml/</A></FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C086EC.97CFB670--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
