Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUBAMeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 07:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbUBAMeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 07:34:10 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:37008 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265282AbUBAMeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 07:34:05 -0500
Message-ID: <401CF22C.2000905@yahoo.es>
Date: Sun, 01 Feb 2004 07:33:48 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.22  memory overwriting
References: <401CEDAD.70601@bluewin.ch>
In-Reply-To: <401CEDAD.70601@bluewin.ch>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE22104B48D72078A6311463C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE22104B48D72078A6311463C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Julien Rebetez wrote:
> Hi !
> I've writen the following program :
> 
> 
> #include <stdio.h>
> 
> int main ()
> {
>        int p[4];
>        p[0]=1;
>        p[1]=2;
>        p[2]=3;
>        p[3]=4;
>        p[4]=5;
> 
>        printf ("%i, %i, %i, %i, %i\n", p[0], p[1], p[2], p[3],
> p[4]);
>        return 0;
> }
> 
> I compile it with :
> 
> gcc -o test test.c -Wall
> 
> and when i launch it, the output is :
> 
> julien:$> ./test
> 1, 2, 3, 4, 5
> 
> Should I not get a SIGSEV from the system ? Isn't it dangerous to allow 
> the user to put 5 elements in a 4 elements tab?
> 
> (tested on Linux 2.4.22 on a i686)
> 
> Thanks

Remember that C was written by experts for use by experts.  C makes
the unfortunate assumption that you know *exactly* what you are doing.
This flexibility is great for tho advanced system programmer, but
dangerous for the unwary.

-Roberto

--------------enigE22104B48D72078A6311463C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAHPI6TfhoonTOp2oRAop+AKCSVK285/4miUL5tF8cnd5jsJUT9QCg2iy6
VgLWPRZWsoKTpbQpKlDBFOg=
=j4ru
-----END PGP SIGNATURE-----

--------------enigE22104B48D72078A6311463C--
