Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWBMAl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWBMAl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWBMAl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:41:28 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:8142 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751102AbWBMAl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:41:27 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
	<20060212161326.279fcb9f.akpm@osdl.org>
Date: Mon, 13 Feb 2006 00:41:22 +0000
In-Reply-To: <20060212161326.279fcb9f.akpm@osdl.org> (Andrew Morton's message
	of "Sun, 12 Feb 2006 16:13:26 -0800")
Message-ID: <87wtg0nl8t.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@osdl.org> writes:

> Roger Leigh <rleigh@whinlatter.ukfsn.org> wrote:
>>
>> When running a 2.6.16-rc2 kernel on a powerpc system (Mac Mini;
>>  Freescale 7447A):
>>=20
>>  $ date && touch f && ls -l f && rm -f f && date
>>  Sun Feb 12 12:20:14 GMT 2006
>>  -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 12:23
>>  Sun Feb 12 12:20:14 GMT 2006
>>=20
>>  Notice the timestamp is 3 minutes in the future compared with the
>>  system time.  "make" is not a very happy bunny running on this kernel
>>  due to every touched file being 3 minutes in the future.
>
> I've had several spates of time-going-nuts on ppc64.  The most recent one
> was because someone went and fiddled with Kconfig naming and I lost the R=
TC
> driver.
>
> What does `grep RTC .config' say?

CONFIG_GEN_RTC=3Dy
CONFIG_GEN_RTC_X=3Dy
CONFIG_SENSORS_RTC8564=3Dm
CONFIG_RTC_X1205_I2C=3Dm

This is just ppc, not ppc64, BTW:
$ uname -m
ppc


Regards,
Roger

=2D-=20
Roger Leigh
                Printing on GNU/Linux?  http://gutenprint.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your m=
ail.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD79W2VcFcaSW/uEgRAl2CAKDBOOqS5MnVe9ZjhE0SdhyXNllDQgCgymjL
hToiwpZzH9FoMnRjPZGYfcE=
=YdJs
-----END PGP SIGNATURE-----
--=-=-=--
