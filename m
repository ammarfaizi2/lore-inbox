Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWEBD2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWEBD2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 23:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWEBD2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 23:28:13 -0400
Received: from secure.htb.at ([195.69.104.11]:14859 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932357AbWEBD2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 23:28:13 -0400
Date: Tue, 2 May 2006 05:28:03 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>
Subject: Re: [swsusp] not enough memory [solved with 2.6.17-rc3]
Message-Id: <20060502052803.f1875269.delist@gmx.net>
In-Reply-To: <20060218005814.6548092d.delist@gmx.net>
References: <20060218005814.6548092d.delist@gmx.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FalYS-00049j-00*p94Iwuj8Irs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Richard Mittendorfer <delist@gmx.net> (Sat, 18 Feb 2006 00:58:14 +0100):
> On my 64MB notebook I get the following message, when going swsusp:
> 
> ..
> swsusp: Need to copy 15526 pages
> swsusp: Not enough free memory
> Error -12 suspending
> ..
> 
> # free
>              total     used     free   shared    buffers   cached
> Mem:         62760    59884     2876        0       3828    16052
> -/+ buffers/cache:    40004    22756
> Swap:       200804    30316   170488
> 
> If I end all apps but the XServer it works. I've allready added some
> more swapspace, but that didn't help. So, how much memory will I need
> for a successful suspend or better (since i can't stuff any more into 
> it) is there a way to minimize the amount needed?

Seems fixed with 2.6.17-rc3. Field-testet on the loaded box several times.

_._. .._ _  .... . ._. .  __..__  _._. .._ _  .... . ._. .
libre powermanagement[2300]: suspend to disk.
libre powermanagement[2309]: Found some modules loaded .. unloading
libre kernel: ACPI: PCI interrupt for device 0000:05:00.0 disabled
libre kernel: ath_pci: driver unloaded
libre kernel: Stopping tasks: ====================================================|
libre kernel: Shrinking memory...  ^H-^H\^Hdone (10007 pages freed)
libre kernel: ACPI: PCI interrupt for device 0000:00:13.1 disabled
libre kernel: ACPI: PCI interrupt for device 0000:00:13.0 disabled
libre kernel: swsusp: Need to copy 6061 pages
libre kernel: ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
libre kernel: PCI: Setting latency timer of device 0000:00:13.0 to 64
libre kernel: ACPI: PCI Interrupt 0000:00:13.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
libre kernel: PCI: Setting latency timer of device 0000:00:13.1 to 64
libre kernel: Restarting tasks... done
libre powermanagement[2344]: Reloading modules ..
_._. .._ _  .... . ._. .  __..__  _._. .._ _  .... . ._. .

big THX, 

ritch
