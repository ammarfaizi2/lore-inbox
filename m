Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSHLONs>; Mon, 12 Aug 2002 10:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318034AbSHLONs>; Mon, 12 Aug 2002 10:13:48 -0400
Received: from ppp-217-133-217-5.dialup.tiscali.it ([217.133.217.5]:42961 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S318022AbSHLONr>;
	Mon, 12 Aug 2002 10:13:47 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>
In-Reply-To: <Pine.LNX.4.44.0208121754250.20225-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121754250.20225-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-DKgRlDKkN0ZQGc3RkdcT"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 16:17:30 +0200
Message-Id: <1029161850.4258.64.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DKgRlDKkN0ZQGc3RkdcT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-08-12 at 17:57, Ingo Molnar wrote:
> 
> On 12 Aug 2002, Luca Barbieri wrote:
> 
> > > > Numbers:
> > > > unconditional copy of 2 tls descs: 5 cycles
> > > > this patch with 1 tls desc: 26 cycles
> > > > this patch with 8 tls descs: 52 cycles
> > > 
> > > [ 0 tls descs: 2 cycles. ]
> > Yes but common multithreaded applications will have at least 1 for
> > pthreads.
> 
> i would not say 'common' and 'multithreaded' in the same sentence. It
> might be so in the future, but it isnt today.
Most modern servers (e.g. Apache2, MySQL) are multithreaded and so are
large desktop applications (e.g. Evolution, Galeon, Nautilus).
 
> > > how did you calculate this?
> > ((26 - 5) / 2000) * 100 ~= 1
> > Benchmarks done in kernel mode (2.4.18) with interrupts disabled on a
> > Pentium3 running the rdtsc timed benchmark in a loop 1 million times
> > with 8 unbenchmarked iterations to warm up caches and with the time to
> > execute an empty benchmark subtracted.
> 
> old libpthreads or new one?
What are you asking about? (benchmarks are in kernel mode and context
switch is from forked processes)

> > > glibc multithreaded applications can avoid the
> > > lldt via using the TLS, and thus it's a net win.
> > Surely, this patch is better than the old LDT method but much worse than
> > the 2-TLS one.
> 
> people asked for a 3rd TLS already.
It would be interesting to know what they would use it for.


--=-DKgRlDKkN0ZQGc3RkdcT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9V8N6djkty3ft5+cRAg7IAJ9zR0iKZrAwOO4JgjW4+hQuKoxXzgCdEykI
hNo6wWuI4PwTbPJahs/bzqU=
=/fa2
-----END PGP SIGNATURE-----

--=-DKgRlDKkN0ZQGc3RkdcT--
