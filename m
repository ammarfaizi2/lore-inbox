Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUCRA6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUCRA6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:58:14 -0500
Received: from 220-244-186-86-qld.tpgi.com.au ([220.244.186.86]:22317 "EHLO
	dawn") by vger.kernel.org with ESMTP id S261355AbUCRA6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:58:12 -0500
Subject: Re: RadeonFB
From: Oystein Haare <lkml-account@mazdaracing.net>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0403172215240.19415-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0403172215240.19415-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1079571417.12324.8.camel@dawn>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 10:56:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes. The following is from 2.6.1:

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=22000 from BIOS
radeonfb: probed DDR SGRAM 65536k videoram
radeonfb: panel ID string: LCD                     
radeonfb: detected DFP panel size from BIOS: 1280x800
radeonfb: ATI Radeon M9 Lf DDR SGRAM 64 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END

If I understand correctly, radeonfb has gotten a rewrite some time after
2.6.1... (In the kernel configuration you have an option to choose
"Radeon (old driver)" in 2.6.4), so there might be a bug in the panel
size detection stuff in the new driver?


On Thu, 2004-03-18 at 08:17, James Simmons wrote:
> Is there any different in the dmesg output between each kernel version?
> 
> 
> On Tue, 16 Mar 2004, Oystein Haare wrote:
> 
> > Hi!
> > 
> > I'm having some problems with radeon framebuffer and the newer kernels.
> > I have a HP/Compaq nx7010 laptop computer, that is supposed to have a
> > Radeon 9200 graphics board.
> > 
> > Now.. in 2.6.1, it seems to work ok. But in 2.6.4 it just flickers alot.
> > Are there anyone else than me experiencing this problem? 
> > 
> > This is what it outputs:
> > 
> > radeonfb: Found Intel x86 BIOS ROM Image
> > radeonfb: Retreived PLL infos from BIOS
> > radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz,
> > System=220.00 MHz
> > Non-DDC laptop panel detected
> > radeonfb: Monitor 1 type LCD found
> > radeonfb: Monitor 2 type no found
> > radeonfb: panel ID string: Samsung LTN150P1-L02    
> > radeonfb: detected LVDS panel size from BIOS: 1400x1050
> > radeondb: BIOS provided dividers will be used
> > radeonfb: Assuming panel size 1400x1050
> > radeonfb: Power Management enabled for Mobility chipsets
> > radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
> > 
> > Could the flickering have something to do with the fact that the lcd
> > panel on my laptop can only do 1280x800 resolution? Or doesn't the
> > 1400x1050 have anything to do with resolution at all?
> > 
> > PS: Please CC replies to me as I am not on the list.
> > 
> > thanks 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 

