Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUATL2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265364AbUATL2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:28:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:37076 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263526AbUATL1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:27:48 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20040120100215.GA183@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz>
	 <1074555531.10595.89.camel@gaston> <20040120000435.GB837@elf.ucw.cz>
	 <1074558590.11809.98.camel@gaston>  <20040120100215.GA183@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074597913.737.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 22:25:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not passing device information, but devices *do* have internal
> state. I quiesce them before booting new kernel, but there's probably
> more than one way to quiesce devices...

Not that many. You don't quite know in what state they are when
the BIOS calls you neither in most cases :) Nor when waking up
from BIOS-managed state.... It's usually safe if they just don't
bust master and are idle.

> No, I really do not want to make things more complicated in 2.6. And
> you should not want to complicate it, too.

I will not impose that limitation on a ppc implementation. I don't
even want to load the resume image from the boot kernel, it's much more
easier to load it from the bootloader for me anyway. And the copy routine
is just a tricky bit of asm, not even _that_ tricky I'd say (well, I don't
do x86 asm, but I've certainly had to deal with more tricky stuffs on
ppc so far).

Ben.


