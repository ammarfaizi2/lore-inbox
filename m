Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135616AbRD1Tie>; Sat, 28 Apr 2001 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135617AbRD1TiU>; Sat, 28 Apr 2001 15:38:20 -0400
Received: from [209.195.52.31] ([209.195.52.31]:61711 "HELO [209.195.52.31]")
	by vger.kernel.org with SMTP id <S135616AbRD1TiM>;
	Sat, 28 Apr 2001 15:38:12 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Garett Spencley <gspen@home.com>
Cc: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>,
        linux-kernel@vger.kernel.org
Date: Sat, 28 Apr 2001 11:29:15 -0700 (PDT)
Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
In-Reply-To: <Pine.LNX.4.30.0104281142520.3423-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0104281126570.16046-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what sort of switch are you plugged into? some Cisco switches have a
'feature' that ignores all traffic from a port for X seconds after a
machine is plugged in / powered on on a port (they claim somehting about
preventing loops) it may be that the new kernel now boots up faster then
the old one so that the DHCP request is lost in the switch, a few seconds
later when you do it by hand the swich has enabled your port and
everything works.

David Lang


 On Sat, 28 Apr 2001, Garett Spencley
wrote:

> Date: Sat, 28 Apr 2001 11:44:58 -0400 (EDT)
> From: Garett Spencley <gspen@home.com>
> To: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
>
> On Sat, 28 Apr 2001, Michael F Gordon wrote:
>
> > dhcpcd stops working if I install 2.4.4.  Replacing the 2.4.4 version of
> > 8139too.c with the 2.4.3 version and leaving everything else exactly
> > the same gets things working again.  Configuring the interface by hand
> > after dhcpcd has timed out also works.  Has anyone else seen this?
>
> I noticed this in 2.4.3-acX series as well. But here's the funny part:
> When dhcp starts up during bootup it doesn't work. But as
> soon as I log in and do a su -c '/etc/rc.d/init.d/network restart' there's
> instant success!
>
> This is on Mandrake 8.0
>
> It doesn't make much sense to me.
>
> --
> Garett
>
> > ISC
> DHCP 2.0, kernel compiled with gcc 2.95.2 >
> > lspci:
> >   00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8139 (rev 10)
> >
> > Boot messages with 2.4.3 version:
> >   8139too Fast Ethernet driver 0.9.15c loaded
> >   PCI: Found IRQ 5 for device 00:12.0
> >   eth0: RealTek RTL8139 Fast Ethernet at 0xc9804f00, 00:10:a7:05:8e:da, IRQ 5
> >   eth0:  Identified 8139 chip type 'RTL-8139C'
> >
> > Boot messages with 2.4.4 version:
> >   8139too Fast Ethernet driver 0.9.16
> >   PCI: Found IRQ 5 for device 00:12.0
> >   eth0: RealTek RTL8139 Fast Ethernet at 0xc9804f00, 00:10:a7:05:8e:da, IRQ 5
> >   eth0:  Identified 8139 chip type 'RTL-8139C'
> >
> >
> >
> > Michael Gordon
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
