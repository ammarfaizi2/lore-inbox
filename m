Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265331AbRF0M4y>; Wed, 27 Jun 2001 08:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265329AbRF0M4n>; Wed, 27 Jun 2001 08:56:43 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:46610 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S265334AbRF0M4Z>; Wed, 27 Jun 2001 08:56:25 -0400
Date: Wed, 27 Jun 2001 14:56:23 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: David Wagner <daw@mozart.cs.berkeley.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] User chroot
In-Reply-To: <9hbage$djn$1@abraham.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.33.0106271451500.6630-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jun 2001, David Wagner wrote:

> H. Peter Anvin wrote:
> >By author:    Jorgen Cederlof <jc@lysator.liu.se>
> >> If we only allow user chroots for processes that have never been
> >> chrooted before, and if the suid/sgid bits won't have any effect under
> >> the new root, it should be perfectly safe to allow any user to chroot.
> >
> >Safe, perhaps, but also completely useless: there is no way the user
> >can set up a functional environment inside the chroot.
>
> Why is it useless?  It sounds useful to me, on first glance.  If I want
> to run a user-level network daemon I don't trust (for instance, fingerd),
> isolating it in a chroot area sounds pretty nice: If there is a buffer
> overrun in the daemon, you can get some protection [*] against the rest
> of your system being trashed.  Am I missing something obvious?

Just write a small program that chroots, drop privileges, and
execs the untrusted daemon.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

