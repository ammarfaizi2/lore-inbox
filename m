Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSGKJip>; Thu, 11 Jul 2002 05:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317803AbSGKJio>; Thu, 11 Jul 2002 05:38:44 -0400
Received: from [217.156.100.201] ([217.156.100.201]:59288 "EHLO
	users.blastcenter.com") by vger.kernel.org with ESMTP
	id <S317802AbSGKJin>; Thu, 11 Jul 2002 05:38:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gogu Mihai <gogu@firexnet.ro>
To: "Lists (lst)" <linux@lapd.cj.edu.ro>
Subject: Re: Full-Duplex realtek 8029 ehernet card
Date: Thu, 11 Jul 2002 11:24:54 +0300
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.43L0.0207101501500.2359-100000@lapd.cj.edu.ro>
In-Reply-To: <Pine.LNX.4.43L0.0207101501500.2359-100000@lapd.cj.edu.ro>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207111124.54802.gogu@firexnet.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

modprobe ne2k-pci debug=3 full_duplex=1

tail -f /var/log/messages

Jul 11 11:00:24 firex kernel: ne2k-pci.c: v1.02 for Linux 2.2, 
10/19/2000, D. Becker/P. Gortmaker, 
http://www.scyld.com/network/ne2k-pci.html 
Jul 11 11:00:24 firex kernel: ne2k-pci.c: PCI NE2000 clone 'RealTek 
RTL-8029' at I/O 0x6000, IRQ 12. 
Jul 11 11:00:24 firex kernel: eth0: RealTek RTL-8029 found at 0x6000, 
IRQ 12, 00:00:21:6A:BB:9F. 
Jul 11 11:00:24 firex kernel: ne2k-pci.c: PCI NE2000 clone 'RealTek 
RTL-8029' at I/O 0x6100, IRQ 11. 
Jul 11 11:00:24 firex kernel: eth1: RealTek RTL-8029 found at 0x6100, 
IRQ 11, 00:00:21:22:12:4A. 

after that: ifup eth0 and ifup eth1

and test with net2k-pci-diag

./net2k-pci-diag -a
ne2k-pci-diag.c:v2.04a 6/19/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Realtek 8029 adapter at 0x6000.
The 8390 core appears to be active, so some registers will not be read.
To see all register values use the '-f' flag.
Initial window 3, registers values by window:
  Window 0: 22 00 76 7f 1e 00 8f 00 2a 40 50 43 81 00 00 00.
  Window 1: 62 00 00 21 6a bb 9f 4c 00 00 00 80 00 00 00 00.
  Window 2: a2 00 80 ff 40 ff ff ff ff ff ff ff cc e0 c9 bf.
  Window 3: e2 30 ff 04 ff 00 30 ff ff ff ff ff ff ff 29 80.
 RTL8029 transceiver: 10baseT/coax (autoselected on 10baseT link beat) 
half duplex.
  0K boot ROM.

 No interrupt sources are pending (00).
Parsing the EEPROM of a RTL8029:
 Station Address 00:00:21:6A:BB:9F (used as the ethernet address).
 Configuration is 30 00:
   0K boot ROM, half duplex
   Transceiver: 10baseT/coax (autoselected on 10baseT link beat).
 PCI Vendor ID 0xffff  Device ID 0xffff
  Subsystem ID: vendor 0xffff device 0xffff
Index #2: Found a Realtek 8029 adapter at 0x6100.
The 8390 core appears to be active, so some registers will not be read.
To see all register values use the '-f' flag.
Initial window 2, registers values by window:
  Window 0: 22 04 65 64 03 00 0e 00 5a 46 50 43 01 00 00 00.
  Window 1: 62 00 00 21 22 12 4a 65 00 00 00 80 00 00 00 00.
  Window 2: a2 00 80 ff 46 ff ff ff ff ff ff ff cc e0 c9 bf.
  Window 3: e2 30 ff 00 ff 00 30 ff ff ff ff ff ff ff 29 80.
 RTL8029 transceiver: 10baseT/coax (autoselected on 10baseT link beat) 
half duplex.
  0K boot ROM.

 No interrupt sources are pending (00).
Parsing the EEPROM of a RTL8029:
 Station Address 00:00:21:22:12:4A (used as the ethernet address).
 Configuration is 30 00:
   0K boot ROM, half duplex
   Transceiver: 10baseT/coax (autoselected on 10baseT link beat).
 PCI Vendor ID 0xffff  Device ID 0xffff
  Subsystem ID: vendor 0xffff device 0xffff

Any ideas now? ne2k-pci-diag seems to report that booth ethernet cards 
are still in half-duplex mode.

Best Regards,
Mihai

On Wednesday 10 July 2002 15:03, you wrote:
> On Wed, 10 Jul 2002, Gogu Mihai wrote:
> > Hello Linux experts,
>
> Hi,
>
> > I don`t know i a came to the right place.
> >
> > I need a little help. On my router i have 2 ethernet cards Realtek
> > 8029/bnc+utp.
> >
> > I read the documentation found on
> > http://www.scyld.com/network/ne2k-pci.html and according to this i
> > configured:
> >
> > cat /etc/modules.conf
> > alias eth0 ne2k-pci
> > options ne2k-pci debug=3 full_duplex=1
> > alias eth1 ne2k-pci
> > options ne2k-pci debug=3 full_duplex=1
>
> 		   ^^^^^^^
> 	... and tell us more!

