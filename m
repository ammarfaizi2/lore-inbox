Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTAGF36>; Tue, 7 Jan 2003 00:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267309AbTAGF36>; Tue, 7 Jan 2003 00:29:58 -0500
Received: from h80ad273a.async.vt.edu ([128.173.39.58]:47232 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267308AbTAGF3z>; Tue, 7 Jan 2003 00:29:55 -0500
Message-Id: <200301070538.h075cICR004033@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!) 
In-Reply-To: Your message of "Mon, 06 Jan 2003 22:20:46 CST."
             <20030107042045.GA10045@waste.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain>
            <20030107042045.GA10045@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-787681340P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Jan 2003 00:38:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-787681340P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Jan 2003 22:20:46 CST, Oliver Xymoron said:

> What was the underlying error rate and distribution you assumed? I
> figure if it were high enough to get to your 1%, you'd have such high
> retry rates (and resulting throughput loss) that the operator would
> notice his LAN was broken weeks before said transfer completed.

The average ISP wouldn't notice things were broken unless enough magic
smoke escaped to cause a Halon dump.

Consider as evidence the following NANOG presentation:

http://www.nanog.org/mtg-0210/wessels.html

Some *98* percent of all queries at one of the root nameservers over a 24-hour
period were broken in some way.  And there wasn't even a DDoS in progress
at the time...

Also, I think Andrew was computing the chances that *SOME* packet in the
100T would be mangled in an undetected fashion, so 99% of the time all 100T
would be OK, but 1% of the time there was some subtle block mangling some
dozens of terabytes into the transfer.  Given that the TCP slow-start code
is currently busticated for gigabit and higher (it takes *hours* without a
packet drop to get the window open *all* the way - there's IETF drafts
in process about this), it's quite possible that you'd not notice packet
drops due to error among all the congestion drops kicking the window size
down.....
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-787681340P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+GmfKcC3lWbTT17ARAsSOAKDpTo3YCPQfaJEouVyV1Z6ZLcHQZQCgqQQ6
9VZ+kwKpL64+SGtiOJIudeQ=
=6lgg
-----END PGP SIGNATURE-----

--==_Exmh_-787681340P--
