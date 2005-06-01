Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFAI4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFAI4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVFAI4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:56:30 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:24998 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261340AbVFAI4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:56:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] TASK_NONINTERACTIVE (was: Machine Freezes while Running Crossover Office)
Date: Wed, 1 Jun 2005 18:55:50 +1000
User-Agent: KMail/1.8
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1117291619.9665.6.camel@localhost> <courier.429C05C1.00005CC5@courier.cs.helsinki.fi> <20050601073544.GA21384@elte.hu>
In-Reply-To: <20050601073544.GA21384@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1501107.YCJ30yI5U1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506011855.54477.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1501107.YCJ30yI5U1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 1 Jun 2005 17:35, Ingo Molnar wrote:
> Pekka, could you check whether the patch below solves your Wine problem
> (without hurting interactivity otherwise)?
>
> 	Ingo
>
> ----
>
> this patch implements a task state bit (TASK_NONINTERACTIVE), which can
> be used by blocking points to mark the task's wait as "non-interactive".
> This does not mean the task will be considered a CPU-hog - the wait will
> simply not have an effect on the waiting task's priority - positive or
> negative alike. Right now only pipe_wait() will make use of it, because
> it's a common source of not-so-interactive waits (kernel compilation
> jobs, etc.).

A very elegant solution! Not only is it unlikely this will harm interactivi=
ty,=20
I suspect it will improve it in other areas.

Cheers,
Con

--nextPart1501107.YCJ30yI5U1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCnXgaZUg7+tp6mRURArIXAJ0XeNSdE0IbHfTlmfdNBEh/U56QZwCcDGxr
V4p+6iWaCr6/AvV4rYmg9xs=
=cynE
-----END PGP SIGNATURE-----

--nextPart1501107.YCJ30yI5U1--
