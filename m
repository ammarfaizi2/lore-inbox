Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312853AbSCVViA>; Fri, 22 Mar 2002 16:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312851AbSCVVhk>; Fri, 22 Mar 2002 16:37:40 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:59656 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S312850AbSCVVhf> convert rfc822-to-8bit;
	Fri, 22 Mar 2002 16:37:35 -0500
Date: Fri, 22 Mar 2002 23:37:34 +0200 (EET)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BETA-0.97] Eigth test release of Tigon3 driver
In-Reply-To: <20020313.162358.110332826.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0203222333520.10668-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Mar 2002, David S. Miller wrote:
>
> >From the usual location:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.97.patch.gz
>
> Changes in this release:
>
> [FIX] Lots of VLAN layer fixes from Chris Leech.
> [FIX] Fix a bug in Tigon3 fibre negotiation state machine
>       where it could run forever.  Reported by Erik Habbinga.
> [FIX] Do not lose network statistics around down/up of interface
>       for Tigon3.  Broadcom's driver has this bug too.
> [FIX] Small bug fix for PHY setup on 5703 A1 revisions.
> [FEATURE] Add many new tunables, via ethtool, to Tigon3
> 	  for controlling:
> 	  1) Coelaescing, interrupt mitigation
> 	  2) RX/TX ring sizes
> 	  3) Pause flow control settings
> 	  4) RX/TX checksumming and scatter-gather
> 	  Please note that these new bits have not been
> 	  added to Jeff's ethtool userland tool but they
> 	  will be added soon.
>
> I'm probably going to bump the version to 1.0 and push this to Marcelo
> for 2.4.x in the next couple of days.  Jeff has already included this
> driver (and I the VLAN layer stuff) into 2.5.x
>

tg3.c:v0.97 (Mar 13, 2002)
eth2: Tigon3 [partno(BCM95700A6) rev 7102 PHY(5401)] (PCI:33MHz:64-bit)
10/100/1000BaseT Ethernet 00:04:76:2f:c2:b0

eth2: Link is up at 1000 Mbps, full duplex.
eth2: Flow control is off for TX and off for RX.

05:03.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5700
Gigabit Ethernet (rev 12)
        Subsystem: 3Com Corporation 3C996-T 1000BaseTX
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 22
        Memory at fd300000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] #07 [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-


Seems to work.. but I guess I shouldn't say anything yet because uptime is
only 20 minutes so far :)

We'll see.

How about vlans.. should it say something about enabling hardware vlan
tagging when I configure some vlans?


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

