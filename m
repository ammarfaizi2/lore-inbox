Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSKLRhj>; Tue, 12 Nov 2002 12:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266677AbSKLRhi>; Tue, 12 Nov 2002 12:37:38 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:41383 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266655AbSKLRg5>; Tue, 12 Nov 2002 12:36:57 -0500
Subject: Re: Users locking memory using futexes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112172423.6E0322C27F@lists.samba.org>
References: <20021112172423.6E0322C27F@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 18:06:24 +0000
Message-Id: <1037124384.8321.70.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 17:17, Rusty Russell wrote:
> > Ouch!  It looks to me like userspace can use FUTEX_FD to lock many
> > pages of memory, achieving the same as mlock() but without the
> > resource checks.
> > 
> > Denial of service attack?
> 
> See "pipe".

Thats not an excuse. If the futex stuff allows arbitary memory locking
and it isnt properly accounted then its a bug, with the added problem
that its easier to have nasty accidents with than pipes.

We have a per user object nowdays so accounting per user locked memory
looks rather doable both for mlock, pipe, af_unix socket and for other
things

