Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271637AbRHUKqe>; Tue, 21 Aug 2001 06:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271388AbRHUKqY>; Tue, 21 Aug 2001 06:46:24 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:37392 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S271311AbRHUKqQ>; Tue, 21 Aug 2001 06:46:16 -0400
Date: Tue, 21 Aug 2001 12:46:28 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: David Wagner <daw@mozart.cs.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <605512235.998386789@[169.254.45.213]>
Message-ID: <Pine.LNX.4.33.0108211212570.20625-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Alex Bligh - linux-kernel wrote:

> So writers of ssh, ssl etc. all go use /dev/random, which is not
> 'theoretically vulnerable to a cryptographic attack'. This means,
> in practice, that they are dysfunctional on some headless systems
> without Robert's patch. Robert's patch may make them slightly
> less 'perfect', but not as imperfect as using /dev/urandom instead.
> Using /dev/urandom has another problem: Do we expect all applications
> now to have a compile option 'Are you using this on a headless
> system in which case you might well want to use /dev/urandom
> instead of /dev/random?'. By putting a config option in the kernel,
> this can be set ONCE and only degrade behaviour to the minimal
> amount possible.

A little question: I used to believe that crypto software requires
strong random source to generate key pairs, but this requirement in
not true for session keys.  You don't usually generate a key pair on
a remote system, of course, so that's not a big issue. On low-entropy
systems (headless servers) is /dev/urandom strong enough to generate
session keys? I guess the little entropy collected by the system is
enough to feed the crypto secure PRNG for /dev/urandom, is it correct?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

