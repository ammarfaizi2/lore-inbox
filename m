Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVBHHzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVBHHzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 02:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVBHHzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 02:55:36 -0500
Received: from h80ad25a2.async.vt.edu ([128.173.37.162]:50949 "EHLO
	h80ad25a2.async.vt.edu") by vger.kernel.org with ESMTP
	id S261476AbVBHHz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 02:55:29 -0500
Message-Id: <200502080755.j187tFI8003915@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01 
In-Reply-To: Your message of "Fri, 04 Feb 2005 11:03:47 +0100."
             <20050204100347.GA13186@elte.hu> 
From: Valdis.Kletnieks@vt.edu
References: <20050204100347.GA13186@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107849315_3540P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Feb 2005 02:55:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107849315_3540P
Content-Type: text/plain; charset=us-ascii

On Fri, 04 Feb 2005 11:03:47 +0100, Ingo Molnar said:
> 
> i have released the -V0.7.38-01 Real-Time Preemption patch, which can be
> downloaded from the usual place:

Hey Ingo.. Sorry to keep breaking stuff on you, but.. ;)

Summary: Looks like CONFIG_NET_PKTGEN=y gives -V0.7.38-03 indigestion.

I retrofitted 0.7.38-03 onto -rc3-mm1, and at boot it wedged up hard scrolling
an error message.  Looked like a 'scheduling while atomic' error coming from
net/pktgen.o.   Sorry for the incomplete traceback, but it locked before
userspace came up, and I don't have hardware handy for a serial console..

I found a CONFIG_NET_PKTGEN=Y in the config, rebuilt with =n, and the resulting
kernel boots fine (am using it as I type). Vanilla -rc3-mm1 also boots fine
with the PTKGEN=y setting (as did 2.6.10-mm1-V0.7.34-01, the last -mm I built
with a -RT patch).  I haven't tried a vanilla -rc3-V0.7.38-03, but I don't see
anyplace -mm1 hits pktgen.c

If the above isn't enough to track down the issue, feel free to let me know
what you'd like me to try next.

--==_Exmh_1107849315_3540P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCCHBjcC3lWbTT17ARAvI6AJ4t0F+qARL13HeyOkB8hyzKfL2CRgCg5kXh
U7kq2rM5m0JM0BjHgMQ/ji4=
=hJfy
-----END PGP SIGNATURE-----

--==_Exmh_1107849315_3540P--
