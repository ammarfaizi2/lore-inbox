Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945923AbWBOMok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945923AbWBOMok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbWBOMok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:44:40 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:53382 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945923AbWBOMok convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:44:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tP2A9klWBJHof6ZvQgiPAt7U56coMShoy4X/JBywQqR717X0KvKdXYUbfZPstzPM8JGkLewg1fYvJZxj9JuvpeFkU5z9J99JJ+xv4sEGxYTd9jjISbyW9t2UUDIBIUHsJjy9MHvWc10iTQrdHTn0Wo2MIWxZvWZd9KDx2cynMaA=
Message-ID: <9871ee5f0602150444jf3e2aa9l33c0606ad63439c9@mail.gmail.com>
Date: Wed, 15 Feb 2006 07:44:38 -0500
From: Timothy Miller <theosib@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: HELP: Problem with radeonfb setting wrong resolution
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43F2BCF6.805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9871ee5f0602141233t3cf11775lcb6351f31d4f377e@mail.gmail.com>
	 <1139955612.7903.46.camel@localhost.localdomain>
	 <9871ee5f0602141817p12617034o7f118710775cc73c@mail.gmail.com>
	 <43F2BCF6.805@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/06, Antonino A. Daplas <adaplas@gmail.com> wrote:

>
> Looks like an EDID problem.  Can you change #undef DEBUG to #define DEBUG
> in drivers/video/fbmon.c and post your dmesg again?
>

Well, I did what you asked.  I modified the file, recompiled the
kernel (fbmon.o did get rebuilt), and copied over the kernel.  I don't
see any extra messages in here, however.  I looked through dmesg
elsewhere, and didn't find anything that seemed to relate.  I
double-checked what I did, but no change.  Here's the only stuff I can
find in dmesg that seems to relate to video:

radeonfb_pci_register BEGIN
GSI 17 sharing vector 0xC1 and IRQ 17
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 21 (level, low) -> IRQ 193
radeonfb (0000:02:05.0): Found 65536k of DDR 64 bits wide videoram
radeonfb (0000:02:05.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=150.00 Mhz, System=150.00 MHz
radeonfb: PLL min 12000 max 35000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found TMDS panel
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found TMDS panel
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Guessing panel info...
radeonfb: Assuming panel size 8x1
hStart = 664, hEnd = 760, hTotal = 800
vStart = 409, vEnd = 411, vTotal = 450
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c0292
v_total_disp = 0x18f01c1	   vsync_strt_wid = 0x820198
pixclock = 39729
freq = 2517
freq = 2517, PLL min = 12000, PLL max = 35000
ref_div = 60, ref_clk = 2700, output_freq = 20136
ref_div = 60, ref_clk = 2700, output_freq = 20136
post div = 0x3
fb_div = 0x1bf
ppll_div_3 = 0x301bf
hStart = 664, hEnd = 760, hTotal = 800
vStart = 409, vEnd = 411, vTotal = 450
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c0292
v_total_disp = 0x18f01c1	   vsync_strt_wid = 0x820198
pixclock = 39729
freq = 2517
freq = 2517, PLL min = 12000, PLL max = 35000
ref_div = 60, ref_clk = 2700, output_freq = 20136
ref_div = 60, ref_clk = 2700, output_freq = 20136
post div = 0x3
fb_div = 0x1bf
ppll_div_3 = 0x301bf
hStart = 664, hEnd = 760, hTotal = 800
vStart = 409, vEnd = 411, vTotal = 450
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c0292
v_total_disp = 0x18f01c1	   vsync_strt_wid = 0x820198
pixclock = 39729
freq = 2517
freq = 2517, PLL min = 12000, PLL max = 35000
ref_div = 60, ref_clk = 2700, output_freq = 20136
ref_div = 60, ref_clk = 2700, output_freq = 20136
post div = 0x3
fb_div = 0x1bf
ppll_div_3 = 0x301bf
Console: switching to colour frame buffer device 128x48
radeonfb (0000:02:05.0): ATI Radeon QY
radeonfb_pci_register END

Thanks.
