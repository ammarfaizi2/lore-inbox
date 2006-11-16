Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031155AbWKPLKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031155AbWKPLKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 06:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031156AbWKPLKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 06:10:20 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:29873 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S1031155AbWKPLKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 06:10:19 -0500
From: Mws <mws@twisted-brains.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Thu, 16 Nov 2006 12:10:15 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Garzik <jeff@garzik.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de, Olivier Nicolas <olivn@trollprod.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <Pine.LNX.4.64.0611151210380.3349@woody.osdl.org> <200611152210.47238.mws@twisted-brains.org>
In-Reply-To: <200611152210.47238.mws@twisted-brains.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611161210.15684.mws@twisted-brains.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 22:10, Mws wrote:
> On Wednesday 15 November 2006 21:14, Linus Torvalds wrote:
> > 
> > On Wed, 15 Nov 2006, Mws wrote:
> > > 
> > > after some small discussions on alsa-user ml i recognised this
> > > thread today. 
> > > i thought my problem could also exist on this msi stuff.
> > > i disabled msi in kernel config, reboot, and, after starting x & kde
> > > i got immediately a freeze.
> > > last and maybe important last try has been to
> > > enable msi support _but_ boot kernel with cmdline pci=nomsi
> > > this finally did work out. i got a working sound environment again.
> > 
> > I expect that you have the exact same issue as Olivier: the "hang" is 
> > probably because you started using the sound device (beeping on the 
> > console is handled by the old built-in speaker, but in X a single beep 
> > tends to be due to sound device drivers), and because of sound irq 
> > misrouting you had some other device (like your harddisk) that got their 
> > irq disabled due to the "nobody cared" issue.
> > 
> > > i find it a bit abnormal that the disabling msi in kernel config behaviour
> > > is different from kernel cmdline pci=nomsi option.
> > 
> > Now, that does actually worry me. It _should_ have worked with CONFIG_MSI 
> > disabled. I wonder if some of the MSI workarounds actually broke the HDA 
> > driver subtly.
> > 
> > Anyway, it would be a good idea to test the current -git tree if you can, 
> > both with CONFIG_MSI and without (and _without_ any "pci=nomsi" kernel 
> > command line). It should hopefully work, exactly because the HDA driver 
> > now shouldn't even try to do any MSI stuff by default.
> > 
> > Knock wood.
> > 
> > 		Linus
> hi,
> 
> linus, just cloned current git, but will test it tomorrow morning.
> 
> will inform you on the results.
> 
> thanks 
> marcel

hi, 

i just tried the git that i cloned yesterday, when you asked me to, linus.

i don't get any freezes and sound is fine.
no cmdline option pci=nomsi and msi enabled in .config

thanks for your help.

best regards
marcel
