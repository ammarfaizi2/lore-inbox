Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTEHUEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTEHUEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:04:43 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:61109 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262023AbTEHUEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:04:42 -0400
Date: Thu, 8 May 2003 15:47:18 -0400
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508194718.GA679@phunnypharm.org>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net> <20030508151643.GO679@phunnypharm.org> <20030508193430.GC933@elf.ucw.cz> <20030508192730.GX679@phunnypharm.org> <20030508200630.GC2308@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508200630.GC2308@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 10:06:30PM +0200, Pavel Machek wrote:
> > On Thu, May 08, 2003 at 09:34:30PM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > This would also solve the current problem where a module that is
> > > > compiled with compat ioctl's using register_ioctl32_conversion() is not
> > > > usable on a kernel compiled without CONFIG_COMPAT, even though it very
> > > > well should be.
> > > 
> > > CONFIG_COMPAT is pretty much constant depending only on
> > > architecture. I see no point in complicating this.
> > 
> > I don't think so. Sparc64 and ia64 I know allow you to disable 32bit
> > compatibility. I'd be surprised if the other 32/64 architectures
> didn't.
> 
> 
> Really? I thought sparc64 has no real 64-bit userland?
> 
> Okay, it might make sense on x86-64, but I do not think savings are
> worth the trouble.

I never said it was worth just that effort. What I said was is that the
smarter change of using a compat_ioctl in the fops has the cool
side affect of allowing that to happen. Not that I ever thought it was
worth making huge changes to the infrastructure.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
