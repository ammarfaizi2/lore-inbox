Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131539AbQKRKjx>; Sat, 18 Nov 2000 05:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131583AbQKRKjn>; Sat, 18 Nov 2000 05:39:43 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:17447 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131581AbQKRKj3>; Sat, 18 Nov 2000 05:39:29 -0500
Message-ID: <3A165556.FFA4FCB6@linux.com>
Date: Sat, 18 Nov 2000 02:09:26 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: speaking of USB...(bug/hub.c)
Content-Type: multipart/mixed;
 boundary="------------9315C05FD4968D33FC33B07E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9315C05FD4968D33FC33B07E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's another one for the books.  In the recent test11 series, timing
appears to be partially broken for dev addr assignments.  If I'm lucky a
new usb device will answer back and get all the numbers set up
properly.  Regularly however a new device gets plugged in and I get
several of the below without the success at the end.  I usually need to
reboot to get my USB stuff alive again.  The below is test7.

# dmesg
hub.c: USB new device connect on bus1/1, assigned device number 6
usb-uhci.c: interrupt, status 2, frame# 121
usb.c: USB device not accepting new address=6 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 7

# lspci
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at ef80 [size=32]


# cat devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 17/900 us ( 2%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=ef80
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0707 ProdID=0200 Rev= 1.01
S:  Manufacturer=SMC, Inc
S:  Product=EZ USB/Ethernet Converter
S:  SerialNumber=0001
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=160mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=pegasus
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=128ms

-d


--------------9315C05FD4968D33FC33B07E
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------9315C05FD4968D33FC33B07E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
