Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311943AbSCOG5C>; Fri, 15 Mar 2002 01:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311945AbSCOG4w>; Fri, 15 Mar 2002 01:56:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9483 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311943AbSCOG4o>; Fri, 15 Mar 2002 01:56:44 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Re: futex and timeouts
Date: 14 Mar 2002 22:56:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6s5u9$9o0$1@cesium.transmeta.com>
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <E16lkRS-0001HN-00@wagner.rustcorp.com.au> <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk>
By author:    Joel Becker <jlbec@evilplan.org>
In newsgroup: linux.dev.kernel
>
> On Fri, Mar 15, 2002 at 04:39:50PM +1100, Rusty Russell wrote:
> > Yep, sorry, my mistake.  I suggest make it a relative "struct timespec
> > *" (more futureproof that timeval).  It would make sense to split the
> > interface into futex_down and futex_up syuscalls, since futex_up
> > doesn't need a timeout arg, but I haven't for the moment.
> 
> 	Why waste a syscall?  The user is going to be using a library
> wrapper.  They don't have to know that futex_up() calls sys_futex(futex,
> FUTEX_UP, NULL);
> 

Syscalls are (by and large) cheap.  Extra dispatches, however, hurt.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
