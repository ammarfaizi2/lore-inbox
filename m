Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTIFXKL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 19:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTIFXKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 19:10:11 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:25742 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261761AbTIFXKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 19:10:08 -0400
Date: Sun, 7 Sep 2003 00:09:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, nagendra_tomar@adaptec.com,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030906230911.GA12392@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain> <1062674382.21667.32.camel@dhcp23.swansea.linux.org.uk> <20030905212420.GD220@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905212420.GD220@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > x86 gives you coherency and store ordering (barring errata and special
> > CPU modes)
> 
> Special CPU modes? You mean some special SSE stores?

Take a look at arch/i386/kernel/cpu/centaur.c, and CONFIG_X86_OOSTORE.

You can change the memory settings to weakly ordered writes, which
means that a plain write isn't suitable for spin_unlock.  Presumably
this mode is faster (though I don't see why, if Intel, AMD et al. can
manage good memory performance without weak writes).

-- Jamie
