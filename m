Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSKTXVX>; Wed, 20 Nov 2002 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSKTXVW>; Wed, 20 Nov 2002 18:21:22 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:33426
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S263105AbSKTXVV>; Wed, 20 Nov 2002 18:21:21 -0500
Message-ID: <3DDC1A9B.2040604@redhat.com>
Date: Wed, 20 Nov 2002 15:28:27 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com> <20021120033747.GB9007@bjl1.asuk.net> <3DDB09C2.3070100@redhat.com> <20021120215540.GA11879@bjl1.asuk.net> <3DDC08AF.7020107@redhat.com> <20021120232647.GC11879@bjl1.asuk.net>
In-Reply-To: <20021120232647.GC11879@bjl1.asuk.net>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:
>
> Erm, am I getting confused here?  I'm assuming that you can block
> signals in _only_ the thread that is forking, leaving it unblocked in
> the others.  I'm not very familiar with the current threaded signal
> model - is the blocked-signal mask shared between all of them?

Each thread has it's own mask but that also means that a signal can be
blocked by all threads except the one forking.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE93Bqb2ijCOnn/RHQRAnyXAKCRLSumP1tg1q0ZPkw9CLL+Cv87ggCePz0r
e/qB0dwl1DD/JDAAYdkIOSM=
=Y7EM
-----END PGP SIGNATURE-----

