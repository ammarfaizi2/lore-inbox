Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUFAVkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUFAVkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUFAVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:40:49 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:42923 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265241AbUFAVkq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:40:46 -0400
Message-Id: <200406012140.i51LejKu020988@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
In-Reply-To: Your message of "Tue, 01 Jun 2004 23:15:36 +0200."
             <1086124536.2278.52.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net> <1086114982.2278.5.camel@localhost.localdomain> <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu> <1086119611.2278.16.camel@localhost.localdomain> <200406012000.i51K0vor019011@turing-police.cc.vt.edu> <1086120865.2278.27.camel@localhost.localdomain> <200406012022.i51KMFEB002660@turing-police.cc.vt.edu>
            <1086124536.2278.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_847561081P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jun 2004 17:40:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_847561081P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 23:15:36 +0200, FabF said:

> 	1.Global inactivity (what you're talking about)
> 	2.Application isolation (what we're talking about).

Again, be careful there - I wasn't the one who said inactive boxes should be in RL3. ;)

And just because I may not be typing on the keyboard doesn't mean that things
are in fact globally inactive - gkrellm is still running, and it has a plugin
monitoring the CPU temperature and adjusting the fan speed as needed, and new
mail is arriving in the background and causing status changes in my MUA.

And yes, said activity tends to keep the gkrellm and MUA pages "hot" and prevent
their swapping out.  The problem is that other processes are also doing stuff
in the background for me - but there's no really good way for the system to
know that I consider the gkrellm lages to be "more important" than those
pages taken up by xclock....

> Geek or not, someone backgrounding an application doesn't want it to
> down the box for X seconds some minutes later when it comes back and
> such things arrive many times a day.

Yes, but a solution to that really *should* take into account that some things
will only down the *app* (if OpenOffice is paging in, I can still interact with
the system if X and my window manager and an xterm aren't paged out), whereas
other things will effectively down the *system* as far as the user is concerned (if
X and/or my window manager are paged out, I'm *stuck* till they come back in).

> Maybe you've got an idea about a
> better rule(s) then ? (I mean for the 2 cases)

I admit I have slacked and haven't tried Nick Piggin's MM patches - others have
commented that those work well.  I am however quite sure that the Really Right
Answer will require much greater subtlety than a rule like "if it uses libX it
shouldn't be swapped out"....


--==_Exmh_847561081P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvPfbcC3lWbTT17ARAn31AJ9OQcm0W7ve95ANafIJwlSH//MY5wCfRGiE
3gsVYV2r5piz53IZNglovnE=
=1wb6
-----END PGP SIGNATURE-----

--==_Exmh_847561081P--
