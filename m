Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262362AbREUUlg>; Mon, 21 May 2001 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbREUUlQ>; Mon, 21 May 2001 16:41:16 -0400
Received: from alpo.casc.com ([152.148.10.6]:19904 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S262362AbREUUlE>;
	Mon, 21 May 2001 16:41:04 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15113.31946.548249.53012@gargle.gargle.HOWL>
Date: Mon, 21 May 2001 16:38:34 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
In-Reply-To: <25499.990399116@redhat.com>
In-Reply-To: <20010520165952.A9622@devserv.devel.redhat.com>
	<20010518113726.A29617@devserv.devel.redhat.com>
	<20010518114922.C14309@thyrsus.com>
	<8485.990357599@redhat.com>
	<20010520111856.C3431@thyrsus.com>
	<15823.990372866@redhat.com>
	<20010520114411.A3600@thyrsus.com>
	<16267.990374170@redhat.com>
	<20010520131457.A3769@thyrsus.com>
	<18686.990380851@redhat.com>
	<20010520164700.H4488@thyrsus.com>
	<25499.990399116@redhat.com>
X-Mailer: VM 6.90 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David> Actually, the current system has both types. As well as the
David> "hard" dependencies, we also have stuff like
David> CONFIG_PARTITION_ADVANCED, CONFIG_CPU_ADVANCED,
David> CONFIG_FBCON_ADVANCED, CONFIG_MTD_DOCPROBE_ADVANCED,
David> etc. CONFIG_EXPERIMENTAL serves a very similar purpose, too.

David> These things have already been set up in the way that
David> developers prefer it.

     *some* developers prefer it.  Not all. 

David> CML2 allows us to be more flexible than we were before, and
David> that can be a good thing when used in moderation. But please,
David> for the sake of the sanity of all concerned, do things one at a
David> time. Provide for merging into 2.5 a set of rules which
David> reproduce the existing CML1 behaviour in this respect.

Can you define what you mean here?  It's not really clear to me, and I
suspect others.  

David> Eric, if you want to make further changes later to introduce
David> new 'modes' for kernel configuration, that's an entirely
David> separate issue. Please don't confuse the issue by trying to do
David> it at the same time as introducing CML2.

I don't think he is introducing new modes, he's just trying to make
sure that you can't create a .config which is broken.  Part of my
complaint early on was that it would just barf on a config it thought
wasn't legall, and just drop me to the 'vi' level.  I don't think this
is acceptable because you (CML2 or CMLxxxx) should be able to prompt
the user for a suggested fix.  

David> CONFIG_AUNT_TILLIE does not require CML2.

Correct.

David> CML2 does not require CONFIG_AUNT_TILLIE.

Correct.  And never has offered it either!

David> Let's not talk about CONFIG_AUNT_TILLIE any more, or change the
David> existing behaviour of config options to make that the default,
David> until we've settled the discussion about CML2.

I think it comes down to people who just want one or more of:

- the existing interface of vi .config; make oldconfig

- fear that CML2 won't let them make crazy configurations, such as an
  8-way SMP box with ISA.  Can't see how CML2 would restrict this
  choice myself.

- Don't want to install python 2.x for a kernel upgrade.

- fear that some configuration corner case will be handled wrong for a
  strange (read not common) system config.  


All that CML2 does is enforce dependencies in the configuration
language.  You can't make a .config which conflicts.  Admittedly
there's nothing stopping you from hacking it with vi after the fact,
but why?

If you run into a case where you have a config which would work, but
CML2 doesn't let you, why don't you fix the grammar instead of saying
CML2 is wrong?  Let's not confuse these two issues as well.

John
