Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317495AbSG2QIQ>; Mon, 29 Jul 2002 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSG2QIQ>; Mon, 29 Jul 2002 12:08:16 -0400
Received: from [195.223.140.120] ([195.223.140.120]:23624 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317495AbSG2QIQ>; Mon, 29 Jul 2002 12:08:16 -0400
Date: Mon, 29 Jul 2002 18:11:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, davej@suse.de,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] Read-Copy Update 2.5.28 [resent]
Message-ID: <20020729161135.GT1201@dualathlon.random>
References: <20020725222146.A12780@in.ibm.com> <20020726132107.D16440@in.ibm.com> <20020729083007.GA115@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729083007.GA115@elf.ucw.cz>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 10:30:08AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Currently, it seems useful for -
> > 
> > 1. CPU hotplug (synchronize_kernel())
> > 2. ipv4 route cache lookup
> > 3. dentry cache lookup [ more results and new patch on the way ]
> > 4. Potential uses in XFS (Christoph ?)
> 
> Can it be used to make module unloading less painfull?

yes of course, we just do this in 2.4 too. It doesn't cover all the
possible cases though, but it gives additional guarantees that you can
rely on and that's enough for most cases.

Andrea
