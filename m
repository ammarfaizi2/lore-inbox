Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbTFVUNS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 16:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbTFVUNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 16:13:18 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:51205 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265863AbTFVUNQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 16:13:16 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: John Bradford <john@grabjohn.com>
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Date: Sun, 22 Jun 2003 22:27:01 +0200
User-Agent: KMail/1.5.2
References: <200306222007.h5MK7CS7000136@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200306222007.h5MK7CS7000136@81-2-122-30.bradfords.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306222227.11414.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 22 June 2003 22:07, John Bradford wrote:
> > No, the build system is OK.  And ccache nicely fixes up any mistakes
> > which the build system makes, and distcc speeds things up by 2x to 3x.
> >
> > None of that gets around the fact that code needs to be tested with
> > various combinations of CONFIG_SMP, CONFIG_PREEMPT, different
> > subarchitectures, spinlock debugging, etc, etc.  If the compiler is slow
> > people don't bother doing this and the code breaks.
> >
> > Cause and effect.
>
> Are the benchmarks that show gcc 3.3 to be much slower at compile time
> being done with a natively compiled gcc 3.3?  I.E. gcc 3.3 compiled
> with itself?
>
> When I upgraded a few machines from 2.95.3 to 3.2.3, I noticed that
> the last of the three compiles, (I.E. a gcc-3.2.3 compiled gcc-3.2.3
> compiling the gcc-3.2.3 source), was noticably quicker than the first
> two, to the extent that it was easily mesaurable by a wall clock.
>
> I am just wondering whether there gcc-3.X binaries in use that were
> compiled with gcc-2.95.3, that are swaying benchmarks in favour of
> 2.95.3 compiled with itself.
>
> I haven't benchmarked gcc-2.95.3 compiled with gcc-3.2.3, though.

The preferred build command for gcc is
$ make bootstrap
AFAIK that compiles the compiler in three stages.
stage1 => normal with currently installed compiler
stage2 => with stage1 compiler
stage3 => I don't know. Either with stage1 or stage2.

So if you built it with bootstrap it's impossible to have
bad or good performance, just because it was built this
this or that compiler.

Please correct me if I'm wrong. :)

> John.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 22:23:42 up  1:25,  1 user,  load average: 1.01, 1.02, 0.97

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+9hEfoxoigfggmSgRAgMSAJ9VI4qcNZZSrvvNv+yAsAehBPAc8wCeJmc2
7C5KMOzhgBYO3ccFSO9oikA=
=UHkb
-----END PGP SIGNATURE-----

