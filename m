Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUACGMK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 01:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUACGMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 01:12:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:29637 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262746AbUACGMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 01:12:07 -0500
Date: Fri, 2 Jan 2004 22:07:48 -0800
From: Greg KH <greg@kroah.com>
To: Maciej Zenczykowski <maze@cela.pl>, Rob Landley <rob@landley.net>,
       Rob Love <rml@ximian.com>, Andries Brouwer <aebr@win.tue.nl>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040103060748.GF5306@kroah.com>
References: <200401010634.28559.rob@landley.net> <Pine.LNX.4.44.0401020051590.29346-100000@gaia.cela.pl> <20040102103104.GA28168@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102103104.GA28168@mark.mielke.cc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 05:31:04AM -0500, Mark Mielke wrote:
> On Fri, Jan 02, 2004 at 01:17:20AM +0100, Maciej Zenczykowski wrote:
> > Wouldn't this be a classical birthday problem with 50% collision chance
> > popping up in and around a few hundred devices? [20 for 8 bits, 23 for
> > 365, 302 for 16 bits, 77163 for 32 bits], and that's only in a single
> > system - with hundreds of thousands of systems even a 0.1% collision rate
> > is deadly. [0.1% collision rate at 32 bits with 2932 devices]  Even with 
> > only 300 devices per system, you'll still get a collision (at 32 bits) on 
> > more than 1 system in a hundred thousand.
> 
> I don't see this (multiple systems) as relevant. Device numbers do not need
> to be unique across systems, and they shouldn't even need to be unique across
> system reboots. Even when collisions occur, it doesn't matter, as it can just
> pick a different random number, or follow a free list, or hundreds of other
> algorithms.
> 
> Isn't this all just a question of device registration performance? 1) The
> device module needs to register the appropriate numbers efficiently.

What is "efficiently"?  No one really cares about milliseconds here,
seconds are even tollerable at least for small seconds :)

> 2) /dev needs to be populated or updated efficiently. devfs tried for
> a just in time approach, whereas udev tries for a proactive approach.

"proactive"?  udev is "reactive" in that it reacts to the number that
the kernel exports to userspace.  That's all.

Remember, devfs also uses those same, hardcoded numbers...

thanks,

greg k-h
