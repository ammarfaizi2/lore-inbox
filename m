Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265967AbUFOVHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUFOVHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUFOVHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:07:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61446 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265967AbUFOVGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:06:54 -0400
Date: Tue, 15 Jun 2004 22:06:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615220646.I7666@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk> <20040615205557.GK2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615205557.GK2310@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Jun 15, 2004 at 10:55:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 10:55:57PM +0200, Sam Ravnborg wrote:
> Looks good. And for 2.6 no need for two steps "make zImage" and "make modules".
> 'make' alone will do the job and make sure zImage and modules are consistent.

Correct, however the document is for 2.4 as well so in the interests of
not making things more complex than they have to be, it's easier to
tell people to use the old way.

> > For ARM, there are: zImage and Image.  bootpImage is an add-on extra
> > which requires extra parameters to be passed in order to use - and
> > is our fix for the day that NFS requires external programs (though
> > it seems to have been superseded by initramfs now, so will probably
> > go away soon.)
> And here is my point. How to you put this info in less than one line?
> So I just see proff that we need to be able to give a bit more info
> about the possible targets.
> "which requires extra parameters...." is also a sign that more 
> info would be nice.
> Now I have to read and understand a Makefile to find the info.

If you don't supply INITRD= then the makefile will prompt you for
it.  Ok, the message can be improved, but it does still tell you
what you did wrong.  I also pointed out that this target is legacy
and probably going away soon, so it can't be used to justify a
point.

> > That leaves uImage which I've discussed already in a previous mail,
> > and various other targets which I've historically said I won't merge
> > (as I detailed in a previous mail - srec, gzipped vmlinux, gzipped
> > Image, etc.)
> For arm it looks simple, but for ppc the commandline to mkuboot.sh
> varies depending on configuration.
> Better do this in the kernel.

You seem to have missed my point again, concentrating on uImage only.
Also, I think you got PPC and ARM confused - PPC is simple, but ARM
depends on the kernel configuration.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
