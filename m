Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWIYQDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWIYQDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWIYQDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:03:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750843AbWIYQDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:03:49 -0400
Date: Mon, 25 Sep 2006 12:01:15 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.11 for 2.6.17
Message-ID: <20060925160115.GE25296@redhat.com>
References: <20060925151028.GA14695@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20060925151028.GA14695@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

> [...]
> - It _does not_ change the compiler optimisations.

Like any similar mechanism, it does force the compiler to change its
code generation, so one can't claim this too strongly.

> [...]  Comments are welcome,

I'm still uneasy about the use of varargs.  The current code now uses
the formatting string as metadata to be matched (strcmp) between
producer and consumer.  A general tool that would use them would have
to start parsing general printf directives.  I believe they are not
quite general enough either e.g. to describe a raw binary blob.

I realize they serve a useful purpose in abbreviating what otherwise
one might have to do (like that multiplicity of STAP_MARK_* type/arity
permutations).  But maybe there is a better way.

Also, while regparm(0) may provide some comfort on x86, is there good
reason to believe that the same trick works (and will continue to
work) on non-x86 platforms to invoke a non-varargs callee with a
varargs caller?


- FChE

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFF/1LVZbdDOm/ZT0RAjeNAKCAGAjUIL8OuCUm05TiNzk/V5EEcwCeO1hV
7Lsw+Gh6e1qCZtUB5BfPZFE=
=YapC
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
