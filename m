Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVBGQUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVBGQUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBGQUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:20:33 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:10884 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261176AbVBGQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:20:26 -0500
Subject: Re: [RFC] Reliable video POSTing on resume
From: Li-Ta Lo <ollie@lanl.gov>
To: Pavel Machek <pavel@ucw.cz>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Paulo Marques <pmarques@grupopie.com>,
       Adam Sulmicki <adam@cfar.umd.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050207160105.GF8040@elf.ucw.cz>
References: <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com>
	 <20050205093550.GC1158@elf.ucw.cz>
	 <1107695583.14847.167.camel@localhost.localdomain>
	 <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>
	 <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>
	 <20050207160105.GF8040@elf.ucw.cz>
Content-Type: text/plain
Organization: Los Alamos National Lab
Message-Id: <1107793204.2930.18.camel@logarithm.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Feb 2005 09:20:04 -0700
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 09:01, Pavel Machek wrote:
> Hi!
> 
> > > 3 - it's always there and can be executed at *any* time: booting,
> > > returning from suspend, etc. Also it would allow the VESA framebuffer
> > > driver to change graphics mode at any time (for instance).
> > 
> > OK, and what would force you to do the above in the kernel? If the code
> > lives in initramfs, it can be called very early, too.
> 
> It will be easier to debug in kernel than in initramfs, for
> one. Kernel code is bad enough, but initramfs running while kernel is
> not even initialized is going to be even more "fun".
> 								Pavel

One good thing about the emulator is it is very portable. There is
virtually no stdlib dependency. We can freely move it between user
and kernel space. When integrating the emulator into LinuxBIOS,
we first tried to use it as an user space program and then "port" it
into "kernel" space. The porting was done in a few days and the most
of the time was spent fixing LinuxBIOS itself than doing any "porting".
Actually, the same emulator source were used in both user and kernel
space as a kind of regression test.

Ollie


