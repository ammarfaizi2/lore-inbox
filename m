Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbSLQVrI>; Tue, 17 Dec 2002 16:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267223AbSLQVrH>; Tue, 17 Dec 2002 16:47:07 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:17839 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267222AbSLQVrG>; Tue, 17 Dec 2002 16:47:06 -0500
Message-Id: <200212172154.gBHLsu5E011391@localhost.localdomain>
Date: Tue, 17 Dec 2002 16:54:56 -0500
From: Georg Nikodym <georgn@somanetworks.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-rmap15b
In-Reply-To: <Pine.LNX.4.50L.0212171948400.26879-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0212122349520.17748-100000@imladris.surriel.com>
	<200212161610.gBGGAuB7028719@localhost.localdomain>
	<Pine.LNX.4.50L.0212171948400.26879-100000@imladris.surriel.com>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.eiWXN4nLe8Qzt7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.eiWXN4nLe8Qzt7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2002 19:50:04 -0200 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

> On Mon, 16 Dec 2002, Georg Nikodym wrote:
> 
> > Incidentally, a colleague claimed to have seem this behaviour on a
> > non-rmap 2.4.20.
> 
> > 1. Known behaviour?
> > 2. Is there any data that I should be collecting that people are
> >    interested in?
> > 3. Or should I just go back to 2.4.19-rmap14b (which did not trouble
> > me
> >    in this way)?
> 
> The suspect is the disk elevator, which isn't scheduling requests
> in a way to cause lower read latency, but is optimised more for
> throughput.  This results in some pauses.
> 
> I'll need to look into it.

I discovered after sending the above:

Dec 16 15:08:04 keller kernel: ieee1394: sbp2: sbp2util_allocate_request_packet 
- no packets available!
Dec 16 15:08:04 keller kernel: ieee1394: sbp2: sbp2util_allocate_write_request_p
acket failed
Dec 16 15:08:34 keller kernel: ieee1394: sbp2: aborting sbp2 command

These messages correspond with the pauses...  However, the ieee1394 code
has not changed in some time (as in many months).

-g

--=.eiWXN4nLe8Qzt7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9/50woJNnikTddkMRAlb8AJ9aTWRrNL1EyynTGVa96slt63JsXQCgtqwi
RfrdQGz/CT1yxb0pXEIw4f4=
=bm+8
-----END PGP SIGNATURE-----

--=.eiWXN4nLe8Qzt7--
