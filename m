Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbTDNSzl (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263838AbTDNSzl (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:55:41 -0400
Received: from fmr01.intel.com ([192.55.52.18]:2550 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263835AbTDNSzg (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:55:36 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A84725A261@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
Date: Mon, 14 Apr 2003 12:07:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> On Mon, 2003-04-14 at 19:09, Grover, Andrew wrote:
> > Ben obviously PPC is ahead of the pack on this stuff 
> (congrats) but I 
> > did just want to put forward the idea that when we're all done with 
> > this stuff on all archs, we will hopefully not be regularly 
> re-POSTing 
> > the video bios.
> 
> But how ? let's make clear what we call POST first ...
> 
> If the card is powered off, it must be POSTed to be brought 
> back to life. Either we do it by running the BIOS code 
> (probably what you are talking about and should be 
> deprecated), or the driver "knows" how to restore the chip 
> from power off. I don't know if APM/ACPI provides other ways, 
> I suspect the APM BIOS will re-POST the card by itself or 
> else, things wouldn't work today. I don't know about ACPI.
> 
> What I mean here is that none of our drivers know how to bring 
> back a chip as complicated as a radeon or a nvidia up from 
> power off, this requires intimate knowledge of the chip 
> internals, the way it's wired on a given board, etc...

All I am saying is that on Windows, the driver gets no help from the
BIOS, APM, or ACPI, but yet it restores the video to full working
condition. I understand that this sounds complicated, but since there is
an implementation that already does this then I think we have to assume
it's possible. :) Perhaps we should start with older, simpler gfx hw, or
maybe POST the bios, but only as an interim solution until gfx drivers
get better in this area.

Regards -- Andy
