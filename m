Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRFTVxy>; Wed, 20 Jun 2001 17:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262686AbRFTVxo>; Wed, 20 Jun 2001 17:53:44 -0400
Received: from gw-us4.philips.com ([63.114.235.90]:57873 "EHLO
	gw-us4.philips.com") by vger.kernel.org with ESMTP
	id <S262389AbRFTVxc> convert rfc822-to-8bit; Wed, 20 Jun 2001 17:53:32 -0400
From: steve.snyder@philips.com
To: <linux-kernel@vger.kernel.org>
Subject: Any gain to supporting only a single PCMCIA slot?
Message-ID: <0056910012761441000002L112*@MHS>
Date: Wed, 20 Jun 2001 16:56:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	name="MEMO 06/20/01 16:53:17"
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

PCMCIA/Cardbus controllers typically (always?) support 2 slots, and system 
resources are allocated to support those slots.  When you build PCMCIA 
support into your kernel, you are implicitly asking for both slots to be 
supported.  I'm wondering if it would be worthwhile to let the user opt out of 
supporting one of the slots.  

Compaq, in their finite wisdom, only provides a single Type2 Cardbus slot 
on my Presario 1260 notebook.  The controller (a TI PCI1131, see below) 
can handle 2 slots, of course, but only a single physical connector is 
present on this machine.  Therefore I will never get the use of half of 
the controller, including the I/O address, etc. that the kernel has 
allocated for it.  

Would it be worth the savings in system resources to allow support for 
only a single slot?

Thank you.

-----------------------------------------------------------

# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-09ffffff : System RAM
  00100000-001d1aad : Kernel code
  001d1aae-0021083f : Kernel data
10000000-10000fff : Texas Instruments PCI1131
10001000-10001fff : Texas Instruments PCI1131 (#2)
10400000-107fffff : PCI CardBus #01
  10400000-1041ffff : PCI device 10b7:6564
10800000-10bfffff : PCI CardBus #01
  10800000-1080007f : PCI device 10b7:6564
  10800080-108000ff : PCI device 10b7:6564
  10800100-108001ff : PCI device 10b7:6565
  10800200-1080027f : PCI device 10b7:6565
10c00000-10ffffff : PCI CardBus #05
11000000-113fffff : PCI CardBus #05
fd000000-fdffffff : Neomagic Corporation NM2160 [MagicGraph 128XD]
fea00000-febfffff : Neomagic Corporation NM2160 [MagicGraph 128XD]
fecff000-fecfffff : OPTi Inc. 82C861
fed00000-fedfffff : Neomagic Corporation NM2160 [MagicGraph 128XD]
