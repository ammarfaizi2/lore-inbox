Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266818AbUBQXNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUBQXNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:13:50 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:21995 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S266818AbUBQXNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:13:46 -0500
Date: Tue, 17 Feb 2004 16:13:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][6/6] A different KGDB stub
Message-ID: <20040217231344.GK16881@smtp.west.cox.net>
References: <20040217220456.GG16881@smtp.west.cox.net> <20040217223040.GA1560@elf.ucw.cz> <20040217223817.GJ16881@smtp.west.cox.net> <20040217230855.GB1560@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217230855.GB1560@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 12:08:55AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > The following is the x86_64-specific bits to this KGDB stub (Pavel, can
> > > > you give this a try please?  Thanks).
> > > 
> > > I can only see [0/6],[1/6] and [6/6] on l-k. Could you perhaps mail me
> > > complete diff against 2.6.2 to try? [Or against some other version I
> > > can get from kernel.org...)
> > 
> > I'll blame the slow mailserver and hope they all get through
> > eventually.
> 
> Yes, now only #2 is missing :-))).
> 
> > The following is the patch before I split it up.  Against 2.6.3-rc4 +
> > bk-netdev from 2.6.3-rc3-mm1 (otherwise kgdboe won't work at all):
> 
> I'll try without kgdboe, first.
> 
> I'm getting some compile errors, stay tuned.

I'm not surprised, sadly.

> Meanwhile: [and taking this public]
> 
> arch/x86_64/kernel/x86_64-stub.c: this is really horrible name for a
> file. Can we have arch/x86_64/kernel/kgdb.c? or kgdb-stub.c at worst..
> 
> also kernel/kgdb.c sounds better than kernel/kgdbstub.c.

Don't look at me for naming, when in doubt I call stuff 'simple' (see
arch/ppc/boot/simple, or CONFIG_PPC_SIMPLE_SERIAL, and I'm sure I'll do
it again).  If people like kernel/kgdb.c (and arch/$(ARCH)/kernel/kgdb.c
or kgdb-stub.c) that's fine with me, so long as they're all consistent.

-- 
Tom Rini
http://gate.crashing.org/~trini/
