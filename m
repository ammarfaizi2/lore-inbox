Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135658AbRDSNJp>; Thu, 19 Apr 2001 09:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135659AbRDSNJe>; Thu, 19 Apr 2001 09:09:34 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:9968 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S135658AbRDSNJP>; Thu, 19 Apr 2001 09:09:15 -0400
Message-ID: <3ADEE2D7.B17C3BF8@tac.ch>
Date: Thu, 19 Apr 2001 15:06:31 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org, Donald Becker <becker@scyld.com>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104181330200.32629-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Anyway, Roberto, if you could give the starfire driver in 2.2.19 a try,
> I'd appreciate it. You mentioned looking at the code, did you actually
> test it?

Ok, I replaced the motherboard and did the remaining tests. Everything 
looks fine up to 3 quadboards, 2 3c905C and one eepro100. The excerpt:

 3c59x.c 18Feb01 Donald Becker and others
http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905C Tornado at 0x3000,  00:01:03:1f:50:11, IRQ 11
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
eth1: 3Com 3c905C Tornado at 0x3080,  00:01:03:1f:50:14, IRQ 11
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
eth2: Intel PCI EtherExpress Pro100 82557, 00:D0:B7:A7:DD:78, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 Updates and info at http://www.scyld.com/network/starfire.html
 (unofficial 2.2.x kernel port, version 1.2.8, March 7, 2001)
eth3: Adaptec Starfire 6915 at 0x90006000, 00:00:d1:ed:eb:e9, IRQ 10.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth4: Adaptec Starfire 6915 at 0x90087000, 00:00:d1:ed:eb:ea, IRQ 11.
eth4: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth5: Adaptec Starfire 6915 at 0x90108000, 00:00:d1:ed:eb:eb, IRQ 11.
eth5: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth6: Adaptec Starfire 6915 at 0x90189000, 00:00:d1:ed:eb:ec, IRQ 11.
eth6: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth7: Adaptec Starfire 6915 at 0x9020a000, 00:00:d1:ed:e5:01, IRQ 5.
eth7: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth8 is deferred
eth8: Adaptec Starfire 6915 at 0x9028b000, 00:00:d1:ed:e5:02, IRQ 11.
eth8: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth9 is deferred
eth9: Adaptec Starfire 6915 at 0x9030c000, 00:00:d1:ed:e5:03, IRQ 11.
eth9: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth10 is deferred
eth10: Adaptec Starfire 6915 at 0x9038d000, 00:00:d1:ed:e5:04, IRQ 11.
eth10: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth11 is deferred
eth11: Adaptec Starfire 6915 at 0x9040e000, 00:00:d1:ed:e8:c5, IRQ 11.
eth11: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth12 is deferred
eth12: Adaptec Starfire 6915 at 0x9048f000, 00:00:d1:ed:e8:c6, IRQ 11.
eth12: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth13 is deferred
eth13: Adaptec Starfire 6915 at 0x90510000, 00:00:d1:ed:e8:c7, IRQ 11.
eth13: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device eth14 is deferred
eth14: Adaptec Starfire 6915 at 0x90591000, 00:00:d1:ed:e8:c8, IRQ 11.
eth14: MII PHY found at address 1, status 0x7809 advertising 01e1.

A 2.2.x UP-APIC patch would maybe improve things here while under
heavy load. I'm using such boxes as packetfilters. All quadboards
get IRQ 11 which is rather nasty considering a possible throughput
of 40Mbit/s per NIC.

Would be nice if I could fix the "early initialization ..." problem
too. I'm still checking the Space.c code:

#define ETH_NOPROBE_ADDR 0xffe0

static struct device eth7_dev = {
    "eth7", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, NEXT_DEV,
ethif_probe };
static struct device eth6_dev = {
    "eth6", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth7_dev,
ethif_probe };
static struct device eth5_dev = {
    "eth5", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth6_dev,
ethif_probe };
static struct device eth4_dev = {
    "eth4", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth5_dev,
ethif_probe };
static struct device eth3_dev = {
    "eth3", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth4_dev,
ethif_probe };
static struct device eth2_dev = {
    "eth2", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth3_dev,
ethif_probe };
static struct device eth1_dev = {
    "eth1", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth2_dev,
ethif_probe };

static struct device eth0_dev = {
    "eth0", 0, 0, 0, 0, ETH0_ADDR, ETH0_IRQ, 0, 0, 0, &eth1_dev, ethif_probe };

#   undef NEXT_DEV
#   define NEXT_DEV     (&eth0_dev)

Would it make sense to extend this structure? Andrew Morgan made such a
suggestion
but why is that eth7 limitation? And why can't I use more then 16 ethernet
interfaces?

eth15: Adaptec Starfire 6915 at 0x90612000, 00:00:d1:ed:e8:c5, IRQ 7.
eth15: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device  is deferred
: Adaptec Starfire 6915 at 0x90693000, 00:00:d1:ed:e8:c6, IRQ 11.
: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device  is deferred
: Adaptec Starfire 6915 at 0x90714000, 00:00:d1:ed:e8:c7, IRQ 11.
: MII PHY found at address 1, status 0x7809 advertising 01e1.
early initialization of device  is deferred
: Adaptec Starfire 6915 at 0x90795000, 00:00:d1:ed:e8:c8, IRQ 11.
: MII PHY found at address 1, status 0x7809 advertising 01e1.

Why isn't it possible to put the "probed" counter into the Space.c for all
network drivers? So people would not need to care about and the driver
code would yet be more generic (at least a little bit). I refer to the code:

int __init starfire_probe(struct net_device *dev)
{
        static int __initdata probed = 0;
        if (probed)
                return -ENODEV;
        probed++;
        return pci_module_init(&starfire_driver);
}

Any pointers, sources are welcome and in hope for some further wisdom,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
