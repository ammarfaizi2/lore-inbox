Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWEXESO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWEXESO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWEXESO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:18:14 -0400
Received: from smtp.enter.net ([216.193.128.24]:10251 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932550AbWEXESO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:18:14 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 24 May 2006 00:17:41 +0000
User-Agent: KMail/1.8.1
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605232338.54177.dhazelton@enter.net> <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
In-Reply-To: <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605240017.45039.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 04:08, Dave Airlie wrote:
> > I am currently looking for some information or help in making the
> > Framebuffer devices use DRM and setting up a userspace system that
> > interfaces with the DRM backed framebuffer device to provide full 2D and
> > 3D acceleration of all supported features and *userspace* emulation of
> > the unsupported stuff.
>
> The first step is to provide some sort of communication between the
> DRM and fb drivers so they know the other one exists,
>
> previous attempts at this by myself have come apart in the device
> model which just plainly cannot support this without adding a couple
> of dirty hacks,
>
> The two attempts I've done, were using a vgaclass device from Alan
> Cox, and also adding a lowlevel driver for the radeon, hotplug became
> my major issue each time, discussions last year at Kernel Summit were
> had, but the results however never surfaced, I'm intending to go to KS
> this year and actually try and get Greg-KH to fix the device model for
> what we need as opposed to hacking the crap out of it.
>
> All the other designs and stuff people have mentioned have all been
> discussed to death before, people seem to love discussing graphics,
> but no-one seems to care about fixing it properly, in nice incremental
> steps that doesn't break older systems. The current systems are very
> very fixable, however there always seem to be lots of people who want
> to re-write it because it is a) ugly in their opinion b) don't care
> about backwards compat.
>

I'd never advocate just killing a functioning system. What I've been talking 
about is building a new system that sits alongside the existing one in the 
tree, depends on EXPERIMENTAL and BROKEN in the Kconfig system and takes the 
place of the traditional framebuffer system if someone decides to use it.

I say have it depend on BROKEN because that should keep the masses away from 
it while it's being heavily tested, and I say it should sit alongside the 
existing code and be *new* for exactly the reason you've pointed out. 
Modifying the existing systems to integrate the new technology would require 
either changing the driver model or a lot fo dirty hacks. Neither seems that 
good of an option to me.

DRH
