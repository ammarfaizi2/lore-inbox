Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVKZNZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVKZNZm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 08:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVKZNZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 08:25:42 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:64128 "HELO
	matthew.ogrody.nsm.pl") by vger.kernel.org with SMTP
	id S932143AbVKZNZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 08:25:41 -0500
Date: Sat, 26 Nov 2005 14:25:24 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 00/19] Adaptive read-ahead V8
Message-ID: <20051126132524.GA12396@irc.pl>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20051125151210.993109000@localhost.localdomain> <20051125164317.c42c0639.diegocg@gmail.com> <20051126031755.GA7226@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20051126031755.GA7226@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 26, 2005 at 11:17:55AM +0800, Wu Fengguang wrote:
> On Fri, Nov 25, 2005 at 04:43:17PM +0100, Diego Calleja wrote:
> > Recently, a openoffice hacker wrote in his blog that the kernel was
> > culprit of applications not starting as fast as in other systems.
> > Most of the reasons he gave were wrong, but there was a interesting
> > one: When you start your system, you've lots of free memory. Since
> > you have lots of memory, he said it was reasonable to expect that
> > kernel would readahead *heavily* everything it can to fill that
> > memory as soon as possible (hoping that what you readahead'ed was
> > part of the kde/gnome/openoffice libraries etc) and go back to the
> > normal behaviour when your free memory is used by caches etc.
> > "Teorically" it looks like a nice heuristic for desktops. Does
> > adaptative readahead does something like this?
>=20
> It's interesting ;)
> In fact some distributions do have a read-ahead script to preload files on
> startup. The readahead system call should be enough for this purpose:
>=20
> NAME
>        readahead - perform file readahead into page cache

posix_fadvise() with        POSIX_FADV_WILLNEED hint?
              The specified data will be accessed in the near future.

--=20
Tomasz Torcz                 Morality must always be based on practicality.
zdzichu@irc.-nie.spam-.pl                -- Baron Vladimir Harkonnen


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDiGJEThhlKowQALQRAnQbAJ9ef9IvohWUFqMNcxl/Ea84R6XgLQCfXGyx
zErVCOl3HxkHpwAq0Bihs7k=
=zJ1c
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
