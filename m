Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUFOVPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUFOVPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUFOVPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:15:15 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:45102 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265962AbUFOVPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:15:10 -0400
Date: Tue, 15 Jun 2004 23:24:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615212424.GA4040@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk> <20040615205557.GK2310@mars.ravnborg.org> <20040615205958.GG14528@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615205958.GG14528@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 01:59:58PM -0700, Tom Rini wrote:
> On Tue, Jun 15, 2004 at 10:55:57PM +0200, Sam Ravnborg wrote:
> > On Tue, Jun 15, 2004 at 08:46:16PM +0100, Russell King wrote:
> > > That leaves uImage which I've discussed already in a previous mail,
> > > and various other targets which I've historically said I won't merge
> > > (as I detailed in a previous mail - srec, gzipped vmlinux, gzipped
> > > Image, etc.)
> > For arm it looks simple, but for ppc the commandline to mkuboot.sh
> > varies depending on configuration.
> 
> No it doesn't.  CONFIG_SHELL doesn't count :)

It was the other way around.

>From arm:

      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
                   -C none -a $(ZRELADDR) -e $(ZRELADDR) \
                   -n 'Linux-$(KERNELRELEASE)' -d $< $@

And ZRELADDR varies with configuration, ~20 different values.

	Sam
