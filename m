Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268742AbUHLU1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268742AbUHLU1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268740AbUHLU1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:27:01 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:646 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268745AbUHLU0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:26:45 -0400
Date: Thu, 12 Aug 2004 22:26:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SCSI midlayer power management
Message-ID: <20040812202622.GD14556@elf.ucw.cz>
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net> <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston> <1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz> <1092328173.2184.15.camel@mulgrave> <20040812191120.GA14903@elf.ucw.cz> <1092339247.1755.36.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092339247.1755.36.camel@mulgrave>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ok, but what happens on next resume? If coherent mbox is at exactly
> > same place at every boot I guess it could even work, but...
> 
> Er, well this is a huge problem then.  Even if DMA were stopped, the
> registers for all these locations need to be altered to change the
> location of the DMA mboxes.  This isn't just a SCSI problem, it's a
> general device problem (most devices having mboxes programmed by
> register).  If we can't rely on the resuming kernel setting up these
> registers for us to exactly what they were in the resume image, then
> we're in a bit of trouble.
> 
> Architecturally what you are trying to do is to re POST the SCSI card. 
> Except it's the kernel's job to POST it, so the kernel init code needs
> to be re-run.  I assume that's what the pci suspend/resume calls are
> supposed to do?

Yes.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
