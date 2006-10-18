Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWJRAEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWJRAEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWJRAEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 20:04:47 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7547 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751269AbWJRAEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 20:04:46 -0400
Date: Tue, 17 Oct 2006 18:04:45 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
In-reply-to: <fa.paSx93/SManW+OpcJogK3J+c4ko@ifi.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-id: <45356F9D.1040801@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
References: <fa.+LL0mtbE/Bz60PyS85+t8B79Ezs@ifi.uio.no>
 <fa.1SqKNeCDF8Npq346iTKoMm9VsZA@ifi.uio.no>
 <fa.Pv0aCiuECqQxYFPaYvteocXd8Uw@ifi.uio.no>
 <fa.bjzNjOSBu3uMj6sIe3BIYFkx68o@ifi.uio.no>
 <fa.KSK/FAnjEXEBkiw4cVerx6eh67U@ifi.uio.no>
 <fa.paSx93/SManW+OpcJogK3J+c4ko@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
> On Wed, Oct 18, 2006 at 12:26:25AM +0100, Alan Cox wrote:
>> Ar Maw, 2006-10-17 am 18:23 -0400, ysgrifennodd Ryan Richter:
>>> 02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
>>> 	Subsystem: Marvell Technology Group Ltd. Unknown device 6101
>> That should work with libata and the newest driver version I posted (the
>> earlier one won't handle the 6101 just 6145). You need at least rev
>> 0.0.4t.
> 
> OK, now it's doing a little better.  It seems to recognize the
> controller and drive, but it's not getting assigned a /dev/[sh]d? device
> (it doesn't show up in /proc/diskstats, e.g.).  Here's the relevant
> portion of dmesg:
> 
> 
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:02:00.0 to 64
> ata5: PATA max UDMA/100 cmd 0x1018 ctl 0x1026 bmdma 0x1000 irq 17
> scsi4 : pata_marvell
> BAR5:00:00 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00 0C:01 0D:00 0E:00 0F:00 
> ata5.00: ATAPI, max UDMA/33
> ata5.00: applying bridge limits
> ata5.00: configured for UDMA/33
> scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H10N  JL10 PQ: 0 ANSI: 5
> scsi 4:0:0:0: Attached scsi generic sg0 type 5

Is the sr driver compiled in/loaded? The drive will show up as something 
like /dev/sr0 or /dev/scd0, depending on distribution.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

