Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWDHQ1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWDHQ1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWDHQ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:27:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8579 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965016AbWDHQ1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:27:08 -0400
Subject: Re: [BUG] 2.6.16.2 (like olders) fails to suspend audio device
From: Lee Revell <rlrevell@joe-job.com>
To: patrizio.bassi@gmail.com
Cc: "Kernel," <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <4437BB29.8050502@gmail.com>
References: <4437BB29.8050502@gmail.com>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 12:27:02 -0400
Message-Id: <1144513623.22490.150.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would help if you cc'ed the right list (added)

On Sat, 2006-04-08 at 15:31 +0200, Patrizio Bassi wrote:
> I've already posted same bug some weeks ago.
> 
> this is just a reminder and to confirm bug is still there.
> 
> 00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
> 
> Alsa driver: 1370
> 
> 1) if builtin in kernel, on resume it doesn't work any more.
> 2) if built as module on resume it works with no need to remove/readd 
> module.
> 
> in both situations dmesg shows:
> 
> pnp: Failed to activate device 00:0b.
> 
> 
> Stopping tasks: ===========================================|
> Shrinking memory... done (39214 pages freed)
> pnp: Device 00:0c disabled.
> pnp: Device 00:08 disabled.
> swsusp: Need to copy 13752 pages
> ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low) 
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) 
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) 
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKD] -> GSI 9 (level, low) 
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNKA] -> GSI 11 (level, 
> low) -> IRQ 11
> usb usb1: root hub lost power or was reset
> ehci_hcd 0000:00:0a.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
> ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, 
> low) -> IRQ 10
> pnp: Device 00:08 activated.
> pnp: Failed to activate device 00:0b.
> pnp: Device 00:0c activated.
> Restarting tasks... done
> agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
> 
> lspci
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
> bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
> bridge (rev 03)
> 00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
> 00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
> (rev 74)
> 00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 50)
> 00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 50)
> 00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
> 00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP
> 
> 
> dmesg says 00:08 and 00:0c are activated..but i've no idea which devices 
> they are, lspci -vv shows nothing about that.
> 
> Ready to give more infos and test patches.
> 
> Patrizio Bassi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

