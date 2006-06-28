Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWF1WTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWF1WTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWF1WTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:19:36 -0400
Received: from smeltpunt.science.ru.nl ([131.174.16.145]:33993 "EHLO
	smeltpunt.science.ru.nl") by vger.kernel.org with ESMTP
	id S1751210AbWF1WTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:19:35 -0400
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@kde.org>
Organization: K Desktop Environment
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion =?iso-8859-1?q?in=09-mm?=)
Date: Thu, 29 Jun 2006 00:19:16 +0200
User-Agent: KMail/1.9.3
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606280118.23270.sebas@kde.org> <20060628195316.GB18039@elf.ucw.cz>
In-Reply-To: <20060628195316.GB18039@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1183876.meTDjxW3AH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290019.17298.sebas@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1183876.meTDjxW3AH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Pavel,

On Wednesday 28 June 2006 21:53, Pavel Machek wrote:
> Okay, can I get some details? Like how much memory does system have,
> what stress test causes the failure?

The machine has 1GB of RAM, filling it up beyond 500MB, maybe 600MB usually=
=20
made swsusp a problem. I'd need to close apps then to be able to suspend.

Using suspend2 fixes that for me. I can even decide how much memory I want=
=20
suspended, the rest will be reliably discarded. I did a benchmark on two=20
similar machines swsusp: would take 45 seconds until resume (that's about t=
he=20
same time it takes it to boot normally) suspend2 would take 25 seconds (and=
=20
have warm caches as a bonus). Not having a progress indicator also doesn't=
=20
really help.

Another thing I really like about suspend2 is that I can easily set it up s=
o=20
it goes into S3 after writing the image. It would resume much faster then,=
=20
and in case it runs out of battery, I can still 'normally' resume from disk=
=2E=20
That's incredibly useful, especially since not all devices are known to=20
completely switch off during S3, and resuming from S3 is generally known to=
=20
cause problems. I've yet to see suspend2 failing though.

Is such a disk-backed hibernate also possible with (u)swsusp?

Cheers,
=2D-=20
sebas

 http://www.kde.org | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
So many beautiful women and so little time. - John Barrymore


--nextPart1183876.meTDjxW3AH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQEVAwUARKMAZWdNh9WRGQ75AQJoJAf+N7mgqqj8FCxU7cHpfykQuVfqsf071NZ1
XpJGvYxB+YQOvHYHl8PvDm+CLaSrg+z2S1VWMuS6bV6C2jfr8BRtBImyF+UNs7zJ
hVw5T4VOOF0MIhvSsrsabl5xcjZNzhgHLbd71FEwfzms2VS+OzDV08u6aNdhtAte
IRs4Zm8+l0CxBA4pgbhzicCQD6N9gmqyjlWPgB8hig+kZ3GUJ4ft6CZGFPnuUGl7
H5hPTD8kEIo4QNoeq/Pzr3G9sU9sOJOGeOkluri6FEFr5xeDKMazuv7xBs0DjDQY
IhD5RmbAEPhCBLmVwbTu5b4mbRsLFG1vnc22poQnANRaa0JAugGvog==
=EE23
-----END PGP SIGNATURE-----

--nextPart1183876.meTDjxW3AH--
