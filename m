Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVLCVG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVLCVG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVLCVG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:06:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:26838 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750842AbVLCVGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:06:25 -0500
Date: Sat, 3 Dec 2005 13:03:15 -0800
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86 PCI domain support
Message-ID: <20051203210315.GA4822@suse.de>
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de> <4391FC0A.9040202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4391FC0A.9040202@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 03:11:54PM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> >On Fri, Dec 02, 2005 at 08:39:04PM -0500, Jeff Garzik wrote:
> >
> >>ACPI PCI support stopped short of supporting multiple PCI domains,
> >>which is something I need in order to support a current machine
> >>configuration, and something many will soon need, to support upcoming
> >>systems.
> >>
> >>This is a minimal, untested implementation.  But it should work,
> >>provided your PCI op hooks (direct, BIOS, mmconfig) support PCI domains
> >>(mmconfig).
> >
> >
> >It looks like a good start.  Thanks for doing this.
> >
> >It actually needs some more fixes - e.g. falling back to 
> >type1 if the bus is not covered in MCFG (needed for the 
> >K8 internal busses) and a workaround for buggy Asus BIOS with wrong MCFG.
> >I have that in the works.
> >
> >But your changes are needed too - or at least they are correct
> >according to the spec. I don't know of a system that actually
> >has different mmconfig apertures for different busses yet.
> >The only case that's interesting right now is that some busses
> >don't support it at all, but these don't need a seg number,
> >just a non listing in MCFG.
> >
> >Greg are you queueing this up? 
> 
> The first two patches could go in immediately, the last should probably 
> wait a bit...

Ok, I'll queue up all of them for testing in the next few -mm releases
before sending them on.

Care to add some "Signed-off-by:" lines to the patches?

thanks,

greg k-h
