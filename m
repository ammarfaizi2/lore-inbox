Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSL3Ear>; Sun, 29 Dec 2002 23:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSL3Ear>; Sun, 29 Dec 2002 23:30:47 -0500
Received: from web13206.mail.yahoo.com ([216.136.174.191]:21351 "HELO
	web13206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266676AbSL3Eaq>; Sun, 29 Dec 2002 23:30:46 -0500
Message-ID: <20021230043908.77703.qmail@web13206.mail.yahoo.com>
Date: Sun, 29 Dec 2002 20:39:08 -0800 (PST)
From: Anomalous Force <anomalous_force@yahoo.com>
Subject: Re: holy grail 
To: david.lang@digitalinsight.com, jdike@karaya.com
Cc: wa@almesberger.net, alan@lxorguk.ukuu.org.uk, riel@conectiva.com.br,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0212291948060.14400-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Lang <david.lang@digitalinsight.com> wrote:
> 
> I think people are at the point of working on this becouse it
> sounds like
> a worthwhile feature, not becouse it's actually anything that would
> be
> used.

UML sounds like a worthwhile feature, turns out its actually pretty
useful too. kexec() is supported in its current incarnation. why
not simply extend it the one step further?

> 
> what possible application needs to be able to do a seamless kernel
> upgrade
> that wouldn't be useing a network?

"programs will never use more than 640K of memory." - bill gates

lets talk clusters... the teragrid system being built out of 2024
redhat 7.2 installs (ncsa alone, not counting the 3 other cluster
sites). imagine a simple system on the network to push a copy of the
new kernel and then telling each node to hot-swap. 0 downtime.
__super__ easy to maintain. how easy would that become??? how about
this... an nfs mount point in the grid for /boot such that each node
then gets the kernel from a central point and hot swaps when a flag
is set, or a change is detected in the /boot directory. no push even
needed then. the cost savings from that alone would be worth the
effort to them.

> 
> if it's a batch processing task, it can checkpoint itself and
> restart
> after a reboot.
> 

2024 nodes rebooting, how much time needed while the system is in a
degraded state?

> if it's a controller of specialized equipment then you either can
> have the
> process checkpoint itself, or you can't afford to pause long enough
> to do
> the kernel swap (i.e. the device keeps operating regardless and so
> may
> generate ssignals to the program during the time when you are
> swapping
> kernels)
> 

hence a queue to catch pending irqs while the system swaps over.


=====
Main Entry: anom·a·lous 
1 : inconsistent with or deviating from what is usual, normal, or expected: IRREGULAR, UNUSUAL
2 (a) : of uncertain nature or classification (b) : marked by incongruity or contradiction : PARADOXICAL
synonym see IRREGULAR

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
