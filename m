Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWEZOes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWEZOes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWEZOes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:34:48 -0400
Received: from ns2.suse.de ([195.135.220.15]:6095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750813AbWEZOer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:34:47 -0400
Subject: Re: Recent x86-64 patch causes many devices to disappear
From: Thomas Renninger <trenn@suse.de>
Reply-To: trenn@suse.de
To: Jeff Garzik <jeff@garzik.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       gregkh@suse.de, joachim deguara <joachim.deguara@amd.com>
In-Reply-To: <4476E1B3.8020605@garzik.org>
References: <4476D020.8070605@garzik.org> <200605261203.55108.ak@suse.de>
	 <4476D874.6060000@garzik.org> <200605261255.27471.ak@suse.de>
	 <4476E1B3.8020605@garzik.org>
Content-Type: text/plain
Organization: Novell/SUSE
Date: Fri, 26 May 2006 16:34:39 +0200
Message-Id: <1148654080.16187.107.camel@queen.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 07:08 -0400, Jeff Garzik wrote:
> Andi Kleen wrote:
> > On Friday 26 May 2006 12:29, Jeff Garzik wrote:
> >> Andi Kleen wrote:
> >>> The problem is that most people cannot figure out how 
> >>> to disable this in the BIOS so we needed a way to make it boot
> >>> out of the box.
> >> Agreed.
> > 
> > Do you use SCSI on your box? According to Joachim booting with 
> > segmentation on and not pci=noacpi SCSI is not seen. And that's the 
> > default setup on the machine which made it unusable.
> 
> Here, I see:
> 
> 	segmentation on + pci=noacpi == no SCSI
> and additionally
> 	segmentation on + pci=noacpi == no sata_mv
> and thus overall
> 	segmentation on + pci=noacpi == no PCI-X bus
> 
> (as the posted output on gtf.org shows)

Here are the results from Joachim (without the patch):
(from novell.bugzilla.com bug #82986):

segmentation enablee with no extra kernel params = not working
segmentation enabled with pci=noacpi = working
segmentation disabled with no extra kernel params = working
segmentation disabled with pci=noacpi = working

I'd say that only disabling when segmentation is enabled makes sense...,
however the devices should still appear.
I know there are a lot BIOS versions of this machines flying around.
Maybe everybody should check that the latest version is running, first?
I have:
BIOS Information
        Vendor: Hewlett-Packard
        Version: 786B9 v2.05
        Release Date: 01/26/2006

        Thomas

