Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUHUScc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUHUScc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267630AbUHUScb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:32:31 -0400
Received: from ppp2-adsl-157.the.forthnet.gr ([193.92.233.157]:28455 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S267625AbUHUScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:32:00 -0400
From: V13 <v13@priest.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: Possible dcache BUG
Date: Sat, 21 Aug 2004 21:31:31 +0300
User-Agent: KMail/1.7
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Marc Ballarin <Ballarin.Marc@gmx.de>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408201608.51038.gene.heskett@verizon.net> <20040821092556.GA14991@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20040821092556.GA14991@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12569762.SpULFajyao";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408212131.38019.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12569762.SpULFajyao
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 21 August 2004 12:25, Barry K. Nathan wrote:
> > Memtest86 may not know howto enable it if its an
> > nforce2 option.  Whatever cache shown as switchable in the bios,
> > turning it off makes a very sick bird out of the machine, like a
> > 33mhz 386sx?
>
> Yeah, disabling the L2 cache on a modern CPU makes it really slow. But,
> it's still a useful troubleshooting option...

When I had the problem described in my previous mail I came to the concluss=
ion=20
that it was related with cache *BUT* it seemed that the cache was just=20
caching wrong data. Disabling the cache would just reduce the problem.

One reason for this is that when the program detected errors in a buffer (i=
=2Ee.=20
0x1234 instead of 0x1111) then they would NOT go away if the program was=20
reading from this buffer all the time. This means that the cache always=20
returned the same data. The error was 'gone' every time the program was=20
suspended for a while or when something else used a lot of memory (i.e.=20
another instance of this program).

So, I'm not suggesting that his cache is faulty but that there can be a CPU=
=20
(or even a M/B) problem that corrupts data when they are transfered from=20
memory to the processor.

> -Barry K. Nathan <barryn@pobox.com>
<<V13>>

--nextPart12569762.SpULFajyao
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBJ5UJVEjwdyuhmSoRAig6AJ904SwtzHs4j+kPwwbp5+l4REVfZwCgs0N/
1Q6uq26BVoQ54jmr8MdjfJM=
=Ka+W
-----END PGP SIGNATURE-----

--nextPart12569762.SpULFajyao--
