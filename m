Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSHUTvv>; Wed, 21 Aug 2002 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSHUTvv>; Wed, 21 Aug 2002 15:51:51 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:54279 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318032AbSHUTvu>; Wed, 21 Aug 2002 15:51:50 -0400
Date: Wed, 21 Aug 2002 12:55:50 -0700
From: jw schultz <jw@pegasys.ws>
To: Roman Dementiev <dementiev@mpi-sb.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 stops at booting when I change PCI slot of a card
Message-ID: <20020821195550.GA7717@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Roman Dementiev <dementiev@mpi-sb.mpg.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3D635F68.C30BE6CF@mpi-sb.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 11:37:44AM +0200, Roman Dementiev wrote:
> I searched for relevant problems, but without success.
> 
> I have Supermicro P4DPE motherboard, 2-Xeons and four Ultra100 TX2 PCI
> IDE conrollers.
> 
> The motherboard has several PCI buses. Mapping of PCI slots to the buses
> is the following:
> 
> PCI Slot 1-3 (66 Mhz):  bus 5 (bus number reported by linux startup
> messages)
> PCI Slot 4   (66 Mhz):  bus 6
> PCI-X Slot 5 (66 Mhz):  bus 3
> PCI-X Slot 6 (100 Mhz): bus 2
> 
> PCI-X slots configured as plain PCI
> 100 Mhz slot configured to function at 66 Mhz
> 
> When I plug in 4 cards into slots 1-4 or 1-3 and 5 everything is fine,
> Linux boots, I have ULTRA DMA 100 on each of them.
> 
> But I wanted to avoid bus bandwith saturation moving each controller to
> the separate bus (now I can't get more then 240 Mb/s with 8 disk. With 4
> disks parallel read rate is 190 Mb/s, seems to be bottleneck in the PCI
> bus).
> 
> It failed (none of configurations except 1-4 and 1,2,3,5 work) linux
> stops after the message, corresponding to the last controller (other
> controllers are also reported):
> 
> PDC20268: IDE controller on PCI bus 06 dev 08
> PDC20268: chipset revision 2
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: (U)DMA Burst Bit DISABLED Primary MASTER Mode Secondary MASTER
> Mode.
> PDC20268: FORCING BURST BIT 0x50 -> 0x51 INACTIVE
>     ide8: BM-DMA at 0x4000-0x4007, BIOS settings: hdq:pio, hdr:pio
>     ide9: BM-DMA at 0x4008-0x400f, BIOS settings: hds:pio, hdt:pio
> 
> 
> Any ideas? Where is problem?

Just a thought:  What are the interupt assignments?
You might try sticking other cards (NICs?) in slots 4 and 5 to
confirm assignments.

I'm afraid i can't be more help that this.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
