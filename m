Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRKDB7j>; Sat, 3 Nov 2001 20:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277398AbRKDB7U>; Sat, 3 Nov 2001 20:59:20 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:26529 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277382AbRKDB7Q>;
	Sat, 3 Nov 2001 20:59:16 -0500
Date: Sun, 04 Nov 2001 00:59:17 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@alex.org.uk
Cc: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] IBM T23; quirks force enable interrupts in APM set
Message-ID: <23580000.1004835556@araucaria>
In-Reply-To: <E160BnF-0007ME-00@the-village.bc.nu>
In-Reply-To: <E160BnF-0007ME-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

> Send me the dmi strings (dmidecode output) for the old and new BIOS, the
> URL for the firmware and not only can I make the kernel ensure they are
> called IRQ off, I can make it tell you where ot get new firmware

Short of dmidecode, assuming you're going to do what I think
you're going to do, I think the following should be sufficient
(change dmi_printk to use printk). If you really need dmidecode,
give me a pointer to it, not that I'm sure how to revert the
BIOS image...

This is assuming it's the BIOS which causes the problem, as opposed
to the embedded controller which I upgraded from 1.00 to 1.02
contemperaneously.

And the answer to 'where is the new firmware' is, for BIOS & embedded
controller:
  http://www.pc.ibm.com/qtechinfo/MIGR-39366.html
  http://www.pc.ibm.com/qtechinfo/MIGR-40022.html

Sadly they aren't indexed properly from the main IBM site (i.e.
find 'T23 BIOS' finds 1.02).


Old (BIOS 1.01b)

All processors have done init_idle
DMI 0.0 present.
48 structures occupying 1720 bytes.
DMI table at 0x27F7C000.
BIOS Vendor: IBM
BIOS Version: 1AET38WW (1.01b)
BIOS Release: 07/27/2001
System Vendor: IBM.
Product Name: 26479LU.
Version Not Available.
Serial Number 787PR4K.
Board Vendor: IBM.
Board Name: 26479LU.
Board Version: Not Available.
Asset Tag: No Asset Information.
IBM machine detected. Enabling interrupts during APM calls.

New Bios (1.03b)

DMI 0.0 present.
48 structures occupying 1720 bytes.
DMI table at 0x27F7C000.
BIOS Vendor: IBM
BIOS Version: 1AET43WW (1.03b)
BIOS Release: 09/25/2001
System Vendor: IBM.
Product Name: 26479LU.
Version Not Available.
Serial Number 787PR4K.
Board Vendor: IBM.
Board Name: 26479LU.
Board Version: Not Available.
Asset Tag: No Asset Information.
IBM machine detected. Enabling interrupts during APM calls.


--
Alex Bligh
