Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270835AbTGVNEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270836AbTGVNEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:04:35 -0400
Received: from h80ad275c.async.vt.edu ([128.173.39.92]:10376 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270835AbTGVNEc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:04:32 -0400
Message-Id: <200307221319.h6MDJVgf007961@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Matthew Hunter <matthew@infodancer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21, NFS v3, and 3com 920 
In-Reply-To: Your message of "Tue, 22 Jul 2003 00:42:45 CDT."
             <20030722054245.GA768@infodancer.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030722054245.GA768@infodancer.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1363527824P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Jul 2003 09:19:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1363527824P
Content-Type: text/plain; charset=us-ascii

On Tue, 22 Jul 2003 00:42:45 CDT, Matthew Hunter <matthew@infodancer.org>  said:

> Running more tests, it turns out the speed problem is isolated to 
> the one machine, and only to *receiving* data.  Sending goes at 
> 8 M/s to other machines from the client machine.  Sending from 
> any machine to the client machine is slowed down, not just from 
> the server.

These symptoms sound suspiciously like a 100BaseT auto-negotiation
problem.  With some combinations of gear, if one end is set to auto-negotiate
and the other end is nailed to full/half duplex (sorry, can't remember which and
I've not my caffiene yet), things go horribly wrong and many packets
dissapear silently on transmission, forcing retransmit timeouts and bad
throughput.  Basically, you end up with one end thinking it's full duplex,
the other end at half - and if the full duplex side ever sends a packet while
the half side is sending, the packet's lost.

Try nailing the devices on both ends of the cat-5 to the same thing (full or
half).  This can of course be interesting if you have an unmanaged hub that
doesn't give you a choice...




--==_Exmh_-1363527824P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/HTnicC3lWbTT17ARAo9bAJ90u3YG2oh0zDEWFz12wDXuuxz2iwCg96zU
uQ7oey0YUUzQL4xvE5pEHVc=
=LkK5
-----END PGP SIGNATURE-----

--==_Exmh_-1363527824P--
