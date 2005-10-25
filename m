Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVJYSgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVJYSgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 14:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVJYSgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 14:36:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932296AbVJYSgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 14:36:07 -0400
Date: Tue, 25 Oct 2005 11:35:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Burton Windle <bwindle@fint.org>, Paulo Marques <pmarques@grupopie.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <Pine.LNX.4.63.0510251417590.1508@postal>
Message-ID: <Pine.LNX.4.64.0510251130530.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
 <Pine.LNX.4.63.0510251417590.1508@postal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Oct 2005, Burton Windle and Paulo Marques wrote:
> 
> $ dmesg -s 1000000 | grep PIIX4
> PCI quirk: region 0800-083f claimed by PIIX4 ACPI
> PCI quirk: region 0840-085f claimed by PIIX4 SMB
> PIIX4: IDE controller at PCI slot 0000:00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later

Ok, neither of you had any of those special quirks in use, just the 
standard ACPI/SMB quirk that we've been aware of for a long time.

It's quite possible (and even likely) that they are mainly used on 
laptops. The main reason to use those magic device resource quirks is 
because of something like a simple ISA'ish special device like a LCD 
brightness controller or special button hardware.

So for example, it would be interesting to see somebody with a Sony VAIO 
laptop with the magic SonyPI device. That's exactly the kind of thing that 
might be decoded by a southbridge quirk.

But keep the reports coming. Even a "nothing shows up" report is actually 
rather encouraging in the sense that if I turn the printk() into a real 
PCI resource setting quirk, at least it won't break anything on hardware 
like yours ;)

Thanks,

		Linus
