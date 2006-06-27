Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWF0MNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWF0MNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWF0MNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:13:21 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:58093 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932259AbWF0MNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:13:20 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend2][ 2/2] [Suspend2] Freezer upgrade.
Date: Tue, 27 Jun 2006 22:13:14 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net> <200606270848.55475.nigel@suspend2.net> <20060627110933.GA11763@elf.ucw.cz>
In-Reply-To: <20060627110933.GA11763@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1660849.RA1o9j4gbl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606272213.18263.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1660849.RA1o9j4gbl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 21:09, Pavel Machek wrote:
> Hi!
>
> > > > This patch represents the Suspend2 upgrades to the freezer
> > > > implementation. Due to recent changes in the vanilla version, I
> > > > should be able to greatly reduce the size of this patch. TODO.
> > >
> > > So I assume the patch will change in the future.
> >
> > This is after the changes. Sorry - forgot to update the comment.
>
> Also please explain why we want those patches. "upgrades the freezer"
> is not good enough reason to apply a patch.

I guess you missed the reply to Rafael. In it, I wrote:

"XFS. Did you see Nathan's reply not long ago, confirming that it doesn't s=
top=20
all activity if you don't freeze bdevs? That isn't critical for swsusp=20
(although I guess you could end up with some filesystem inconsistency if XF=
S=20
writes something after the atomic copy), but keeping the LRU static is=20
important for suspend2."

In another email, I mentioned that trying to free memory with swap on a=20
journalled filesystem is a potential deadlock situation without the=20
capability of thawing kernel threads alone. You could potentially thaw all=
=20
threads while eating memory, but then there's a greater chance of racing=20
against another program that's trying to allocate memory (if you're in this=
=20
situation, you're low on memory to start with).

Regards,

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1660849.RA1o9j4gbl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoSDeN0y+n1M3mo0RAiOUAKCwbz3u0ALrMET0H9wmMER+ncTByQCfRQbo
9nJlg4nl7TVxCcQWqd/DEag=
=Ue89
-----END PGP SIGNATURE-----

--nextPart1660849.RA1o9j4gbl--
