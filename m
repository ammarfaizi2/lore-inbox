Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270160AbTGPGCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270165AbTGPGCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:02:04 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:6624
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S270160AbTGPGBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:01:51 -0400
Date: Tue, 15 Jul 2003 23:16:42 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716061642.GA4032@triplehelix.org>
References: <20030715225608.0d3bff77.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20030715225608.0d3bff77.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2003 at 10:56:08PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test1=
/2.6.0-test1-mm1/

There are a mountain of warnings when compiling, and I've traced it to
asm-i386/irq.h, i THINK... for example:

In file included from include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/irq.h:17,
                 from arch/i386/kernel/cpu/mcheck/winchip.c:8:
include/asm/processor.h:66: warning: padding struct size to alignment bound=
ary
include/asm/processor.h:339: warning: padding struct to align `info'
include/asm/processor.h:401: warning: padding struct to align `i387'
In file included from include/linux/sem.h:4,
                 from include/linux/sched.h:24,
                 from include/asm/irq.h:14,
                 from include/linux/irq.h:20,
                 from arch/i386/kernel/cpu/mcheck/winchip.c:8:
include/linux/ipc.h:67: warning: padding struct to align `seq'
In file included from include/linux/sched.h:24,
                 from include/asm/irq.h:14,
                 from include/linux/irq.h:20,
                 from arch/i386/kernel/cpu/mcheck/winchip.c:8:
include/linux/sem.h:33: warning: padding struct size to alignment boundary
In file included from include/linux/sched.h:183,
                 from include/asm/irq.h:14,
                 from include/linux/irq.h:20,
                 from arch/i386/kernel/cpu/mcheck/winchip.c:8:
include/linux/aio.h:68: warning: padding struct to align `ki_nbytes'
In file included from include/asm/irq.h:14,
                 from include/linux/irq.h:20,
                 from arch/i386/kernel/cpu/mcheck/winchip.c:8:
include/linux/sched.h:215: warning: padding struct to align `context'
include/linux/sched.h:363: warning: padding struct to align `pid'
include/linux/sched.h:405: warning: padding struct to align `user'
include/linux/sched.h:411: warning: padding struct to align `link_count'
include/linux/sched.h:470: warning: padding struct size to alignment bounda=
ry

on and on and on, several pages for each file compiled.

I don't know what is going on. This is way out of my league..

-Josh

--=20
"Notice that, written there, rather legibly, in the Baroque style common=20
to New York subway wall writers, was, uhm... was the old familiar=20
suggestion. And rather beautifully illustrated, as well..."

       -- Art Garfunkel on the inspiration for "A Poem On The Underground W=
all"

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FO3KT2bz5yevw+4RArrTAJ42WEZSKwjuEFcj/STrm/x6LWVDFwCfUiX8
21wpVUrDGWZUSknrQ4BI+eg=
=S+lH
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
