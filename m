Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTLKICP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTLKICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:02:15 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:38040 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S264278AbTLKICN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:02:13 -0500
Date: Thu, 11 Dec 2003 06:01:20 -0400
From: Rhino <rhino9@terra.com.br>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       wli@holomorphy.com
Subject: Re: [CFT][RFC] HT scheduler
Message-Id: <20031211060120.4769a0e8.rhino9@terra.com.br>
In-Reply-To: <3FD81BA4.8070602@cyberone.com.au>
References: <3FD3FD52.7020001@cyberone.com.au>
	<20031208155904.GF19412@krispykreme>
	<3FD50456.3050003@cyberone.com.au>
	<20031209001412.GG19412@krispykreme>
	<3FD7F1B9.5080100@cyberone.com.au>
	<3FD81BA4.8070602@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__11_Dec_2003_06_01_20_-0400_FBaas.pxOAlt/8Fz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__11_Dec_2003_06_01_20_-0400_FBaas.pxOAlt/8Fz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2003 18:24:20 +1100
Nick Piggin <piggin@cyberone.com.au> wrote:

> 
> 
> Nick Piggin wrote:
> 
> > http://www.kerneltrap.org/~npiggin/w26/
> > Against 2.6.0-test11
> 
> 
> Oh, this patchset also (mostly) cures my pet hate for the
> last few months: VolanoMark on the NUMA.
> 
> http://www.kerneltrap.org/~npiggin/w26/vmark.html
> 
> The "average" plot for w26 I think is a little misleading because
> it got an unlucky result on the second last point making it look
> like its has a downward curve. It is usually more linear with a
> sharp downward spike at 150 rooms like the "maximum" plot.
> 
> Don't ask me why it runs out of steam at 150 rooms. hackbench does
> something similar. I think it might be due to some resource running
> short, or a scalability problem somewhere else.

i didn't had the time to apply the patches (w26 and C1 from ingo ) 
on a vanilla t11, but i merged them with the wli-2,btw this one has really put 
my box on steroids ;) .

none of them finished a hackbench 320 run, the OOM killed all of my
agetty's logging me out. the box is a 1way p4(HT) 1gb of ram 
and no swap heh.


	hackbench:

	sched-rollup-w26					sched-SMT-2.6.0-test11-C1
		
	 50	 4.839						 50	5.200
	100	 9.415						100	10.090
	150	14.469						150	14.764

	

	time tar -xvjpf linux-2.6.0-test11.tar.bz2:

	sched-rollup-w26					sched-SMT-2.6.0-test11-C1
	
	real		43.396					real		23.136
	user		27.608					user		20.700
	sys		 4.039					sys		 4.344

--Signature=_Thu__11_Dec_2003_06_01_20_-0400_FBaas.pxOAlt/8Fz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2EB3P7/1py/aJRgRAszzAJ9l/F797bWhR/0c7ehwh+XKCyBJXgCgm2Q+
A2R1Ne4SmR9F7tvDpCBCVb8=
=febV
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Dec_2003_06_01_20_-0400_FBaas.pxOAlt/8Fz--
