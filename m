Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUI0FZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUI0FZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 01:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUI0FZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 01:25:33 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:48973 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266115AbUI0FZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 01:25:23 -0400
Date: Mon, 27 Sep 2004 09:25:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: external modules documentation
Message-ID: <20040927072549.GC8613@mars.ravnborg.org>
Mail-Followup-To: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20040918112900.GA22428@lst.de> <200409232224.50234.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409232224.50234.arekm@pld-linux.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:24:50PM +0200, Arkadiusz Miskiewicz wrote:
> On Saturday 18 of September 2004 13:29, Christoph Hellwig wrote:
> > Sam,
> >
> > is there any reason your patch from June still isn't merged?
> >
> [...]
> > +Prepare the kernel for building external modules
> > +------------------------------------------------
> > +When building external modules the kernel is expected to be prepared.
> > +This includes the precense of certain binaries, the kernel configuration
> > +and the symlink to include/asm.
> > +To do this a convinient target is made:
> > +
> > + make modules_prepare
> > +
> > +For a typical distribution this would look like the follwoing:
> > +
> > + make modules_prepare O=/lib/modules/linux-<kernel version>/build
> Tthis means that one, unmodified source tree is _not_ usable for multiple 
> architectures. You can't use the same, prepared sources and for example 
> create noarch.rpm or burn on cd and then use for external modules building on 
> different architectures.

You are doing it wrong.
You need in your case one source tree, several output dirs.
So use
make ARCH=sparc CROSS_COMPILE=xxx O=~/build/sparc ...

make ARCH=ppc CROSS_COMPILE=xxx O=~/build/ppc ...

The patch below is flawed.

> 
> We are using this:
> http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-kbuild-extmod.patch?rev=1.2
> to get external modules working for multiple archs with the same sources:
> http://cvs.pld-linux.org/cgi-bin/cvsweb/SPECS/template-kernel-module.spec?rev=1.14


	Sam
