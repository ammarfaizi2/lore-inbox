Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268393AbTBSMm6>; Wed, 19 Feb 2003 07:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268399AbTBSMm6>; Wed, 19 Feb 2003 07:42:58 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:65201 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268393AbTBSMm5>;
	Wed, 19 Feb 2003 07:42:57 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15955.32295.830237.912@gargle.gargle.HOWL>
Date: Wed, 19 Feb 2003 13:52:55 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module changes 
In-Reply-To: <20030219033429.990F62C0CA@lists.samba.org>
References: <15954.22427.557293.353363@gargle.gargle.HOWL>
	<20030219033429.990F62C0CA@lists.samba.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
 > In message <15954.22427.557293.353363@gargle.gargle.HOWL> you write:
 > > Rusty Russell writes:
 > >  > D: This adds percpu support for modules.  A module cannot have more
 > >  > D: percpu data than the base kernel does (on my kernel 5636 bytes).
 > > 
 > > This limitation is quite horrible.
 > > 
 > > Does the implementation have to be perfect? The per_cpu API can easily
 > > be simulated using good old NR_CPUS arrays:
 > 
 > The problem is that then you have to have to know whether this is a
 > per-cpu thing created in a module, or not, when you use it 8(

Ah yes. I totally missed that. (Shakes head in disbelief.)

 > I agree with you (and John) about disliking the limitation, but is it
 > worse than the current no per-cpu stuff in modules at all?

In my case (perfctr driver) it means not being able to use per-cpu
stuff at all since I need to be able to build it modular. Or I have
to hide per_cpu() behind private macros that fall back to an [NR_CPUS]
implementation in the modular case. I can live with that.

/Mikael
