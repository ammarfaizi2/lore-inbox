Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWJQVoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWJQVoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWJQVoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:44:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWJQVog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:44:36 -0400
Date: Tue, 17 Oct 2006 14:40:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Prakash Punnoor <prakash@punnoor.de>, mingo@redhat.com,
       linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, hnguyen@de.ibm.com
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to off
Message-ID: <20061017144053.29b6b29c@freekitty>
In-Reply-To: <20061017211301.GE3502@stusta.de>
References: <200610050938.10997.prakash@punnoor.de>
	<5aa69f860610051030l7323ec2el545873570052f077@mail.gmail.com>
	<200610052309.01155.prakash@punnoor.de>
	<20061017211301.GE3502@stusta.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 23:13:01 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Oct 05, 2006 at 11:08:57PM +0200, Prakash Punnoor wrote:
> > Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A????c??:
> > > 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > > > Hi,
> > > >
> > > > subjects say it all. Without irqpoll my nic doesn't work anymore. I added
> > > > Ingo
> > > > to cc, as my IRQs look different, so it may be a prob of APIC routing or
> > > > the
> > > > like.
> > 
> > > > Can you try booting with pci=nomsi ? I have a similar problem with my
> > 
> > I used snd-hda-intel.disable_msi=1 and this actually helped! Now the nforce 
> > nic works w/o problems. So it was the audio driver causing havoc on the nic. 
> >...
> 
> Unless someone finds and fixes what causes such problems, I'd therefore 
> suggest the patch below to let MSI support to be turned off by default.
> 
> cu
> Adrian
> 

It shouldn't be that hard to write a small bit of code to force an interrupt
and catch it, that's what other drivers do to workaround the BIOS braindamage
that seems to be rampant (until M$ Vista comes out and supports MSI).
