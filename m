Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbTAXVyd>; Fri, 24 Jan 2003 16:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTAXVyd>; Fri, 24 Jan 2003 16:54:33 -0500
Received: from h80ad25e3.async.vt.edu ([128.173.37.227]:141 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265798AbTAXVyb>; Fri, 24 Jan 2003 16:54:31 -0500
Message-Id: <200301242202.h0OM2m0V007374@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Giuliano Pochini <pochini@shiny.it>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-kernel@alex.org.uk, Alex Tomas <bzzz@tmi.comex.ru>,
       Andrew Morton <akpm@digeo.com>, Oliver Xymoron <oxymoron@waste.org>
Subject: Re: 2.5.59-mm5 
In-Reply-To: Your message of "Fri, 24 Jan 2003 21:04:34 +0100."
             <20030124200434.GD889@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <XFMail.20030124180942.pochini@shiny.it> <3E31765F.4010900@cyberone.com.au> <200301241934.h0OJYf0V005773@turing-police.cc.vt.edu>
            <20030124200434.GD889@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1019470848P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Jan 2003 17:02:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1019470848P
Content-Type: text/plain; charset=us-ascii

On Fri, 24 Jan 2003 21:04:34 +0100, Jens Axboe said:

> Nicks comment refers to the block layer situation, we obviously cannot
> merge reads and writes there. You would basically have to rewrite the
> entire request submission structure and break all drivers. And for zero
> benefit. Face it, it would be stupid to even attempt such a manuever.

As I *said* - "hairy beyond benefit", not "cant".

> Since you bring it up, you must know if a device which can take a single
> command that says "read blocks a to b, and write blocks x to z"? Even
> such thing existed,

They do exist.

IBM mainframe disks (the 3330/50/80 series) are able to do much more than that
in one CCW chain  So it was *quite* possible to even express things like "Go to
this cylinder/track, search for each record that has value XYZ in the 'key'
field, and if found, write value ABC in the data field". (In fact, the DASD I/O
opcodes for CCW chains are Turing-complete).

>                      it would be much better implemented by the driver
> as pulling more requests of the queue and constructing these weirdo

The only operating system I'm aware of that actually uses that stuff is MVS.

> So I quite agree with the "obviously".

My complaint was the confusion of "obviously cant" with "we have decided we
don't want to".

/Valdis

--==_Exmh_-1019470848P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+MbgHcC3lWbTT17ARAnXTAJ9shASjuEdGEQ/jxHGfF58cWORXhwCfRqdr
HjUodOK8lYUu1Nb3Od1ambk=
=y2i0
-----END PGP SIGNATURE-----

--==_Exmh_-1019470848P--
