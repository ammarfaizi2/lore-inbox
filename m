Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVFUWko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVFUWko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVFUWi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:38:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4291 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261969AbVFUWGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:06:34 -0400
Date: Wed, 22 Jun 2005 00:06:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050621220619.GC2815@elf.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >     This is useful, but there are, AFAIK, two issues:
> > > > 
> > > >     - We're still deadlocked over some permission-checking hacks in there
> > > 
> > > Oh, god.  Let me try to explain this again:
> > > 
> > >   - This is a security issue with unprivileged mounts
> > 
> > Pretty please, just merge it without unpriviledged mounts. I see
> > they are usefull, but they are too strange for now.
> 
> An emotional argument again.  What's "strange" about it?

Not so emotional argument...

System where users can mount their own filesystems should not be
called "Unix" any more. It introduces new mechanism, similar to
ptrace. It restricts root in ways not seen before. How is
updatedb/locate supposed to work on system with this? How is it going
to interact with backup tools? 

Add this to your A): "by tricking some interpretter to think script is
setuid".

> You have a choice of: 1) believe me that the current solution is
> fine

>  2) get down and try to understand the damn thing, and then come up
>     with technical arguments for/against it

Argument is "it is **** ugly".

Your fuse.txt explains why it is not security hole. It does not
explain why your interface is the best possible, and what alternative
ways of "not security hole" exist.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
