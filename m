Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRJVOGo>; Mon, 22 Oct 2001 10:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278817AbRJVOGe>; Mon, 22 Oct 2001 10:06:34 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:36622 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S278814AbRJVOG2>; Mon, 22 Oct 2001 10:06:28 -0400
Message-Id: <200110221406.f9ME6rF00357@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Subject: Re: Poor floppy performance in kernel 2.4.10
Date: Mon, 22 Oct 2001 09:07:00 -0500
X-Mailer: KMail [version 1.3.1]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200110211136.f9LBa9B17801@hitchhiker.org.lu>
In-Reply-To: <200110211136.f9LBa9B17801@hitchhiker.org.lu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 06:36, Alain Knaff wrote:

(snip)

> Nick LeRoy wrote:
> >Perhaps there should be a pair of "mtools" added: mopen and mclose, that
> > do basically this. That way it could be a "standard" item, documented in
> > man pages, etc., not some secret that only the l-k users know. Thoughts?
>
> A nice workaround. However, personnally I'd rather have this fixed in
> the kernel, rather than having to resort to those kinds of
> workarounds. Moreover, this is potentially dangerous: it could
> actually mask a real disk change, if the user forgets the mclose.  The
> same holds for other techniques, such as sleep 3600 </dev/fd0 & Btw,
> it works now (actual disk change detected, even while the sleep runs),
> but who will guarantee it still will work in 2.6 ?
>
> Nevertheless, I'm thinking about introducing this to mtools as a
> stop-gap measure, but with ample warnings in the manpage...

Absolutely...  I *would not* advocate this as a real fix if we can, in 
general, get the interrupt to work... I would advocate a *real* fix in the 
kernel, and this using mopen/mclose for broken hardware & kernels that don't 
handle it as gracefully.

-Nick
