Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbUATLol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUATLol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:44:41 -0500
Received: from gprs214-67.eurotel.cz ([160.218.214.67]:13697 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265473AbUATLok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:44:40 -0500
Date: Tue, 20 Jan 2004 12:44:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040120114426.GA522@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz> <1074555531.10595.89.camel@gaston> <20040120000435.GB837@elf.ucw.cz> <1074558590.11809.98.camel@gaston> <20040120100215.GA183@elf.ucw.cz> <1074597913.737.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074597913.737.4.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, I really do not want to make things more complicated in 2.6. And
> > you should not want to complicate it, too.
> 
> I will not impose that limitation on a ppc implementation. I don't
> even want to load the resume image from the boot kernel, it's much more
> easier to load it from the bootloader for me anyway. And the copy
> routine

Well, if you have just one common bootloader on ppc, no problem, go
ahead at load it from bootloader. You'll not have to worry about page
tables etc. I could not do that on i386 because there are many
bootloaders in use here.

You are going to have completely different resume phase, through. [And
if someone wants suspend-to-disk on ppc, *now*, it might still be
easiest to write those two screens of assembly to port swsusp to ppc.]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
