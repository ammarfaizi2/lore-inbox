Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbUBXM6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 07:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUBXM6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 07:58:08 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:3906 "EHLO
	mwinf0901.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262247AbUBXM6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 07:58:04 -0500
Date: Tue, 24 Feb 2004 13:57:58 +0100
From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org, matthieu.castet@ensimag.imag.fr,
       tester@tester.ca, alban.crequy@apinc.org
Subject: Re: Linux 2.6.3 still doesn't boot on UltraSparc I
Message-ID: <20040224125758.GA2015@blop.info>
References: <20040210163232.GA2107@blop.info> <20040223133213.GA24179@blop.info> <20040223132502.GB4407@phunnypharm.org> <20040223150610.GA24673@blop.info> <20040223154549.GF4407@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223154549.GF4407@phunnypharm.org>
Organisation: Lacking
X-PGP: http://www.lucas-nussbaum.net/pubkey.txt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 10:45:49AM -0500, Ben Collins <bcollins@debian.org> wrote:
> On Mon, Feb 23, 2004 at 04:06:10PM +0100, Lucas Nussbaum wrote:
> > On Mon, Feb 23, 2004 at 08:25:02AM -0500, Ben Collins <bcollins@debian.org> wrote:
> > > So backing down to silo < 1.4.0 works with the new head.S on UltraSPARC
> > > I? I don't think the problem itself is in head.S. Changing that would
> > > force silo 1.4.x to not keep the kernel in high memory (would copy it
> > > back down to 0x4000 where the old silo would have put it). I am guessing
> > > the problem is elsewhere.
> > > 
> > > Try this, keep the new head.S and newer SILO, and edit head.S so that
> > > "HdrS version" is 0x202 instead of 0x300. See if that boots for you
> > > (would confirm my suspicion).
> > 
> > It boots correctly this way. What can we do to help now ?
> 
> Can you enable CONFIG_DEBUG_BOOTMEM and boot with "linux -p"?

Here is the output :

boot: linux -p
Allocated 8 Megs of memory at 0x4000000 for kernel
Kernel doesn't support loading to high memory, relocating done.
Loaded kernel version 2.6.3

PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
Linux version 2.6.3 (root@ensilinx8) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #4 SMP [...]
ARCH: SUN4U
PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
[...]
Looping, had to stop it using Break+A.

The same kernel boots without -p.

Lucas
