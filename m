Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318693AbSICELK>; Tue, 3 Sep 2002 00:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSICELK>; Tue, 3 Sep 2002 00:11:10 -0400
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:64488 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S318693AbSICELJ>; Tue, 3 Sep 2002 00:11:09 -0400
From: glynis@butterfly.hjsoft.com
Date: Tue, 3 Sep 2002 00:15:30 -0400
To: mk@fashaf.co.za
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 Kernel Panics related to Netfilter/iptables
Message-ID: <20020903041530.GB13142@butterfly.hjsoft.com>
References: <20020902082156.GA28503@fashaf.co.za>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20020902082156.GA28503@fashaf.co.za>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2002 at 10:21:56AM +0200, mk@fashaf.co.za wrote:
> One of my machines running kernel 2.4.18 is getting kernel panics=20
intermittently (30minutes to 4/5 hours).=20
> from the logs I believe is the culprit:
> kernel: LIST_DELETE: ip_conntrack_core.c:165=20
`&ct->tuplehash[IP_CT_DIR_REPLY]'(c6c78e44) not in &ip_conntrack_hash=20
[hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].

i've wrestled quite a bit with this problem, but never really could
figure out the correct answers.  some people blamed the compiler, but
different versions of the compiler still produced it.

i saw it in 2.4.18 and 2.4.19pre kernels on my dual athlon.

in the end i found switching from snat to masqerading for my internal
network seemed to eliminate it.  also i found that if i eliminated my
udp outgoing remote log stream from syslog-ng, i could keep the snat
and have the box still live.

i'm now running nicely with 2.4.19, snat firewall rules, and no remote
logging.

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9dDdiCGPRljI8080RAqHBAJwPmtuIppWLqU0OO7NZpvrzrepiXwCffYTB
/JcQMvsdCkPLVV0XTjQdPbw=
=rUUn
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
