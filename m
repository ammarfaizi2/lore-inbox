Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130525AbQKCVEd>; Fri, 3 Nov 2000 16:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131856AbQKCVEY>; Fri, 3 Nov 2000 16:04:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22279 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130525AbQKCVEM>; Fri, 3 Nov 2000 16:04:12 -0500
Date: Fri, 3 Nov 2000 17:06:04 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails,
 machine hangs)
In-Reply-To: <20001103162409.S7204@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.21.0011031530020.25024-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Nov 2000, Ingo Oeser wrote:

> On Wed, Nov 01, 2000 at 10:03:27PM +0100, Yann Dirson wrote:
> > On Wed, Nov 01, 2000 at 02:59:01PM -0200, Rik van Riel wrote:
> > > it appears there has been amazingly little research on this
> > > subject and it's completely unknown which approach will work
> > > "best" ... or even, what kind of behaviour is considered to
> > > be best by the users...
> > 
> > Sounds to me like a good point to favour a config-time selection of
> > OOM killers.
> 
> Better yet: Apply my OOM-Killer-API-Patch[1] and build your own
> OOM-Killer!
> 
> Just lock your module into memory, supply an function to
> install_oom_killer(), save the old one (you get it as return if
> installing it went ok) and be happy.
> 
> And now have fun bringing your machine into OOM situations.
> 
> Want to change it back? No problem. Just get signaled somehow[2],
> reinstall the old one, unlock your module and wait to be cleaned
> up.
> 
> I never tried it above Riks 2.2.x-OOM-Killer-Patch, but it should
> work on top of it, because oom_kill.c isn't all that different.

Ingo,

Maybe you could change Rik's oom killer to be a "module" of your OOM
killer API?

With this in place, its easier for people to compare Rik's OOM killer
with other possible new algorithms. 




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
