Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbUKLPvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUKLPvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbUKLPvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:51:02 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:42467 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262563AbUKLPtx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:49:53 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-12.tower-45.messagelabs.com!1100274592!7354956!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROMISE Ultra133 TX2 (PDC20269)
Date: Fri, 12 Nov 2004 10:49:50 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4078@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROMISE Ultra133 TX2 (PDC20269)
Thread-Index: AcTIzvbQ12+1++ctRvKNTwgdybO24QAABTkg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Enrico Bartky" <DOSProfi@web.de>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd, what speed did you get with UDMA2? UDMA3?
Any errors in dmesg other then the ones you pasted?

Also, when benchmarking with hdparm (as it states in the man page, it is
good to run it 3 times for each run and take the average) as it can vary
sometimes.

I have also noticed if you are running hdparm -t /dev/hde when running
X, window manager, etc, I get 8-10MB/s less vs. when I run it in single
user mode.



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Enrico Bartky
Sent: Friday, November 12, 2004 10:44 AM
To: linux-kernel@vger.kernel.org
Subject: RE: PROMISE Ultra133 TX2 (PDC20269)

mysterios, .. now it says udma4 but with 7 MB/s

schrottkiste:~# hdparm -I /dev/hde

/dev/hde:

ATA device, with non-removable media
        Model Number:       FUJITSU MPD3084AT
        Serial Number:      01064533
        Firmware Revision:  DD-03-44
Standards:
        Supported: 4 3 2 1
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   16514064
        device size with M = 1024*1024:        8063 MBytes
        device size with M = 1000*1000:        8455 MBytes (8 GB)
Capabilities:
        LBA, IORDY(cannot be disabled)
        Buffer size: 512.0kB    bytes avail on r/w long: 4      Queue
depth: 1
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 16  Current = ?
        Advanced power management level: unknown setting (0x0000)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
                READ BUFFER cmd
                WRITE BUFFER cmd
                Host Protected Area feature set
           *    Look-ahead
           *    Write cache
                Power Management feature set
                Security Mode feature set
                SMART feature set
                Advanced Power Management feature set
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        24min for SECURITY ERASE UNIT.
schrottkiste:~# hdparm -t /dev/hde

/dev/hde:
 Timing buffered disk reads:   26 MB in  3.45 seconds =   7.53 MB/sec
schrottkiste:~#




__________________________________________________________
Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
