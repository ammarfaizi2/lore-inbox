Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTABB3U>; Wed, 1 Jan 2003 20:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTABB3U>; Wed, 1 Jan 2003 20:29:20 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:21122 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S265305AbTABB3S>; Wed, 1 Jan 2003 20:29:18 -0500
Date: Wed, 1 Jan 2003 17:37:36 -0800
To: Paul Jakma <paul@clubi.ie>
Cc: Rik van Riel <riel@conectiva.com.br>, Hell.Surfers@cwctv.net,
       linux-kernel@vger.kernel.org, rms@gnu.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Message-ID: <20030102013736.GA2708@gnuppy.monkey.org>
References: <Pine.LNX.4.50L.0301011439540.2429-100000@imladris.surriel.com> <Pine.LNX.4.44.0301012356270.8691-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301012356270.8691-100000@fogarty.jakma.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 12:31:13AM +0000, Paul Jakma wrote:
> The NVidia shim makes use of several kernel subsystems, the PCI
> device layer, the VM, the module system (well really, the kernel
> makes of use of the functions the module provides :) ), IRQ
> subsystem, the VFS, etc.. These systems are rather large bodies of
> code - without which the NVidia kernel driver could not work.

Well, no, look at the "nm" dump of the object file. It's got a lot of
proprietary code that came from what looks like commerical libraries
that they don't own. Back when they wrote the original drive, the GPL
equivalents of DRM, AGP, etc... sucked so they had to write their own
stuff just to get anything basic working.

> driver is not a derivative work, and hence it seems to me the NVidia 
> driver is technically in material breach of GPL.

Their portability layer wraps the low level calls into their own
terminology and portability API. It's fairly outside of the linux kernel
itself, internally the object file looks very Win32ish.

Obviously a GPL rewrite of this would entail a lot of replicated effort
and would also depend on things that are incomplete, non-existent and
don't have a lot direct interest from the GPL community. 3D isn't a hot
commodity in Linux, FreeBSD unlike with dedicated SGI machines (although
faded).

It's a very practical solution to do it this way.

> So I am not quite sure on what basis one could argue the NVidia 
> 
> You seem to be basing your opinion on:
> 
>  "the nvidia driver uses only the standard interfaces to hook into
>  the Linux kernel"
> 
> How are the standard interfaces not covered by the GPL? 

All I saw where kernel header files include in the sources, nothing
more. They have to support multipule architecture and OSes so keeping
this stuff outside of the driver is a good thing. The GPL-ly stuff is
publically available as source files.
 
> I know Linus' has often posted to l-k that he doesnt care about
> binary only modules as long as they stick to the exported interfaces.  
> However, are all the kernel developers agreed on this? And if so, can
> this exception be formalised and put into the COPYING file? If not, 
> then is NVidia not in breach of the kernel's licence?

I'd rather have the experts do it at NVidia, than a half completed open
source implementation that isn't terribly optimized.

Matrix multiplies, T&L, etc... communication between user and kernel
space that provides this to the OpenGL libraries are all exotic. I'm glad
that nobody has to deal with this stuff directly and that a vendor is
willing to provide support for it.

bill

