Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRJ2Nwm>; Mon, 29 Oct 2001 08:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275527AbRJ2Nwc>; Mon, 29 Oct 2001 08:52:32 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:62477 "HELO due.stud.ntnu.no")
	by vger.kernel.org with SMTP id <S275680AbRJ2NwV>;
	Mon, 29 Oct 2001 08:52:21 -0500
Date: Mon, 29 Oct 2001 14:52:19 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011029145219.B16677@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <E15y9uL-0002F3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15y9uL-0002F3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 29, 2001 at 10:44:41AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> Which kernel version, which eepro100 chip ?

All kernels so far, starting with 2.4.0 (the first one we tested), and we've
now come to 2.4.13 and the error is still there. 

Output from lspci -vvvxx:
02:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Dell Computer Corporation: Unknown device 009b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fe900000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at bcc0 [size=64]
        Region 2: Memory at fe500000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fe600000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 17 01 90 02 08 00 00 02 08 20 00 00
10: 00 00 90 fe c1 bc 00 00 00 00 50 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9b 00
30: 00 00 60 fe dc 00 00 00 00 00 00 00 05 01 08 38

Output from dmesg:
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:B0:D0:F0:8B:65, IRQ 16.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 07195d-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.


I'd gladly help you track down and fix this problem, and if you need
any more info (or testing of patches) just tell me :)

-- 
Thomas
