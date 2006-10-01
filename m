Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWJAOkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWJAOkE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 10:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWJAOkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 10:40:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:37003 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWJAOkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 10:40:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ecziwsJEKf9DscU1HdHqycQMXJC4uvI9LPIZMbs3+xzmz2p+P50kh0tWbDubjTRakfB/cccHpR0cHobxc9fCRzB4khubWEnApCUhyEm1z14+WKpNcXLFtnN2hFWPgoWRisn05/ld82RTlCoqR+fzKLliNMzvLEWjmRy9FPC3/3U=
Message-ID: <f4527be0610010740r662f8d8at4dbbf68d1543040f@mail.gmail.com>
Date: Sun, 1 Oct 2006 15:40:00 +0100
From: "Andrew Lyon" <andrew.lyon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SATA CD/DVDRW Support in 2.6.18?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Samsung SH-W163A SATA CD/DVDRW connected to jmicron
20360/20363 onboard sata controller, running kernel 2.6.18 with sr_mod
loaded I can mount recorded/original disks and read them, but if I try
to burn a cd or dvd using cdrecord, and somtimes when mounting media I
get loads of errors in dmesg and the burn fails:

ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)
ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (irq_stat 0x48000000, interface fatal error)


It looks like the interface is trying to run at 1.5Gbps which is
obviously too fast for this drive, is there any way to set the
interface speed ? I have a WD Raptor on the other sata port of the
jmicron and that works perfectly (as long as NCQ is disabled - drive
firmware bug).

What is the status of sata cd/dvdrw support? It is getting hard to buy
machines with IDE writers, most of our workstations are dell and have
only sata devices, we have similar problems with those.

Andy
