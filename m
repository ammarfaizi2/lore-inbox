Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129632AbQKXEu7>; Thu, 23 Nov 2000 23:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129996AbQKXEut>; Thu, 23 Nov 2000 23:50:49 -0500
Received: from [212.170.175.26] ([212.170.175.26]:24324 "HELO
        zaknafein.net.dhis.org") by vger.kernel.org with SMTP
        id <S129632AbQKXEun>; Thu, 23 Nov 2000 23:50:43 -0500
Date: Fri, 24 Nov 2000 05:09:48 +0100
From: Drizzt <drizzt.dourden@iname.com>
To: linux-kernel@vger.kernel.org
Subject: More info about de USB HP 8230e and problems]
Message-ID: <20001124050948.A1043@menzoberrazan.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have using the next software:

a) test11 + storage checkout from linux-usb at sourceforge ( without 
   this checkout fails too).

b) cdrecord 1.10a6

If I start to burn a CD at x4 speed, I have always the next error from
cdrecord:
Track 01: 102 of 109 MB written (fifo 100%)./opt/schily/bin/cdrecord:
Input/output error. write_g1: scsi sendcmd: retryable error
CDB:  2A 00 00 00 CD 03 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 03 00 00 00 00 12 00 00 00 00 0C 09 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x0C Qual 0x09 (write error - loss of streaming) Fru 0x0
Sense flags: Blk 0 (not valid)

Well the size of track varies in function that have buring.

With the storage-usb debug active I have the next log:

usb-storage: Command WRITE_10 (10 bytes)
usb-storage: 2a 00 00 00 cd 03 00 00 1f 00 ff bf
usb-storage: Transferred out 38 of 38 bytes
usb-storage: Transferred out 32768 of 32768 bytes
usb-storage: Transferred out 30720 of 30720 bytes
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Transferred out 14 of 14 bytes
usb-storage: Waited not busy for 0 steps
usb-storage: Transferred out 12 of 12 bytes
usb-storage: Waited not busy for 2 steps
usb-storage: Transferred in 18 of 18 bytes
usb-storage: 70 00 03 00 00 00 00 12 00 00 00 00 0C 09 00 00
usb-storage: 00 00
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x3, ASC: 0xc, ASCQ: 0x9
usb-storage: Medium Error: (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called

Thesis a i810 based computer.

If I burning the CD with the same software at x2 speed with these computer I
have no problem burning the CD.

But, if I test the CDRW in a laptop with a VIA chipset, I can burn nothing nor
x1 speed :(. The chipset of the laptop have I VT82C586B as USB device. The
kernel here it's test10.


Saludos
Drizzt
-- 
... Los viejos ecologistas nunca mueren, simplemente son reciclados.
____________________________________________________________________________
Drizzt Do'Urden                Three rings for the Elves Kings under the Sky   
drizzt.dourden@iname.com       Seven for the Dwarf_lords in their  
                               hall of stone
                               Nine for the Mortal Men doomed to die 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
