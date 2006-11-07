Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753059AbWKGUGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbWKGUGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbWKGUGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:06:55 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:31496 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1753062AbWKGUGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:06:54 -0500
Date: Tue, 7 Nov 2006 20:06:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ernst Herzberg <earny@net4u.de>
Subject: Re: 2.6.19-rc <-> ThinkPads, summary
Message-ID: <20061107200646.GD9533@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ernst Herzberg <earny@net4u.de>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <20061101030126.GE27968@stusta.de> <20061104034906.GO13381@stusta.de> <20061104140440.GB19760@flint.arm.linux.org.uk> <20061105062330.GT13381@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061105062330.GT13381@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 07:23:30AM +0100, Adrian Bunk wrote:
> On Sat, Nov 04, 2006 at 02:04:40PM +0000, Russell King wrote:
> > On Sat, Nov 04, 2006 at 04:49:07AM +0100, Adrian Bunk wrote:
> > > As far as I can see, the 2.6.19-rc ThinkPad situation is still 
> > > confusing and we don't even know how many different bugs we are 
> > > chasing...
> > 
> > Why am I copied on this?  Nothing jumps out as being in any area of my
> > interest (which today is limited to ARM architecture only.)
> 
> Ernst bisected his problem to your
> commit 1fbbac4bcb03033d325c71fc7273aa0b9c1d9a03 
> ("serial_cs: convert multi-port table to quirk table").
> 
> It might be a false positive of the bisecting, but if it turns out to 
> actually cause problems it was your commit.

No idea, sorry.

No information if a serial card was in the PCMCIA slot.  If there's
no _PCMCIA_ serial card inserted, the code in that patch will not be
run.

Also no indication if serial_cs was built into Earnst's kernel.  If
it wasn't, this commit couldn't be the cause.

NeedMoreInformation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
