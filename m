Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154422AbPGXOSI>; Sat, 24 Jul 1999 10:18:08 -0400
Received: by vger.rutgers.edu id <S154399AbPGXORn>; Sat, 24 Jul 1999 10:17:43 -0400
Received: from Astro.Dyer.Vanderbilt.Edu ([129.59.241.17]:5171 "EHLO Astro.Dyer.Vanderbilt.Edu") by vger.rutgers.edu with ESMTP id <S154467AbPGXORG>; Sat, 24 Jul 1999 10:17:06 -0400
Date: Sat, 24 Jul 1999 09:17:01 -0500 (CDT)
From: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
Reply-To: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
To: Gerard Roudier <groudier@club-internet.fr>
cc: Linux <linux-kernel@vger.rutgers.edu>, linux-scsi@vger.rutgers.edu
Subject: Re: Joking PCI bridges: still another one.
In-Reply-To: <Pine.LNX.3.95.990724151242.1018A-100000@localhost>
Message-ID: <Pine.LNX.3.96.990724090241.5016D-100000@Astro.Dyer.Vanderbilt.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, 24 Jul 1999, Gerard Roudier wrote:

> Based on my current investigations, it may be the case that numerous PCI
> device drivers of ours may encounter problems on some non-Intel and
> non-IBM bridge-based systems, due to bridge not implementing the standard
> about transaction ordering rules.

Do you mean the super socket 7 hell?

I am have to access host and isa bridges to setup/identify capablity of
these ide-chipsets.  One of them is so bad that I have to determine the
revision of the isa-bridge to decide the feature limits of the ide
host-adapter, or determine the identity of the host-host device to try and
guess the setep of the isa-bridge lot/stamp.

The other chipset vender places a double ident chipset with two level of
access.  The two possible isa-bridge devices must be detected to determine
the features list.  If you get the one with latest bridge, you still have
to access the lower bridge to setup the ide host-adapter.  Oh did I forget
to mention that the irq routing table for the IDE is only settable in the
isa-bridge, or that you have to dork with a few bits to disable the pnp
simplex block.

It gets worse, now that I have a broader insight into the madness.

Is this familar?

> As I wrote in some previous posting, I plan to propose serious work-arounds 
> for joking PCI bridges:) for the stuff I maintain (ncr/sym driver) before
> the end of August if we survive August the 11'th obviously:-).
> This may consist in a few number of lines mostly trivial, or to end up
> with crossing fingers for some situations, but I need to investigate
> the issue prior to do the changes in the code.
> 
> It will be interesting, in my opinion, to allow PCI device drivers to have
> knowledge about the PCI-HOST bridge of the system or to have access to
> some quirk flags associated with that bridge. 

Been there........got the T-Shirt............

Andre Hedrick
The Linux IDE guy




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
