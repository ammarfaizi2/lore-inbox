Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263195AbVGOELE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbVGOELE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbVGOELE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:11:04 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:23980 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263195AbVGOELC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:11:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Fri, 15 Jul 2005 14:08:36 +1000
User-Agent: KMail/1.8.1
Cc: Lee Revell <rlrevell@joe-job.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
References: <d120d50005071312322b5d4bff@mail.gmail.com> <1121383050.4535.73.camel@mindpipe> <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2058393.nUGiEKUbaQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507151408.39932.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2058393.nUGiEKUbaQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 15 Jul 2005 09:25, Linus Torvalds wrote:
> On Thu, 14 Jul 2005, Lee Revell wrote:
> > On Thu, 2005-07-14 at 09:37 -0700, Linus Torvalds wrote:
> > > I have to say, this whole thread has been pretty damn worthless in
> > > general in my not-so-humble opinion.
> >
> > This thread has really gone OT, but to revisit the original issue for a
> > bit, are you still unwilling to consider leaving the default HZ at 1000
> > for 2.6.13?
>
> Yes. I see absolutely no point to it until I actually hear people who have
> actually tried some real load that doesn't work. Dammit, I want a real
> user who says that he can noticeable see his DVD stuttering, not some
> theory.

Disclaimer - This is not proof of a real world dvd stuttering, simply a=20
benchmarked result. My code may be crap, but then the real apps out there m=
ay=20
also be.

Results from interbench v0.21=20
(http://ck.kolivas.org/apps/interbench/interbench-0.21.tar.bz2)

2.6.13-rc1 on a pentium4 3.06

HZ=3D1000:
=2D-- Benchmarking Audio in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.012 +/- 0.00196    0.021		 100	        100
Video	   1.28 +/- 0.509       2.01		 100	        100
X	  0.289 +/- 0.578          2		 100	        100
Burn	  0.014 +/- 0.002      0.023		 100	        100
Write	  0.025 +/- 0.0349      0.49		 100	        100
Read	   0.02 +/- 0.00383    0.052		 100	        100
Compile	  0.023 +/- 0.00752    0.054		 100	        100
Memload	  0.222 +/- 0.892       9.04		 100	        100

=2D-- Benchmarking Video in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.012 +/- 0.00169    0.023		 100	        100
X	   2.55 +/- 2.37        18.7		 100	       75.8
Burn	   1.08 +/- 1.06        16.7		 100	       88.2
Write	  0.224 +/- 0.215       16.7		 100	       97.8
Read	  0.019 +/- 0.00354    0.059		 100	        100
Compile	   4.55 +/- 4.53        17.6		 100	       57.5
Memload	    1.3 +/- 1.34        51.5		 100	         88


HZ=3D250:
=2D-- Benchmarking Audio in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.011 +/- 0.00152    0.022		 100	        100
Video	  0.157 +/- 0.398       3.62		 100	        100
X	    1.3 +/- 1.82        4.01		 100	        100
Burn	  0.014 +/- 0.00142    0.026		 100	        100
Write	  0.022 +/- 0.0125     0.092		 100	        100
Read	  0.021 +/- 0.00366    0.048		 100	        100
Compile	   0.03 +/- 0.0469     0.559		 100	        100
Memload	  0.144 +/- 0.681       8.05		 100	        100

=2D-- Benchmarking Video in the presence of loads ---
	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	      5 +/- 4.99        16.7		 100	         54
X	   9.98 +/- 8.94        20.7		 100	       31.2
Burn	   16.6 +/- 16.6        16.7		 100	      0.167
Write	   4.11 +/- 4.08        16.7		 100	       60.8
Read	   2.55 +/- 2.53        16.7		 100	       73.8
Compile	   15.6 +/- 15.6        17.7		 100	        3.5
Memload	   2.91 +/- 2.92        45.4		 100	       72.5


Audio did show slightly larger max latencies but nothing that would be of=20
significance.

On video, maximum latencies are only slightly larger at HZ 250, all the=20
desired cpu was achieved, but the average latency and number of missed=20
deadlines was significantly higher.

Cheers,
Con

--nextPart2058393.nUGiEKUbaQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1zbHZUg7+tp6mRURAq2OAJ41lx/xdRG2Hth02VrBUVozkyqP1wCeIHoJ
cW7QmyOX81hl2Fg1ES/6oAA=
=ARyG
-----END PGP SIGNATURE-----

--nextPart2058393.nUGiEKUbaQ--
