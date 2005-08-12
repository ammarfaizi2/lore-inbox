Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVHLRLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVHLRLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVHLRLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:11:52 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:32075 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750727AbVHLRLv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:11:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C+/Gx1+huhxveUnhV1i5c2xU40Hj/fJ0QPuKB6FdzV5tHqm70gvlARlRJ2aFxeqBXG5wNc98N48JILNAKWdAxOrzT/DI0EU1nMoOixYG+ieQC5y0aTqc45FQaFue7+HeZf4tcVtVPj427KXYA/MJwRgaapLhMUddhCjYeGb9GW0=
Message-ID: <4789af9e050812101110d3642d@mail.gmail.com>
Date: Fri, 12 Aug 2005 11:11:43 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
To: daniel.mantione@freepascal.org, alex.kern@gmx.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Atyfb questions and issues
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following issue.  I am trying to get an ATI Rage XL chip
working on a MIPS-based processor, with a 2.6.11-based kernel from
linux-mips.org.  Now, I know that this was working with a 2.4.25-based
kernel previously.

I seem to get intermittent strange issues, such as the machine
freezing from time to time, but in general I get the following in my
dmesg when I load the atyfb module:

atyfb: using auxiliary register aperture
atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
atyfb(aty_valid_pll_ct): pllvclk=50 MHz, vclk=25 MHz
atyfb(aty_dsp_gt): dsp_config 0x307c0001, dsp_on_off 0x14fffff0
< Sometimes it will hang here >
atyfb: 512K RESV, 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
atyfb: Unsupported xclk source:  7.
< Followed by a number of >
atyfb: vclk out of range
< and >
atyfb: not enough video RAM
< Finally I get >
atyfb: can't set default video mode                                             
atyfb(aty_set_pll_ct): about to program:                                        
pll_ext_cntl=0x0f pll_gen_cntl=0xff pll_vclk_cntl=0xad                          
atyfb(aty_set_pll_ct): setting clock 3 for FeedBackDivider 255, ReferenceDivider
 255, PostDivider 3(0)
< Other times it will hang here >

And that's all I get.

I'm assuming that most of my issues are due to the "Unsupported xclk
source" message.  Any ideas what I can do about this, or where I can
go to learn more about how to make this thing work?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
