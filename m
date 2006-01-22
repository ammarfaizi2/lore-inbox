Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWAVSUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWAVSUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWAVSUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:20:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10256 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751306AbWAVSUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:20:34 -0500
Date: Sun, 22 Jan 2006 19:20:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule SHAPER for removal
Message-ID: <20060122182034.GG10003@stusta.de>
References: <20060119021150.GC19398@stusta.de> <20060119215722.GO16285@kvack.org> <20060121004848.GM31803@stusta.de> <20060122174707.GC1008@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122174707.GC1008@kvack.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 12:47:07PM -0500, Benjamin LaHaise wrote:
> On Sat, Jan 21, 2006 at 01:48:48AM +0100, Adrian Bunk wrote:
> > Do we really have to wait the three years between stable Debian releases 
> > for removing an obsolete driver that has always been marked as 
> > EXPERIMENTAL?
> > 
> > Please be serious.
> 
> I am completely serious.  The traditional cycle of obsolete code that works 
> and is not causing a maintenence burden is 2 major releases -- one release 
> during which the obsolete feature spews warnings on use, and another 
> development cycle until it is actually removed.  That's at least 3 years, 
> which is still pretty short compared to distro cycles.
> 
> There seems to be a lot of this disease of removing code for the sake of 
> removal lately, and it's getting to the point of being really annoying.  If 
> the maintainer of the code in question isn't pushing for its removal, I see 
> no need to rush the process too much, especially when the affected users 
> aren't even likely to see the feature being marked obsolete since they don't 
> troll the source code looking for things that break setups.

The only supported combinations are distributions with the kernels they 
ship.

E.g. running Debian stable with any kernel > 2.6.8 is simply not 
supported.

The only point where users are supposed to see such changes are upgrades 
to new releases of their distribution - and this is anyways a point 
where you have to double-check whether it hadn't broken anything.

And the kernel isn't the main thing where things break during 
distribution upgrades - userspace breakages are much more common.

As an example, not so long ago an upgrade of the hdparm package on my 
Debian unstable system broke one local boot script I'm using because 
upstream removed the short form of an option.

And GNU make 3.81 will contain some backwards incompatible changes for 
being more POSIX compliant.

And many more changes I do not remember.

Distributions can document usespace-visible changes, but avoiding them 
is simply not possible.

> 		-ben

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

