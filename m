Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVCGXWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVCGXWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVCGXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:22:14 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:31377 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261242AbVCGWiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:38:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hB3e39jltJsMhhxRs/BHigtyG2ggnCbkazVlvY/UW9lkmzl1oQaNsIZ0c2z2eTl4gHiZxngsNGEv7L+CcXJizjcpKNoodNYfWxEMZZcQT3jjVwk0rjou7fKA26a9TAbLL3a1RuPqZRJnJQrW65NDgKqdGIoPUUHUshHn0re5tgs=
Message-ID: <21d7e997050307143832a8239c@mail.gmail.com>
Date: Tue, 8 Mar 2005 09:38:04 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Lobiuc Andrei <alobiuc@yahoo.com>
Subject: Re: PROBLEM: Radeon card displays incorrectly under the 2.6.11 version unless compiled with SMP support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050306174932.56406.qmail@web30909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050306174932.56406.qmail@web30909.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005 09:49:32 -0800 (PST), Lobiuc Andrei
<alobiuc@yahoo.com> wrote:
> 1.Radeon card displays incorrectly under the 2.6.11
> version unless compiled with SMP support.
> 2.After compiling and installing the 2.6.11 kernel
> version, my ASUS Radeon 9200SE 128 MB graphic card
> does not display correctly in plain VGA mode. The same
> card has no problem with the 2.6.10 kernel.
> Regarding radeonfb, dmesg reports:
> "radeonfb_pci_register BEGIN
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level,
> low) -> IRQ 169
> radeonfb (0000:01:00.0): Found 131072k of DDR 64 bits
> wide videoram
> radeonfb (0000:01:00.0): mapped 16384k videoram
> radeonfb: Found Intel x86 BIOS ROM Image
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12)
> Memory=200.00 Mhz, System=166.00 MHz
> radeonfb: PLL min 20000 max 40000
> 1 chips in connector info
>  - chip 1 has 1 connectors
>   * connector 0 of type 2 (CRT) : 2300
> Starting monitor auto detection...
> radeonfb: I2C (port 1) ... not found
> radeonfb: I2C (port 2) ... not found
> radeonfb: I2C (port 3) ... found CRT display
> radeonfb: I2C (port 4) ... not found
> radeonfb: I2C (port 2) ... not found
> radeonfb: I2C (port 4) ... not found
> radeonfb: I2C (port 3) ... found CRT display
> radeonfb: Monitor 1 type CRT found
> radeonfb: EDID probed
> radeonfb: Monitor 2 type no found
> hStart = 737, hEnd = 808, hTotal = 896
> vStart = 401, vEnd = 404, vTotal = 417
> h_total_disp = 0x59006f    hsync_strt_wid = 0x8802eb
> v_total_disp = 0x18f01a0           vsync_strt_wid =
> 0x830190
> pixclock = 38210
> freq = 2617
> freq = 2617, PLL min = 20000, PLL max = 40000
> ref_div = 12, ref_clk = 2700, output_freq = 20936
> ref_div = 12, ref_clk = 2700, output_freq = 20936
> post div = 0x3
> fb_div = 0x5d
> ppll_div_3 = 0x3005d
> Console: switching to colour frame buffer device 90x25
> radeonfb (0000:01:00.0): ATI Radeon Yd
> radeonfb_pci_register END
> kobject_register failed for radeonfb (-17)
>  [<c01cf0c7>] kobject_register+0x57/0x60
>  [<c0262707>] bus_add_driver+0x57/0xd0
>  [<c0262d5f>] driver_register+0x2f/0x40
>  [<c01db547>] pci_create_newid_file+0x27/0x30
>  [<c01dba42>] pci_register_driver+0x62/0x80
>  [<c05b3b40>] radeonfb_old_init+0x40/0x50
>  [<c059c7fb>] do_initcalls+0x2b/0xc0
>  [<c01002c0>] init+0x0/0x110
>  [<c01002c0>] init+0x0/0x110
>  [<c01002ef>] init+0x2f/0x110
>  [<c010086c>] kernel_thread_helper+0x0/0x14
>  [<c0100871>] kernel_thread_helper+0x5/0x14
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux agpgart interface v0.100 (c) Dave Jones
> [drm] Initialized drm 1.0.0 20040925
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level,
> low) -> IRQ 169
> [drm] Initialized radeon 1.14.0 20050125 on minor 0:
> ATI Technologies Inc RV280[Radeon 9200 SE]"
> 

It looks like you have no agpgart chipset driver loaded or if DRM is
in the kernel, the agpgart chipset driver should be to...

Dave.
