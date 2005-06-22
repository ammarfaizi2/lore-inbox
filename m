Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVFVHqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVFVHqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVFVHqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:46:42 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:25608 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262816AbVFVGUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:20:40 -0400
To: pavel@ucw.cz
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050621220619.GC2815@elf.ucw.cz> (message from Pavel Machek on
	Wed, 22 Jun 2005 00:06:19 +0200)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz>
Message-Id: <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 08:20:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not so emotional argument...
> 
> System where users can mount their own filesystems should not be
> called "Unix" any more.

It's not.  It's "Linux".  And anyway, sysadmin may set whatever
owner/group/permissions on '/dev/fuse' to disallow or selectively
allow users to be able to mount FUSE filesystems.

> It introduces new mechanism, similar to ptrace. It restricts root in
> ways not seen before.

Not true.  Root squash in NFS has similar effect.

> How is updatedb/locate supposed to work on system with this? How is
> it going to interact with backup tools?

I assure you, that it will cause no problems whatever.  These programs
are able to gracefully handle errors.

> Add this to your A): "by tricking some interpretter to think script is
> setuid".

How would you do that?

> > You have a choice of: 1) believe me that the current solution is
> > fine
> 
> >  2) get down and try to understand the damn thing, and then come up
> >     with technical arguments for/against it
> 
> Argument is "it is **** ugly".

Yeah, that's your opinion.  Mine is that it's f****** beautiful ;).

There are plenty of ugly things in Unix/Linux that you've become so
accustomed to, that they no longer seem ugly.  Think about the sticky
bit on directories for example.  That one was breaking assumptions
left and right when it got introduced, but people came to accept it,
because it's useful.

> Your fuse.txt explains why it is not security hole. It does not
> explain why your interface is the best possible, and what alternative
> ways of "not security hole" exist.

That's because I don't see any alternative.  The "preventing user from
tracing root" and "preventing access to user's filesysem by root" must
come together.  There's doesn't seem to be any other way.

BTW, thanks for reading through fuse.txt :)

Miklos
