Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWJBUXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWJBUXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWJBUXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:23:35 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35973 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964981AbWJBUXe (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:23:34 -0400
Message-Id: <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] dynticks core: Fix idle time accounting
In-Reply-To: Your message of "Mon, 02 Oct 2006 20:43:26 +0200."
             <1159814606.1386.52.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <200610021302.k92D23W1003320@turing-police.cc.vt.edu> <1159796582.1386.9.camel@localhost.localdomain> <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
            <1159814606.1386.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159820224_3357P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 16:17:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159820224_3357P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Oct 2006 20:43:26 +0200, Thomas Gleixner said:
>
> The patch below fixes the accounting weirdness.

I think it's still slightly defective, or at least suffering from a
disjoint between what is going on - the numbers reported in /proc/stats
add up to the total number of timer interrupts, but that's not necessarily
representative of what happened...

% cat /proc/stat;sleep 15;cat /proc/stat
cpu  27634 0 7762 20470 881 331 252 0
cpu0 27634 0 7762 20470 881 331 252 0
intr 812332 631476 2960 0 4 4 12667 3 14 1 1 4 142891 114 0 22193 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 2187603
btime 1159817297
processes 4028
procs_running 1
procs_blocked 0
nohz total I:397276 S:379955 T:1187.393123 A:0.003125 E: 629447
cpu  27753 0 7818 20739 881 332 253 0
cpu0 27753 0 7818 20739 881 332 253 0
intr 819027 636542 2969 0 4 4 12801 3 14 1 1 4 144371 114 0 22199 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 2209881
btime 1159817297
processes 4033
procs_running 1
procs_blocked 0
nohz total I:401991 S:384494 T:1200.732924 A:0.003122 E: 634513


And the deltas between the sums for cpu0 are equal to the difference of
the first intr (where the timer is) - ticking along at about 446/sec over
that 15 second timeframe. And sure enough, the 'user' field is about 1/3 of
the total interrupts.

The breakage is that userspace tools like gkrellm and vmstat and top are quite
happy in saying "oh, we averaged 446 ticks/sec over the last N seconds? That's
odd, but I can deal..." but unfortunately, treating all of them the same
"width" - and the idle ones are probably twice as wide if not wider.  I'm not
sure how to fix that.

(The "thought experiment" for this - imagine over a 10 second period, an idle
machine takes 100 short timeslices for a running process, and 100 very long
sleeps 10 times as long as the first 100.  What should /proc/stats report at
that point?)

--==_Exmh_1159820224_3357P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIXPAcC3lWbTT17ARAusdAKDfCyPbfApJOc7Kf7XQv86GAg7J8wCg7PKA
mujK6ZrnNwPFFKTj2lCH0y4=
=+b3+
-----END PGP SIGNATURE-----

--==_Exmh_1159820224_3357P--
