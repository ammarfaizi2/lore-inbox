Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbTBTAZi>; Wed, 19 Feb 2003 19:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTBTAZh>; Wed, 19 Feb 2003 19:25:37 -0500
Received: from dp.samba.org ([66.70.73.150]:62374 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262808AbTBTAZf>;
	Wed, 19 Feb 2003 19:25:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module changes 
In-reply-to: Your message of "Wed, 19 Feb 2003 13:52:55 BST."
             <15955.32295.830237.912@gargle.gargle.HOWL> 
Date: Thu, 20 Feb 2003 11:15:25 +1100
Message-Id: <20030220003539.E12F92C311@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15955.32295.830237.912@gargle.gargle.HOWL> you write:
> Rusty Russell writes:
>  > The problem is that then you have to have to know whether this is a
>  > per-cpu thing created in a module, or not, when you use it 8(
> 
> Ah yes. I totally missed that. (Shakes head in disbelief.)

<shrug> It's an easy thing to miss.

>  > I agree with you (and John) about disliking the limitation, but is it
>  > worse than the current no per-cpu stuff in modules at all?
> 
> In my case (perfctr driver) it means not being able to use per-cpu
> stuff at all since I need to be able to build it modular. Or I have
> to hide per_cpu() behind private macros that fall back to an [NR_CPUS]
> implementation in the modular case. I can live with that.

Well, there's kmalloc_percpu() there already.  But perfctr certainly
won't hit the "more per-cpu data than the core kernel" case, from my
brief reading of the code.  If something does, then the core kernel
minimum can be increased (which is a little hacky, but hey).

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
