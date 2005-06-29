Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVF2XLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVF2XLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVF2XLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:11:10 -0400
Received: from colo.tr0n.com ([66.207.132.11]:1457 "EHLO tr0n.com")
	by vger.kernel.org with ESMTP id S262721AbVF2XJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:09:13 -0400
Message-ID: <42C32932.1040708@nauticom.net>
Date: Wed, 29 Jun 2005 19:05:22 -0400
From: Chet Hosey <chosey@nauticom.net>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local> <20050629135820.GJ11013@nysv.org> <20050629205636.GN16867@khan.acc.umu.se>
In-Reply-To: <20050629205636.GN16867@khan.acc.umu.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

>GNOME and KDE run on operating systems that run other kernels than
>Linux, hence they have to implement their own userland VFS anyway.
>Adding this to the Linux kernel won't help them one bit, unless
>we can magically convince Sun to add it to Solaris, all different
>BSD:s to add it to their kernels, etc.  Not going to happen.
>An effort to get GNOME and KDE to unify their VFS:s would be
>far more benificial, and would if successful probably lead to
>other desktop environments (if there are any other DE:s with their
>own VFS:s, dunno about that) following their lead.
>
>FreeDesktop is doing a lot of work to make GNOME, KDE, and other
>DE:s interoperate as much as possible.  Support their initiative
>instead of trying to get a monstrosity (albeit a very cool one,
>conceptually) into the kernel.  Sure, it could be made to work,
>but not without dropping our Unixness.  And if we do, we should
>start by looking at Plan 9 =)
>
>
>Regards: David
>  
>
The point of such ventures is that by placing features at a lower level
you get to keep the advantages of UNIX in the first place -- namely,
that many small tools can do neat things with most objects. By placing
everything in a largish userspace library instead of at a system level
(kernel, libc, etc.) you're essentially saying that, for instance, vi
would have to be rewritten in order to interact with objects presented
by the VFS. So would bash, fmt, sort, less, aspell, or anything else
that can open a file. You'd end up with a situation in which you see
objects via the VFS browser (file manager) that no longer exist when you
want to drop to a shell to use common UNIX utilities and find that the
object doesn't actually exist to the OS itself.

This sounds like Joel Spolsky's law of leaky abstractions, and the fact
that most operating systems lack a useful facility (which is why GNOME
and KDE roll their own VFS) sounds like a poor excuse for keeping useful
features out of the kernel.

I'm *not* arguing for putting anything specific into the kernel. I *am*
arguing that an inconsistent presentation in which some apps see VFS
objects and others don't makes for a less-than-ideal UI.

-- chet

