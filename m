Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVBUO3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVBUO3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVBUO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:29:24 -0500
Received: from relay2.oslo.kommune.no ([171.23.1.12]:19139 "EHLO
	relay2.oslo.kommune.no") by vger.kernel.org with ESMTP
	id S261987AbVBUO10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:27:26 -0500
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
From: Kjartan Maraas <kmaraas@broadpark.no>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Lorenzo Colitti <lorenzo@colitti.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <200502182049.11088.s0348365@sms.ed.ac.uk>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <200502151742.55362.s0348365@sms.ed.ac.uk>
	 <1108563926.4986.3.camel@localhost.localdomain>
	 <200502182049.11088.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 15:25:52 +0100
Message-Id: <1108995952.4819.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 18,.02.2005 kl. 20.49 +0000, skrev Alistair John Strachan:
> On Wednesday 16 Feb 2005 14:25, Kjartan Maraas wrote:
> > tir, 15,.02.2005 kl. 17.42 +0000, skrev Alistair John Strachan:
> > > On Tuesday 15 Feb 2005 16:16, Lorenzo Colitti wrote:
> > > [snip]
> > >
> > > > Ok, here is the output from dmidecode (Debian package) and from lspci.
> > > > I don't have acpidmp and I don't know where to get it, but if you think
> > > > it's necessary I can download it if you tell me where to find it.
> > >
> > > Find below a diff of my dmidecode output versus Lorenzo's. Nothing much
> > > to call home about.
> >
> > I've attached a diff against Lorenzo's too. Only difference is that my
> > laptop is a nc4010, and looking here it's clear that this model doesn't
> > support APM at least. I also have non-working S3. It behaves just like
> > the entry in the ubuntu wiki for the nc6000 in all three cases with a
> > full system running at least. I'll try init=/bin/sh later to see if that
> > helps and if it does experiment with removing modules one by one...
> 
> Got it. Sorry for the radio silence, I've been busy for a few days.
> 
> I discovered that either the i2c_core.ko or i2c_i801.ko modules cause the hang 
> on resume! If you stop the entire i2c subsystem from being loaded by hotplug 
> (note this is the BUS driver, not the sensors driver!), then resume works 
> perfectly! Presumably there's a bug in the resuming of this module.
> 
> In other news, USB devices only work after I remove uhci_hcd and ehci_hcd and 
> reload them.
> 
> The s3_bios workaround allows video to kind of work, but I can't use anything 
> other than vga=normal (vesafb results in corruption), and the screen is no 
> longer artificially resized to fill the LCD, it's native res and centered 
> (which sure is annoying).
> 
> Kjartan, I hope you isolate the driver causing you problems, as it seems these 
> machines can be made, even if it is a bit of a headache.
> 
I tried it again now using init=/bin/sh and acpi_sleep=s3_bios and it
still gives a black screen on resume... :-/

Cheers
Kjartan


