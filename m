Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbULLUoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbULLUoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbULLUoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:44:02 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:13540 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262102AbULLUnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:43:32 -0500
Message-ID: <41BCAD6F.50007@dgreaves.com>
Date: Sun, 12 Dec 2004 20:43:27 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eldad Zack <eldad@stoneshaft.ath.cx>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: kernel boot hang, SATA_VIA compiled without APIC_IO
References: <200412030345.45282.eldad@stoneshaft.ath.cx>
In-Reply-To: <200412030345.45282.eldad@stoneshaft.ath.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for posting this Eldad, I had the same problem and this saved 
lots of trial and error!!

As an FYI all I did was exchange my ASUS A7V600 with an ASUS A7V600-X. 
Maybe the BIOS changed version, maybe the chipset is different - not 
easy to tell.
Since I boot from my SATA drive this was quite troubling. Luckily I 
still had an old 2.6.6 kernel.

I had to revert back to a 2.6.6 kernel, 2.6.7 wouldn't work.

Jeff (or whoever) I too would be happy to help debug if there's anything 
I can do.

I can't check the exact failure point for a week (away from the machine) 
but here's the relevant bit of the dmesg (admitedley from a good booting 
kernel with APIC_IO set) showing (simulated) the point where the failure 
occured:
libata version 1.02 loaded.
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 0
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA000 irq 20
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA402 bmdma 0xA008 irq 20
ata1: dev 0

After I get back on 19th Dec I'll be happy to try additional tests, 
provide additional info etc if anyone asks.

HTH

David

Eldad Zack wrote:

>Hello,
>
>I've recently got a SATA capable machine (Via chipset) and I've exprienced a 
>nasty hang at boottime, using kernel 2.6.9.
>After some recompiling different parameters it boiled down to APIC_IO being 
>not selected (this is a UP machine).
>
>Without APIC_IO selected the system would hang while loading SATA.
>
>I've only tried 2.6.5 to notice it would not hang but would emit messeges as 
>"hde: lost interrupt", and eventually go on with the boot, the sata being 
>unusable.
>
>Out of curiousity, I'd like to know if APIC_IO is absolutly needed when 
>dealing with SATA, and also, I'd like to help debug this problem so that a 
>kernel compiled without APIC_IO would at the very least not hang...
>
>
>  
>

