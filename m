Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWDVTZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWDVTZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWDVTZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:25:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45243 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751047AbWDVTZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:25:04 -0400
Date: Sat, 22 Apr 2006 16:20:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422142043.GD5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org> <20060422141410.GA25926@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422141410.GA25926@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 04:14:10PM +0200, Sam Ravnborg wrote:
> On Sat, Apr 22, 2006 at 01:03:03PM +0100, David Woodhouse wrote:
> > On Sat, 2006-04-22 at 11:33 +0200, Adrian Bunk wrote:
> > > My thirst thought is:
> > > Is this really the best approach, or could this be done better?
> > 
> > I think it's the best way to start, although I agree with you entirely
> > about what we should strive for in the end.
> > 
> > > I'm currently more a fan of a separate kabi/ subdir with headers used by 
> > > both headers under linux/ and userspace.
> > 
> > I agree -- I'd like to see that too. But Linus doesn't like that
> > approach very much.
> Thats bacause the kabi subdir is broken by design.
> Any approach that does not take into account the existing userbase is
> broken by design and should be avoided.
> The only sensible solution is to move out the kernel internal headers
> from include/* to somewhere else.
> And then slowly but steady let include/linux and include/asm-* be the
> KABI.
>...

What exactly is the problem with creating the userspace ABI in 
include/kabi/ and letting distributions do an
  cd /usr/include && ln -s kabi/* .
?

Or with creating the userspace ABI in include/kabi/ and letting 
distributions install the subdirs of include/kabi/ directly under 
/usr/include?

These are two doable approaches with a new kabi/ that avoid needless 
breaking of userspace.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

