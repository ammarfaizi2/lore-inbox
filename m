Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVKBPib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVKBPib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVKBPib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:38:31 -0500
Received: from ns1.suse.de ([195.135.220.2]:52631 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965090AbVKBPia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:38:30 -0500
Message-ID: <6079139.1130945900155.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 2 Nov 2005 16:38:20 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: Marc Perkel <marc@perkel.com>
Subject: Re: PCI-DMA: high address but no IOMMU - nForce4
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Michael Madore <michael.madore@gmail.com>, linux-kernel@vger.kernel.org,
       acurrid@nvidia.com
In-Reply-To: <56702.69.50.231.10.1130822490.squirrel@mail.ctyme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-295-smp i386 (JVM 1.3.1_13)
Organization: SuSE Linux AG
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com> <p73slum38rw.fsf@verdi.suse.de> <20051030002737.GB3423@mea-ext.zmailer.org> <56702.69.50.231.10.1130822490.squirrel@mail.ctyme.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[full quote]
 
Am Di 01.11.2005 06:21 schrieb Marc Perkel <marc@perkel.com>:

> > On Fri, Oct 28, 2005 at 12:16:51AM +0200, Andi Kleen wrote:
> >
> > I will attach my own; A brand new Amd64 dual-core thing.
> > Works fine with mem=2500M, but blows up with mem=3G or
> > without any override and full 4G complement in use.
> >
> > This board (ASUS A8N-SLI) does use NVIDIA nForce4 chipset with
> > bios-option to map (hoist) "excess memory" out from first 4G to
> > higher physical addresses so that it can be accessed by the
> > processor.
> >
> > This board has no AGP at all in it, but it does have lots
> > of PCIE, and a bit of PCI-X thrown in for "legacy cards".
> > Somehow that detail breaks things when the machine really
> > should use bounce-buffering, or something similar -- I don't
> > know if Nvidia nForce4 chipset does have IOMMU, though...
> >
> > If Nvidia did omit such essential piece of hardware from
> > a modern chipset, I do find it amazingly short-sighted...
> > (Of course they don't yield documentation of the chips to
> > public so that I can't quickly verify this detail...)
>
>
> For what it's worth I have almost the exact same hardware and got the
> same
> error. Athlon X2 4400 with the same ASUS board. Reverting to 2.6.13.2
> kernel works.
>

 
This sounds like the PCI-X BIOS misconfiguration issue that Andy C.
recently
tracked down. Andy do you agree?
 
If yes it's a BIOS problem, but we can probably work around it with a
quirk.
 
-Andi

