Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSHTLBo>; Tue, 20 Aug 2002 07:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHTLBo>; Tue, 20 Aug 2002 07:01:44 -0400
Received: from pop.gmx.net ([213.165.64.20]:51475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316856AbSHTLBl>;
	Tue, 20 Aug 2002 07:01:41 -0400
Date: Tue, 20 Aug 2002 13:07:25 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with PCMCIA 8139too
Message-Id: <20020820130725.6000c4fd.gigerstyle@gmx.ch>
In-Reply-To: <20020819111335.1ca1cabe.gigerstyle@gmx.ch>
References: <20020815215523.3071a528.gigerstyle@gmx.ch>
	<20020819111335.1ca1cabe.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.1claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for again disturbing.......

after a suspend to disk (very slow:-( ) the card works.
but afer a suspend to ram still not..:-(

marc

On Mon, 19 Aug 2002 11:13:35 +0200
gigerstyle@gmx.ch wrote:

> Hi again...
> 
> The problem still exists...
> I also tried the newest kernel (2.4.20-pre3).
> 
> I think the 8139 driver is correct. The apm driver has a problem.
> 
> Explanation:
> 
> When I boot my Notebook without loaded the network and pcmcia driver then set it into sleeping mode and resume it later, then load all needed drivers, the card is recognised but does not work. Same problem.
> 
> Is it a problem with apm and pci-bus? (All other direct connected devices (Soundcard, graphiccard etc) working well).
> 
> Thank you
> 
> Marc Giger
> 
> 
> On Thu, 15 Aug 2002 21:55:23 +0200
> gigerstyle@gmx.ch wrote:
> 
> > Hi!
> > 
> > I have successfully installed the PCMCIA CardBus NIC with realtek 8139 chip. I'm using the yenta_socket module and of course the 8139too module.
> > 
> > As test I set up the interface with 
> > 
> > 	ifconfig eth0 192.168.0.5 up
> > 
> > and made a ping to another host.
> > 
> > Seems all to be ok.. no problems there.
> > 
> > 
> > When I put my Notebook in sleeping mode and resume it, ifconfig shows still the same network configuration, BUT now I can't ping any other hosts.
> > 
> > A
> > 	ifconfig eth0 down
> > and
> > 	ifconfig eth0 192.168.0.5 up
> > 
> > doesn't help.
> > 
> > Ping says only:
> > 
> > PING 192.168.0.1 (192.168.0.1) from 192.168.0.5 : 56(84) bytes of data.
> > From 192.168.0.5: icmp_seq=1 Destination Host Unreachable
> > From 192.168.0.5 icmp_seq=1 Destination Host Unreachable
> > From 192.168.0.5 icmp_seq=2 Destination Host Unreachable
> > From 192.168.0.5 icmp_seq=3 Destination Host Unreachable
> > From 192.168.0.5 icmp_seq=4 Destination Host Unreachable
> > From 192.168.0.5 icmp_seq=5 Destination Host Unreachable
> > From 192.168.0.5 icmp_seq=6 Destination Host Unreachable
> > 
> > --- 192.168.0.1 ping statistics ---
> > 10 packets transmitted, 0 received, +7 errors, 100% loss, time 9025ms
> > 
> > 
> > Have also tried many other things like reloading modules,
> > shutting down pcmcia before sleeping etc etc....
> > As last I used the hotplugging scripts...but also without success.
> > 
> > There are no errors in message or something else:-(
> > After a standby I have to reboot the Notebook for a proper working NIC:-(
> > 
> > Is there any way that it will work? I like standby and hate booting;-)
> > 
> > Other cards have no problems (older realtek, aironet 340) but they aren't cardbus.
> > 
> > 
> > /varr/log/messages:
> > 
> > Aug 15 21:18:59 vaio kernel: cs: cb_alloc(bus 6): vendor 0x10ec, device 0x8139
> > Aug 15 21:18:59 vaio kernel: PCI: Enabling device 06:00.0 (0000 -> 0003)
> > Aug 15 21:19:00 vaio cardmgr[533]: socket 1: CardBus hotplug device
> > Aug 15 21:19:00 vaio kernel: 8139too Fast Ethernet driver 0.9.25
> > Aug 15 21:19:00 vaio kernel: PCI: Setting latency timer of device 06:00.0 to 64
> > Aug 15 21:19:00 vaio kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xccb99000, 00:30:4f:1d:53:7a, IRQ 9
> > Aug 15 21:19:00 vaio kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
> > Aug 15 21:19:00 vaio insmod: Using /lib/modules/2.4.19/kernel/drivers/net/mii.o
> > Aug 15 21:19:00 vaio insmod: Symbol version prefix ''
> > Aug 15 21:19:00 vaio insmod: Using /lib/modules/2.4.19/kernel/drivers/net/8139too.o
> > Aug 15 21:19:19 vaio kernel: eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.
> > 
> > Loaded modules:
> > 
> > Module                  Size  Used by    Not tainted
> > 8139too                14272   1
> > mii                     1056   0  [8139too]
> > soundcore               3268   0  (autoclean)
> > ipv6                  124928  -1  (autoclean)
> > ds                      6368   2
> > yenta_socket            8704   2
> > pcmcia_core            34240   0  [ds yenta_socket]
> > isa-pnp                27388   0  (unused)
> > joydev                  6816   0  (unused)
> > evdev                   4096   0  (unused)
> > mousedev                3808   1
> > hid                    18944   0  (unused)
> > usbmouse                1792   0  (unused)
> > input                   3072   0  [joydev evdev mousedev hid usbmouse]
> > uhci                   23816   0  (unused)
> > usbcore                54272   1  [hid usbmouse uhci]
> > nls_iso8859-1           2848   1  (autoclean)
> > nls_cp437               4384   1  (autoclean)
> > 
> > 
> > Ah before I forget: I'm using Kernel Version 2.4.19
> > 
> > More info needed? No problem..
> > 
> > 
> > Marc Giger
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
