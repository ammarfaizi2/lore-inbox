Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131910AbRCVCOp>; Wed, 21 Mar 2001 21:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131911AbRCVCOf>; Wed, 21 Mar 2001 21:14:35 -0500
Received: from swan.prod.itd.earthlink.net ([207.217.120.123]:34999 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131910AbRCVCOX>; Wed, 21 Mar 2001 21:14:23 -0500
Message-ID: <3AB95FEC.6D27CB24@mcn.net>
Date: Wed, 21 Mar 2001 19:14:04 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Only 10 MB/sec with via 82c686b chipset?
In-Reply-To: <20010321143956.917977A94@Nicole.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

egger@suse.de wrote:
> 
> On 20 Mar, SodaPop wrote:
> 
> > I have an IWill KK-266R motherboard with an athlon-c 1200
> > processor in it, and for the life of me I can't get more than
> > 10 MB/sec through the on-board ide controller.  Yes, all the
> > appropriate support is turned on in the kernel to enable dma
> > and specific chipset support, and yes, I think I have all
> > relevant patches and a reasonable kernel.
> 
>  Yes, actually I'm seeing the same on a KT133 board from Elitegroup.
>  Although here I get a bit more: 15 MB/s
> 
> > I noted a number of other interesting things;  one, that -X33,
> > -X34, and -X64 through -X69 all have the same 10 MB/sec transfer
> > rate, and two, that the 10 MB/sec transfer rate can be linearly
> > increased to 12 MB/sec by raising the system bus from 100 mhz to
> > 120 mhz (all components are safely rated at 133, no overclocking
> > involved.)
> 
>  Duh, before making such a claim you should consider the fact that
>  this is overclocking your PCI/AGP bus and I have yet to see any
>  graphic cards/IDE controllers/other devices which are rated for
>  37MHz PCI bus speed.
> 
> --
> 
> Servus,
>        Daniel

Actually this depends on the MB.  On mine for instance (Athlon also, but
not IWill), the PCI bus is a quotient of the oscillator and the FSB is
a multiple of the PCI and the CPU & ev6 are multiples of the FSB. 
Memory
speed is also a multibple of PCI.  In this case increasing the FSB 
doesn't increase the PCI.  Mine has two crystals 100/133 jumper con-
figurable.

Anyway this is probably getting way off-topic; although I'd kinda like
to see Dennis' output of both buffered and sustained output.  Looks
kinda
like a hw config problem.  Mine for comparison:

Maxtor 13.4 Gig 5400rpm ATA66
Buffered:		~170 - 175 MB
Sustained:		~24 MB inner  ~26 MB outer  
PCI: 33    FSB:  100    Memory 128M@133    CPU:  750Mhz    EV6:  200

===============
-- Tim
--------------------==============++==============--------------------
