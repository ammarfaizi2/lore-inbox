Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTHZE0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbTHZE0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:26:53 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:57757
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262566AbTHZEZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:25:06 -0400
Message-ID: <16202.57600.498532.587264@wombat.chubb.wattle.id.au>
Date: Tue, 26 Aug 2003 14:24:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Peter Chubb <peter@chubb.wattle.id.au>
To: ajoshi@shell.unixbox.com
CC: linux-kernel@vger.kernel.org
Subject: Radeon FB in 2.6.0-test4 fails for me
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	On a Clevo laptop with a Radeon Mobility M7 LW (AGP), enabling
	the Radeon frame buffer results in an unusable LCD display (as
	if the horizontal and/or vertical sync were incorrect -- lots
	of skewed diagonal lines)

The kernel log shows this:

 radeonfb_pci_register BEGIN
 radeonfb: ref_clk=2700, ref_div=12, xclk=16600 from BIOS
 radeonfb: probed DDR SGRAM 65536k videoram
 radeon_get_moninfo: bios 4 scratch = 1000004
 radeonfb: panel ID string: Samsung LTN150P1-L02
 radeonfb: detected DFP panel size from BIOS
 radeonfb: probed DDR SGRAM 65536k videoram
 radeon_get_moninfo: bios 4 scratch = 1000004
 radeonfb: panel ID string: Samsung LTN150P1-L02
 radeonfb: detected DFP panel size from BIOS: 1400x1050
 radeonfb: ATI Radeon M7 LW DDR SGRAM 64 MB
 radeonfb: DVI port LCD monitor connected
 radeonfb: CRT port no monitor connected
 radeonfb_pci_register END
 hStart = 1440, hEnd = 1552, hTotal = 1688
 vStart = 1050, vEnd = 1053, vTotal = 1063
 h_total_disp = 0xae00d2^I   hsync_strt_wid = 0x8e059a
 v_total_disp = 0x4190426^I   vsync_strt_wid = 0x830419
 post div = 0x2
 fb_div = 0x60
 ppll_div_3 = 0x10060
 ron = 1792, roff = 22036
 vclk_freq = 10800, per = 787
 Console: switching to colour frame buffer device 175x65


With FBDEV disabled in X, I see this in Xfree86.0.log:
(WW) RADEON(0): LCD: Using default hsync range of 28.00-33.00kHz
(WW) RADEON(0): LCD: using default vrefresh range of 43.00-72.00Hz
(II) RADEON(0): Clock range:  12.00 to 350.00 MHz
...
(**) RADEON(0): *Mode "1400x1050": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1400x1050"  108.00  1400 34208 34320 1688  1050 1050 1053 1063

