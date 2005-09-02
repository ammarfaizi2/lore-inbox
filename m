Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVIBOhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVIBOhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVIBOhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:37:24 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:25061 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S1750890AbVIBOhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:37:23 -0400
From: Pedro Venda <pjvenda@arrakis.dhis.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [PATCH][RFC] vm: swap prefetch
Date: Fri, 2 Sep 2005 15:36:00 +0000
User-Agent: KMail/1.8.2
Cc: Con Kolivas <kernel@kolivas.org>,
       Pedro Venda <pjvenda@arrakis.net.dhis.org>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       Hans Kristian Rosbach <hk@isphuset.no>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200509012346.33020.kernel@kolivas.org> <200509021501.29505.pjvenda@arrakis.dhis.org> <200509030010.19880.kernel@kolivas.org>
In-Reply-To: <200509030010.19880.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2499024.gQlYZPTDBx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509021536.00649.pjvenda@arrakis.dhis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2499024.gQlYZPTDBx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 02 September 2005 14:10, Con Kolivas wrote:
> Yes that about wraps up what it does. It would be even better used in a
> real world situation on a machine that has trouble "getting started" after
> an overnight updatedb run and has been idle for a while.

thanks. your last comment about updatedb reminds me of my "server"'s kind o=
f=20
load :-p

> > about the Hans's proposal - it would increase power consumption, because
> > of increased disk activity. about con's swap prefetch, I'm not so sure.=
=2E.
>
> Depends entirely on workload. Overall I think this increases power
> consumption because the disk does tiny little reads and keeps spinning
> until it has finished prefetching as much as it can. I was thinking it
> could be made configurable and to detect when laptop mode was enabled and
> so on... if it is thought that this is desirable of course.

Not counting hard drive spin-down or even standby, I find no reason for=20
increased power consumption on swap prefetch mechanism, except for page=20
syncing (swap&mem) and perhaps upon process killing...

Question: Imagine some big app like firefox completely swapped. killing it=
=20
implies swapping out the process memory entirely to free allocated pages?

=2D If it does, then your swap prefetch may not increase power consumption =
by a=20
measurable margin, because some of that swapped information was prefetched.
=2D If it does not, than prefetched swapped pages could be useless if the=20
applications dies.

I don't know enough about the kernel VM to answer this on my own.

regards,
pedro venda.
=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org

--nextPart2499024.gQlYZPTDBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDGHFgeRy7HWZxjWERAlRWAJ48pUnEJ3bPIG2FPyadJbWRG1NX9QCfeEc8
ACot/niCVQjO1LZnWwDXzdI=
=tw2I
-----END PGP SIGNATURE-----

--nextPart2499024.gQlYZPTDBx--
