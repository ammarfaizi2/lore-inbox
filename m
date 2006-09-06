Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWIFRO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWIFRO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWIFRO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:14:27 -0400
Received: from mail0.lsil.com ([147.145.40.20]:40341 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751749AbWIFROZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:14:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: megaraid_sas waiting for command and then offline
Date: Wed, 6 Sep 2006 11:14:14 -0600
Message-ID: <0631C836DBF79F42B5A60C8C8D4E82296A722A@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: megaraid_sas waiting for command and then offline
Thread-Index: AcbRzic74NtGwCSwT+qxrJeJ3mRblgACGdSQ
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "Brett G. Durrett" <brett@imvu.com>, "Dave Lloyd" <dlloyd@exegy.com>
Cc: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Berkley Shands" <bshands@exegy.com>,
       "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
X-OriginalArrivalTime: 06 Sep 2006 17:14:15.0648 (UTC) FILETIME=[E167AE00:01C6D1D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Brett,

	A DMA related bug was fixed in FW ver *.0095 that was causing
the FW to stop responding. 
	
	Please upgrade the FW version to >= *.0095 and let me know if
you still see the issue.
 
Regards,

Sumant


-----Original Message-----
From: Brett G. Durrett [mailto:brett@imvu.com] 
Sent: Wednesday, September 06, 2006 9:04 AM
To: Dave Lloyd
Cc: Patro, Sumant; Bagalkote, Sreenivas; lkml; Berkley Shands
Subject: Re: megaraid_sas waiting for command and then offline


The machines are Dell 2900s, so the mobo is custom.  From a Dell SE, 
"Dell uses a custom mobo that is Dell branded with the Intel chipset 
Greencreek.".

B-




Dave Lloyd wrote:

> Brett G. Durrett wrote:
> >
> > I have the same or a similar issue running 2.6.17 SMP x86_64 - the
> > megaraid_sas driver hangs waiting for commands and then the
filesystem
> > unmounts, leaving the machine in an unusable state until there is a 
> hard
> > reboot (the machine is responsive but any access, shell or 
> otherwise, is
> > impossible without the filesystem).  While I do not have much
debugging
> > information available, this happens to me about once every 6-7 days
in
> > my pool of seven machines, so I can probably get debugging info.
Since
> > the disk is offline and I can't get remote console, I don't have any
> > details except something similar to Dave Lloyd's post, below.
> >
> > The only thing that the machines with these failures seem to have in
> > common is the fact that they are almost exclusively writes - they
are
> > slave database machines with large memory and pretty much just
> > replicate.  The read/write machines seem to have less failures.
> >
> > I am happy to help provide debugging information in any reasonable
way.
> > In the mean time, if there are any known suggestions or workarounds
for
> > the problem, I would be grateful for the guidance.
> >
> > Here are what details on the controller.  If you want additional
info,
> > let me know exactly what you need and I will do what I can to get it
to
> > you.:
> >
> > Product Name    : PERC 5/i Integrated
> > Serial No       : 12345
> > FW Package Build: 5.0.1-0030
> > FW Version      : 1.00.01-0088
> > BIOS Version    : MT23
> > Ctrl-R Version  :1.02-007
> >
> > B-
>
> Which motherboard are you using?  We believe that this may be a
> motherboard specific issue.  It appears to happen on a SuperMicro
> motherboard but not a Tyan motherboard.
>
