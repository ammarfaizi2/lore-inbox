Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265941AbUFOUri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUFOUri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUFOUrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:47:37 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:40024 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265941AbUFOUqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:46:45 -0400
Date: Tue, 15 Jun 2004 22:55:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615205557.GK2310@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615204616.E7666@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 08:46:16PM +0100, Russell King wrote:
> On Tue, Jun 15, 2004 at 09:14:18PM +0200, Sam Ravnborg wrote:
> > On Tue, Jun 15, 2004 at 07:09:51PM +0100, Russell King wrote:
> > > > 
> > > > Compared to the original behaviour where the all: target picked the default
> > > > target for a given architecture, this patch adds the following:
> > > 
> > > This isn't the case on ARM.  I've always told people 'make zImage'
> > > or 'make Image'.  I've never told people to use just 'make' on its
> > > own - in fact, I've never used 'make' on its own with the kernel.
> > 
> > Why not?
> 
> It's something we've never done - we've always traditionally told people
> to use 'make zImage' or whatever, because then they know what they're
> getting.
> 
> See: http://www.arm.linux.org.uk/docs/kerncomp.shtml
> 
> This works for no matter what kernel version you're building, whether
> its pre or post new kbuild.

Looks good. And for 2.6 no need for two steps "make zImage" and "make modules".
'make' alone will do the job and make sure zImage and modules are consistent.


> 
> > Not discussing different platforms, only discussing kernel targets.
> > For arm I see the following:
> > zImage, Image bootpImage uImage
> > And some test targets: zImg, Img, bp, i, zi
> 
> For ARM, there are: zImage and Image.  bootpImage is an add-on extra
> which requires extra parameters to be passed in order to use - and
> is our fix for the day that NFS requires external programs (though
> it seems to have been superseded by initramfs now, so will probably
> go away soon.)
And here is my point. How to you put this info in less than one line?
So I just see proff that we need to be able to give a bit more info
about the possible targets.
"which requires extra parameters...." is also a sign that more 
info would be nice.
Now I have to read and understand a Makefile to find the info.

> 
> That leaves uImage which I've discussed already in a previous mail,
> and various other targets which I've historically said I won't merge
> (as I detailed in a previous mail - srec, gzipped vmlinux, gzipped
> Image, etc.)
For arm it looks simple, but for ppc the commandline to mkuboot.sh
varies depending on configuration.
Better do this in the kernel.

	Sam
