Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUIED6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUIED6W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 23:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUIED6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 23:58:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:9143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266183AbUIED6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 23:58:19 -0400
Date: Sat, 4 Sep 2004 20:57:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
In-Reply-To: <20040904204850.48b7cfbd.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
References: <m3zn4bidlx.fsf@averell.firstfloor.org> <20040831183655.58d784a3.pj@sgi.com>
 <20040904133701.GE33964@muc.de> <20040904171417.67649169.pj@sgi.com>
 <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org> <20040904180548.2dcdd488.pj@sgi.com>
 <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Sep 2004, Paul Jackson wrote:
> 
> > Well, historically we _have_ required sizes to match.
> 
> I'm not sure what history you're looking at here, Linus.

I have my personal drugged-up history.

Take a toke, man.

IOW: You're obviously right.

> > I don't know how to sanely expose the damn things
> 
> How about:
> 
> 	$ cd /proc/sys/kernel
> 	$ head sizeof*
> 	==> sizeof_cpumask <==
> 	64
> 
> 	==> sizeof_nodemask <==
> 	32

Well, that's so much slower and not any more obvious than just doing the 
iterative few system calls that I don't really see the point other than 
from a scripting standpoint, but on the other hand I can't see how you'd 
use sched_setaffinity() and friends from within a script anyway, so ;)

(yes, there's perl syscalls, but then the standard "find the size" also 
works fine ;)

		Linus
