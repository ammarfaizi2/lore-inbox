Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTIOVeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTIOVeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:34:36 -0400
Received: from ns.suse.de ([195.135.220.2]:2528 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261645AbTIOVec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:34:32 -0400
Date: Mon, 15 Sep 2003 23:34:30 +0200
From: Olaf Hering <olh@suse.de>
To: =?utf-8?Q?Dani=C3=ABl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
Message-ID: <20030915213430.GA1833@suse.de>
References: <20030915210421.GA311@suse.de> <Pine.LNX.4.44.0309152308410.24675-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0309152308410.24675-100000@deadlock.et.tudelft.nl>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 15, Daniël Mantione wrote:

> 
> 
> On Mon, 15 Sep 2003, Olaf Hering wrote:
> 
> > pre4 doesnt work on my ibook1, the xclk value is 125, but should be 50.
> 
> That is not correct. The default xclk for the Rage Mobility M1 is
> 125 MHz and this is indeed the case, for example on Geert's VAIO.
> See also the e-mail below from Vernon Chiang from ATi.
> 
> On x86, I usually ask a copy of the video driver to be able to check the
> driver information table of that particular implementation. Do you have
> something similair from the Open Firmware?

This is in the device tree, not very helpful. I'm not sure where XFree86
gets the value 50. It seems to poke some regs here and there, havent
looked too closely.

olaf@mango:/proc/device-tree/pci@f0000000/ATY,RageM_Lp@10> /sbin/lsprop
vendor-id        00001002 (4098)
device-id        00004c4e (19534)
revision-id      00000064 (100)
class-code       00030000 (196608)
interrupts       00000001
min-grant        00000008
max-latency      00000000
devsel-speed     00000001
fast-back-to-back
ATY,Status       00000000
ATY,Flags        00000180 (384)
width            00000320 (800)
height           00000258 (600)
depth            00000008
linebytes        00000320 (800)
device_type      "display"
character-set    "ISO8859-1"
iso6429-1983-colors
reg              00008000 00000000 00000000 00000000 00000000
                 02008030 00000000 00000000 00000000 00020000
                 02008010 00000000 00000000 00000000 01000000
                 02008018 00000000 00000000 00000000 00001000
AGP_Address_Range 00000000 ffffffff
AGP_Address_Block 02000000 (33554432)
AGP_Alignment    02000000 (33554432)
AGP_AllowOverlap 00000001
name             "ATY,RageM_Lp"
model            "ATY,RageMobilityL"
ATY,Rom#         "113-XXXXX-110"
backlight-control 00000001 00000000
ATY,Fcode        "1.69"
assigned-addresses 82008010 00000000 91000000 00000000 01000000
                 82008030 00000000 90020000 00000000 00020000
                 82008018 00000000 90000000 00000000 00001000
AGP_Master
driverID         "RageMobility_L 1.0b32"
address          91000000
AAPL,gray-page   00000000
linux,phandle    ff93b3f8


All I see is that 50 works, 125 gives black/white stripes and a large
blinking cursor.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
