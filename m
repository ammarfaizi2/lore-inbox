Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUFKIDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUFKIDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFKIDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:03:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21644 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261987AbUFKHEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 03:04:13 -0400
Subject: Re: [STACK] >3k call path in reiserfs
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Hans Reiser <reiser@namesys.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Dave Jones <davej@redhat.com>, Chris Mason <mason@suse.com>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <40C91DA0.6060705@namesys.com>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>
	 <1086784264.10973.236.camel@watt.suse.com>
	 <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com>
	 <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com>
	 <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com>
	 <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SI4uSRfoCNsXso1C/Y4x"
Organization: Red Hat UK
Message-Id: <1086937437.2731.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Jun 2004 09:03:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SI4uSRfoCNsXso1C/Y4x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-11 at 04:49, Hans Reiser wrote:
> >
> I have a concept of stable version and development version.  V3 is the=20
> stable release branch, and should not be disturbed except for bug=20
> fixes. =20

Hans,

I would call stack use like this a bug fix. Let me explain why: in the
2.4 kernel you ALREADY have effectively a 4Kb stack (it's 8Kb but when
you subtract 1.6Kb for the task struct and about 2Kb for soft/hardirq
context about 4Kb is left). It's just more of a lottery there about
if/when you get hit by an irq or not, while with 4KSTACKS in 2.6 the
odds of the lottery changed. I'm sure that as maintainer of a filesystem
that, as you say, is critical and holds peoples email an other critical
data, you rather not play odds at all, regardless of what they are, and
want to play for certainty.

Greetings,
     Arjan van de Ven

--=-SI4uSRfoCNsXso1C/Y4x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyVldxULwo51rQBIRAp7KAJ9s9qXZsN2cQ4jIXFYWSW8F6UwKVQCggNJO
54VcwSdIjY/7ZLBqMr6cb94=
=gU0N
-----END PGP SIGNATURE-----

--=-SI4uSRfoCNsXso1C/Y4x--

