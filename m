Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266955AbUAXPog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266957AbUAXPog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:44:36 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:65201 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266955AbUAXPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:44:34 -0500
Date: Sat, 24 Jan 2004 15:42:49 +0000
From: Dave Jones <davej@redhat.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Illegal instruction with gl
Message-ID: <20040124154249.GA2499@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
References: <20040123181512.A6632@animx.eu.org> <20040124103919.A7924@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124103919.A7924@animx.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 10:39:19AM -0500, Wakko Warner wrote:
 > Just to add to the below, I disabled acpi, highmem, smp, and preempt.  Same
 > problem.  I also tried 2.4.24 kernel, same results.
 > 
 > I modified agpgart on 2.4.24 to use generic intel init which didn't change
 > anything.
 > 
 > This is the first system with an intel E7505 I've used so I don't know if
 > it's a board problem or a kernel problem.  Or if it's with the matrox g400.
 > 
 > Here's the kernel messages for agp/drm from 2.6.1 (everything enabled that I
 > disabled):
 > agpgart: Detected an Intel E7505 Chipset.
 > agpgart: Maximum main memory to use for agp memory: 941M
 > agpgart: AGP aperture is 32M @ 0xf8000000
 > [drm] Initialized mga 3.1.0 20021029 on minor 0
 > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
 > agpgart: Device is in legacy mode, falling back to 2.x
 > agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
 > agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
 > 
 > I placed some files in:
 > http:// veg.animx.eu.org/e7505/
 > with some extra information (config, full dmesg, lspci -v)

I see no evidence that this is an agpgart problem.  When that does something
wrong, you usually end up with either a system lockup, or massive memory
corruption. Apps segfaulting would suggest to me that you have a problem with
your X GL libraries.

You may have more luck asking the folks at dri-devel@lists.sf.net about it.

		Dave



