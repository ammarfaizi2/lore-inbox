Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVDLHV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVDLHV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVDLHSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:18:32 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:31169 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262041AbVDLHOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:14:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hXcfMdKwsYUFupkz+2kJV0uv8VnTS0c61cNeXvE+XDF1LZOBk/Dbg+y9TwWXb/+IYUzqPLYYUw4gwNmzH59MPVVjOFpyCJjp3d10+LQ3797BdmHXBkC7lmXy/0T20UKZ+3Cip+7CozVCS8cekbUu5fz8WNu4DbRkyRw3NTzuV5A=
Message-ID: <5edf7fc9050412001464682e4a@mail.gmail.com>
Date: Tue, 12 Apr 2005 12:44:35 +0530
From: Kedar Sovani <kedars@gmail.com>
Reply-To: Kedar Sovani <kedars@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel SCM saga.. (bk license?)
Cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <20050408041341.GA8720@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if working on git, is in anyway, in violation of the
Bitkeeper license, which states that you cannot work on any other SCM
(SCM-like?) tool for "x" amount of time after using Bitkeeper ?


Kedar. 

On Apr 8, 2005 10:12 AM, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Thu, 7 Apr 2005, Chris Wedgwood wrote:
> >
> > I'm playing with monotone right now.  Superficially it looks like it
> > has tons of gee-whiz neato stuff...  however, it's *agonizingly* slow.
> > I mean glacial.  A heavily sedated sloth with no legs is probably
> > faster.
> 
> Yes. The silly thing is, at least in my local tests it doesn't actually
> seem to be _doing_ anything while it's slow (there are no system calls
> except for a few memory allocations and de-allocations). It seems to have
> some exponential function on the number of pathnames involved etc.
> 
> I'm hoping they can fix it, though. The basic notions do not sound wrong.
> 
> In the meantime (and because monotone really _is_ that slow), here's a
> quick challenge for you, and any crazy hacker out there: if you want to
> play with something _really_ nasty (but also very _very_ fast), take a
> look at kernel.org:/pub/linux/kernel/people/torvalds/.
> 
> First one to send me the changelog tree of sparse-git (and a tool to
> commit and push/pull further changes) gets a gold star, and an honorable
> mention. I've put a hell of a lot of clues in there (*).
> 
> I've worked on it (and little else) for the last two days. Time for
> somebody else to tell me I'm crazy.
> 
>                 Linus
> 
> (*) It should be easier than it sounds. The database is designed so that
> you can do the equivalent of a nonmerging (ie pure superset) push/pull
> with just plain rsync, so replication really should be that easy (if
> somewhat bandwidth-intensive due to the whole-file format).
> 
> Never mind merging. It's not an SCM, it's a distribution and archival
> mechanism. I bet you could make a reasonable SCM on top of it, though.
> Another way of looking at it is to say that it's really a content-
> addressable filesystem, used to track directory trees.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
