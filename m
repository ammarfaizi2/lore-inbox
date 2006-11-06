Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWKFATr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWKFATr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 19:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWKFATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 19:19:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422864AbWKFATq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 19:19:46 -0500
Date: Sun, 5 Nov 2006 16:19:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Remi <remi.colinet@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc4-mm2: ahci: probe of 0000:00:1f.2 failed with error
 -16
Message-Id: <20061105161941.ec64ae70.akpm@osdl.org>
In-Reply-To: <1162764770.454e61e2db5ff@imp3-g19.free.fr>
References: <1162764770.454e61e2db5ff@imp3-g19.free.fr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Nov 2006 23:12:50 +0100
Remi <remi.colinet@free.fr> wrote:

> Hi all,
> 
> I'm getting the following error with 2.6.19-rc4-mm2 on Dell D610.
> 
> SCSI subsystem initialized
> libata version 2.00 loaded.
> ahci 0000:00:1f.2: version 2.0
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
> PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> ahci: probe of 0000:00:1f.2 failed with error -16
> ata_piix 0000:00:1f.2: version 2.00ac7
> ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> ata_piix: probe of 0000:00:1f.2 failed with error -16
> Kernel panic - not syncing: Attempted to kill init!
> 
> A Google search doesn't help to fix this error.
> 
> 2.6.19-rc4 boots fine with similar .config file.
> Any idea (ahci, pci)?
> 
> Should I start a bisecting search?
> 
> I have caught the full 2.6.19-rc4-mm2 boot messages over a serial cable if it
> can help.
> 

Do you have CONFIG_USB_MULTITHREAD_PROBE=y?  If so, try =n.

Yes please send the full dmesg for both -rc4 and for -rc4-mm2, thanks.
