Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265498AbTIJTLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTIJTLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:11:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52425 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265498AbTIJTKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:10:47 -0400
Date: Wed, 10 Sep 2003 21:10:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910191038.GK27368@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de> <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net> <20030910170610.GH27368@fs.tum.de> <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:59:02AM -0700, Tom Rini wrote:
> > 
> > That wouldn't be needed. AFAIK there are _no_ problems if SERIO=y, the 
> > select you suggest is already implemented the other way round.
> 
> The problem is that SERIO==y means that SERIO_I8042 must be Y, as you
> ran into.  If you have SERIO only asked on EMBEDDED || !X86, and on
> similar conditions you then select SERIO_I8042, it just works.

No the problems occur when SERIO=m.

> > If SERIO is always y if !EMBEDDED || X86 my patch wouldn't be needed.
> 
> Correct.  I was suggesting that you do:
> tristate "Serial i/o support (needed for keyboard and mouse)" if
> !EMBEDDED || !X86  (or so)
> select SERIO_I8042 if X86 && !EMBEDDED
> 
> and then remove the conditions on SERIO_I8042, which puts all of the
> auto-select-this magic in one spot.

I can't see how this should work in all cases.
Could you send how you'd like to formulate this?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

