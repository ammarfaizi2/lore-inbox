Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135918AbRDTNlY>; Fri, 20 Apr 2001 09:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135919AbRDTNlP>; Fri, 20 Apr 2001 09:41:15 -0400
Received: from stanis.onastick.net ([207.96.1.49]:5124 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S135918AbRDTNlA>; Fri, 20 Apr 2001 09:41:00 -0400
Date: Fri, 20 Apr 2001 09:41:00 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: pageable kernel-segments
Message-ID: <20010420094100.B14161@sigkill.net>
In-Reply-To: <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl> <20010417120756.C11536@sigkill.net> <01041720013700.02396@idun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041720013700.02396@idun>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Oliver Neukum did have cause to say:

> > load/init/etc.  Hardware setup tends to only happen once..)
> 
> No they can't. Modules can't be finegrained enough to do this without wasting 
> more memory due to fragmentation than you'd gain.

Actually, don't they do this -already-?  I thought I saw somewhere on here
recently that there was a class of functions you could use in a module for
'one-off' activities.  I suspect that covers 90% of what could be paged
out (the remainder being mostly the unloading process, for non-hotswap
modules).  But IANAKG. (..not a kernel guru).

> Actually not that great.Support for different types of kernel code is there 
> to support __init and __initdata. You'd use a fixup scheme like the one used 
> in copy_[to|from]_user to trigger paging in. Page out could be handled by the 
> conventional mm.

I mis-typed - by 'major rewrite' I meant more an analysis and tagging
process, which would have to touch most of the kernel before it was
useful. But again, IANAKG so the existing swap code may already handle
that, at least in a way that it could be a ruleset (with override tags?)
instead of having to put a new set of tags everywhere.

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
