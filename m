Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290192AbSALAfE>; Fri, 11 Jan 2002 19:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290191AbSALAes>; Fri, 11 Jan 2002 19:34:48 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:4409 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S290188AbSALAeQ>; Fri, 11 Jan 2002 19:34:16 -0500
Date: Sat, 12 Jan 2002 01:34:14 +0100
From: Kurt Garloff <garloff@suse.de>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Dan Kegel <dank@kegel.com>,
        "Timothy D. Witham" <wookie@osdl.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdl.org
Subject: [OT] Re: Regression testing of 2.4.x before release?
Message-ID: <20020112013414.B23020@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Dan Kegel <dank@kegel.com>, "Timothy D. Witham" <wookie@osdl.org>,
	Luigi Genoni <kernel@Expansa.sns.it>,
	Mike Galbraith <mikeg@wen-online.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	stp@osdl.org
In-Reply-To: <E16PAuX-0002Ob-00@starship.berlin> <Pine.LNX.4.33.0201111600560.19843-100000@shell1.aracnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201111600560.19843-100000@shell1.aracnet.com>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 11, 2002 at 04:04:59PM -0800, M. Edward (Ed) Borasky wrote:
> One particular application for which gcc 3.x *and* gcc 2.96.x are
> seriously deficient, at least on Intel/AMD 32-bit systems, is the
> high-performance linear algebra library Atlas. As a result, *my* default
> for compiling numerical applications is the Atlas-recommended one,
> 2.95.3. For the kernel, I use whatever the Red Hat 7.2 default is.

One of the problems of gcc-3 is taking decisions when to inline and when
not. This can hurt numerical code a lot, especially C++.
You may want to use -finline-limit-XXX to tune.
http://www.garloff.de/kurt/freesoft/gcc/
v1 of my patch went into 3.0.3, some version (don't know which) into
mainline, so 3.0.3 should do better.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8P4SFxmLh6hyYd04RAhQNAKC7hx+KhNzK8WdcxiIjU6CdJO+cFACfXeAX
ThGsprHpWHu3tkQ0rDiVnBk=
=5d6K
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
