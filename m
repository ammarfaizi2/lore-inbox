Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTHZSDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTHZSDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:03:48 -0400
Received: from shell.unixbox.com ([154.6.115.65]:29960 "EHLO shell.unixbox.com")
	by vger.kernel.org with ESMTP id S262885AbTHZSD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:03:29 -0400
Date: Tue, 26 Aug 2003 11:02:56 -0700 (PDT)
From: Ani Joshi <ajoshi@unixbox.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Radeon FB in 2.6.0-test4 fails for me
In-Reply-To: <16202.57600.498532.587264@wombat.chubb.wattle.id.au>
Message-ID: <Pine.BSF.4.50.0308261102240.15539-200000@shell.unixbox.com>
References: <16202.57600.498532.587264@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2035391533-1061920976=:15539"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-2035391533-1061920976=:15539
Content-Type: TEXT/PLAIN; charset=US-ASCII


try the attatched patch (its against test4).


ani

On Tue, 26 Aug 2003, Peter Chubb wrote:

>
> Hi,
> 	On a Clevo laptop with a Radeon Mobility M7 LW (AGP), enabling
> 	the Radeon frame buffer results in an unusable LCD display (as
> 	if the horizontal and/or vertical sync were incorrect -- lots
> 	of skewed diagonal lines)
>
> The kernel log shows this:
>
>  radeonfb_pci_register BEGIN
>  radeonfb: ref_clk=2700, ref_div=12, xclk=16600 from BIOS
>  radeonfb: probed DDR SGRAM 65536k videoram
>  radeon_get_moninfo: bios 4 scratch = 1000004
>  radeonfb: panel ID string: Samsung LTN150P1-L02
>  radeonfb: detected DFP panel size from BIOS
>  radeonfb: probed DDR SGRAM 65536k videoram
>  radeon_get_moninfo: bios 4 scratch = 1000004
>  radeonfb: panel ID string: Samsung LTN150P1-L02
>  radeonfb: detected DFP panel size from BIOS: 1400x1050
>  radeonfb: ATI Radeon M7 LW DDR SGRAM 64 MB
>  radeonfb: DVI port LCD monitor connected
>  radeonfb: CRT port no monitor connected
>  radeonfb_pci_register END
>  hStart = 1440, hEnd = 1552, hTotal = 1688
>  vStart = 1050, vEnd = 1053, vTotal = 1063
>  h_total_disp = 0xae00d2^I   hsync_strt_wid = 0x8e059a
>  v_total_disp = 0x4190426^I   vsync_strt_wid = 0x830419
>  post div = 0x2
>  fb_div = 0x60
>  ppll_div_3 = 0x10060
>  ron = 1792, roff = 22036
>  vclk_freq = 10800, per = 787
>  Console: switching to colour frame buffer device 175x65
>
>
> With FBDEV disabled in X, I see this in Xfree86.0.log:
> (WW) RADEON(0): LCD: Using default hsync range of 28.00-33.00kHz
> (WW) RADEON(0): LCD: using default vrefresh range of 43.00-72.00Hz
> (II) RADEON(0): Clock range:  12.00 to 350.00 MHz
> ...
> (**) RADEON(0): *Mode "1400x1050": 108.0 MHz (scaled from 0.0 MHz), 64.0 kHz, 60.2 Hz
> (II) RADEON(0): Modeline "1400x1050"  108.00  1400 34208 34320 1688  1050 1050 1053 1063
>
--0-2035391533-1061920976=:15539
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="radeonfb-pitchfix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.BSF.4.50.0308261102560.15539@shell.unixbox.com>
Content-Description: 
Content-Disposition: attachment; filename="radeonfb-pitchfix.diff"

ZGlmZiAtdU5yIGxpbnV4LTIuNi4wLXRlc3Q0Lm9yaWcvZHJpdmVycy92aWRl
by9yYWRlb25mYi5jIGxpbnV4LTIuNi4wLXRlc3Q0L2RyaXZlcnMvdmlkZW8v
cmFkZW9uZmIuYw0KLS0tIGxpbnV4LTIuNi4wLXRlc3Q0Lm9yaWcvZHJpdmVy
cy92aWRlby9yYWRlb25mYi5jCTIwMDMtMDgtMjIgMTc6MDE6MzMuMDAwMDAw
MDAwIC0wNzAwDQorKysgbGludXgtMi42LjAtdGVzdDQvZHJpdmVycy92aWRl
by9yYWRlb25mYi5jCTIwMDMtMDgtMjYgMTA6NDg6MDMuMDAwMDAwMDAwIC0w
NzAwDQpAQCAtMjA5MCw3ICsyMDkwLDcgQEANCiAJDQogCX0NCiAJLyogVXBk
YXRlIGZpeCAqLw0KLSAgICAgICAgaW5mby0+Zml4LmxpbmVfbGVuZ3RoID0g
cmluZm8tPnBpdGNoKjY0Ow0KKyAgICAgICAgaW5mby0+Zml4LmxpbmVfbGVu
Z3RoID0gbW9kZS0+eHJlc192aXJ0dWFsKihtb2RlLT5iaXRzX3Blcl9waXhl
bC84KTsNCiAgICAgICAgIGluZm8tPmZpeC52aXN1YWwgPSByaW5mby0+ZGVw
dGggPT0gOCA/IEZCX1ZJU1VBTF9QU0VVRE9DT0xPUiA6IEZCX1ZJU1VBTF9E
SVJFQ1RDT0xPUjsNCiANCiAjaWZkZWYgQ09ORklHX0JPT1RYX1RFWFQNCg==
--0-2035391533-1061920976=:15539--
