Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTI2ShI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTI2Sgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:36:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1408 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263993AbTI2Sfp (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:35:45 -0400
Message-Id: <200309291750.h8THojfr001310@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Liviu Voicu <liviuv@savion.cc.huji.ac.il>, linux-mm@kvack.org,
       linux-kernel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: zombies 
In-Reply-To: Your message of "Mon, 29 Sep 2003 09:43:30 PDT."
             <20030929094330.15485106.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <32F7E536759ED611BBA9001083CFB165C07333@savion.cc.huji.ac.il>
            <20030929094330.15485106.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_660582116P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Sep 2003 13:50:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_660582116P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Sep 2003 09:43:30 PDT, Andrew Morton said:

> ah, OK.  What happens if you do a `patch -R -p1' using
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6
.0-test6-mm1/broken-out/call_usermodehelper-retval-fix-2.patch ?

That fixes up the problem here as well.  Also, note that it wasn't just
the Synaptics driver:

ps alwx|grep Z
F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
1     0   290     3   6 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
1     0   292     3   5 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
1     0   294     3   5 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
1     0   296     3   5 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
1     0   298     3   6 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
1     0   300     3   6 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
0     0   578     3   6 -10     0    0 do_exi Z<   ?          0:00 [ifup <defunct>]
1     0  1029     3   6 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
0     0  1216     3   5 -10     0    0 ct>    Z<   ?          0:00 [net.agent <defunct>]
1     0  1227     3   5 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]
1     0  1229     3   6 -10     0    0 t>     Z<   ?          0:00 [events/0 <defunct>]

The ifup was probably attached to either a wireless or Xircom ethernet card,
the net.agent was probably from a PPP connection starting up (based on the PID
of the process).


--==_Exmh_660582116P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eHDycC3lWbTT17ARArXSAJ95d4hlQDCkcG/ekMQBFBagDGos4QCg56y/
gXaq86DP7nrs34q0x3TfRDY=
=p1SJ
-----END PGP SIGNATURE-----

--==_Exmh_660582116P--
