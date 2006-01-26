Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWAZQat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWAZQat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWAZQar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:30:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53888 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964776AbWAZQao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:30:44 -0500
Date: Thu, 26 Jan 2006 11:30:43 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
 include/asm-*/bitops.h
In-reply-to: <20060126161849.GA13632@colo.lackof.org>
X-X-Sender: nico@localhost.localdomain
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Akinobu Mita <mita@miraclelinux.com>, lkml <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Message-id: <Pine.LNX.4.64.0601261128280.16649@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060125112625.GA18584@miraclelinux.com>
 <20060125113206.GD18584@miraclelinux.com>
 <20060125200250.GA26443@flint.arm.linux.org.uk>
 <20060126000618.GA5592@twiddle.net>
 <20060126085540.GA15377@flint.arm.linux.org.uk>
 <20060126161849.GA13632@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Grant Grundler wrote:

> On Thu, Jan 26, 2006 at 08:55:41AM +0000, Russell King wrote:
> > Unfortunately that's not correct.  You do not appear to have checked
> > the compiler output like I did - this code does _not_ generate
> > constant shifts.
> 
> Russell,
> By "written stupidly", I thought Richard meant they could have
> used constants instead of "s".  e.g.:
> 	if (word << 16 == 0) { b += 16; word >>= 16); }
> 	if (word << 24 == 0) { b +=  8; word >>=  8); }
> 	if (word << 28 == 0) { b +=  4; word >>=  4); }
> 
> But I prefer what Edgar Toernig suggested.

It is just as bad on ARM since it requires large constants that cannot 
be expressed with immediate litteral values.  The constant shift 
approach is really the best on ARM.


Nicolas
