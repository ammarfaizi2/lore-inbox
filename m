Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135543AbRAYSEl>; Thu, 25 Jan 2001 13:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135590AbRAYSEV>; Thu, 25 Jan 2001 13:04:21 -0500
Received: from office.globe.cz ([212.27.204.26]:59661 "HELO gw.office.globe.cz")
	by vger.kernel.org with SMTP id <S135585AbRAYSEP>;
	Thu, 25 Jan 2001 13:04:15 -0500
Received: from ondrej.office.globe.cz (10.1.2.22)
  by vger.kernel.org with SMTP; 25 Jan 2001 18:04:01 -0000
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 slowdown at boot.
In-Reply-To: <20130000.980445836@tiny>
From: Ondrej Sury <ondrej@globe.cz>
Date: 25 Jan 2001 19:03:56 +0100
In-Reply-To: <20130000.980445836@tiny>
Message-ID: <874ryny0dv.fsf@ondrej.office.globe.cz>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Chris Mason <mason@suse.com> writes:

> On Thursday, January 25, 2001 06:51:33 PM +0100 Ondrej Sury
> <ondrej@globe.cz> wrote:
>=20
> > Chris Mason <mason@suse.com> writes:
> >> > reiserfs: checking transaction log (device 03:04) ...
> >> > Warning, log replay starting on readonly filesystem
> >> >=20
> >>=20
> >> Here, reiserfs is telling you that it has started replaying transactio=
ns
> >> in the log.  You should also have a reiserfs message telling you how m=
any
> >> transactions it replayed, and how long it took.  Do you have that
> >> message?
> >=20
> > Nope.  I rebooted with Alt-SysRQ+B after some while (aprox more than 30
> > sec, normally reiserfs replay is taking ~5 sec (pre9)).  I wasn't so
> > patient.  I could test it before I'll go from work to home.
> >=20
>=20
> Ok, depending on the metadata load before the crash, replay can take 30
> seconds or more.  You usually have to try to generate that many metadata
> changes, something like creating 100,000 tiny files or directories.
> Compiling with CONFIG_REISERFS_CHECK turned on will give you more details
> about the log replay.

There wasn't crash.  Same log replay after I rebooted with -pre9 took 5
seconds.

> Or, perhaps DMA is now off on your IDE drive, making everything slower.

via 82Cxxx is supported chipset, but I could check that.

Strange is that overall slowdown of kernel, Alt-SysRQ functions are too
slow for kernel to be in normal state.

=2D-=20
Ond=F8ej Sur=FD <ondrej@globe.cz>         Globe Internet s.r.o. http://glob=
e.cz/
Tel: +420235365000   Fax: +420235365009         Pl=E1ni=E8kova 1, 162 00 Pr=
aha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.5 and Gnu Privacy Guard <http://www.gnupg.org/>

iEYEARECAAYFAjpwao0ACgkQ9OZqfMIN8nN7mgCcDSfPxNnbmbtD+TyYHMbKr+vf
TnkAmwfavxKRPrsPwhS0jDTuYqK5iHcL
=NhJo
-----END PGP MESSAGE-----
--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
