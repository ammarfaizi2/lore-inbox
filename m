Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVJVOZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVJVOZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVJVOZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 10:25:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48860 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932235AbVJVOZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 10:25:04 -0400
Date: Sat, 22 Oct 2005 16:24:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spitz (zaurus sl-c3000) support
Message-ID: <20051022142444.GA1531@elf.ucw.cz>
References: <20051012223036.GA3610@elf.ucw.cz> <1129158864.8340.20.camel@localhost.localdomain> <20051012233917.GA2890@elf.ucw.cz> <1129192418.8238.21.camel@localhost.localdomain> <20051013224419.GF1876@elf.ucw.cz> <1129244547.8238.100.camel@localhost.localdomain> <20051018081501.GE12283@atrey.karlin.mff.cuni.cz> <1129989418.8349.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129989418.8349.16.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Oh, okay, one more question. Do you trust your battery charging code
> > > > enough to leave spitz overnight in charger? I would hate to be awaken
> > > > by angry lithium ;-).
> > > 
> > > My spitz has been left plugged in all the time with my charging code and
> > > has yet to explode. ;-) Its very similar to the c7x0 code which people
> > > have happily been using for a while in OpenZaurus c7x0 2.6. Spitz does
> > > contain a charging chip which should prevent major damage to the
> > > battery. The software just tries to help it along...
> > 
> > Charge led does not go off, but pavouk (has c7x0) told me that's
> > pretty much normal. It made me a bit nervous.
> 
> The charge LED should go off but it won't if the device isn't suspended
> as when running, the device draws enough current to keep the charger
> active.
> 
> Help on improving the charging code is of course welcome ;-)

Of course :-). Question: is there some reasonable way to get the spitz
patches, or maybe to just get all of your patches? I was doing

#!/bin/bash
# # >
#http://www.rpsys.net/openzaurus/temp/linux-openzaurus_2.6.14-rc1.bb
# #
# # Quite a long list; what is $RPSRC -- that is where are those
#patches
# # really placed?
#
#Its declared in:
#http://www.rpsys.net/openzaurus/temp/linux-openzaurus.inc

RPSRC=http://www.rpsys.net/openzaurus/patches

# You probably don't need the ipaq hx2750 or tosa patches, they're
just
# part of my tree. The top 15 patches have been merged since -rc1 came
out
# (they were in the process of being merged at the time).

for A in pxa_i2c_fixes-r0.patch pxa_ohci_platform-r1.patch
pxa_ohci_suspend-r0.patch poodle_irda-r0.patch
ide_not_removable-r0.patch sharpsl_pm-r8.patch corgi_pm-r4.patch
spitz_base_extras-r2.patch spitz_pm-r4.patch spitz_kbd_fix1-r0.patch
spitzcf-r3.patch pxa_timerfix-r0.patch pxa_remove_static-r0.patch
pxa_irda-r4.patch corgi_irda-r3.patch pxa_rtc-r1.patch
input_power-r2.patch jffs2_longfilename-r0.patch
sharpsl_bl_kick-r1.patch corgi_snd-r10.patch pxa2xx-ir-dma-r0.patch
tc6393-device-r5.patch tc6393_nand-r6.patch pcmcia_dev_ids-r2.patch
mmc_timeout-r0.patch pxa_cf_initorder_hack-r1.patch; do
#       wget $RPSRC/$A
    cat /data/l/zaurus/spitz.patches/$A | cg-patch
    pshell
done

.... but that's ather poor trick. Few patches broke the download (slow
line here), and few of them broke compilation later...

								Pavel
-- 
Thanks, Sharp!
