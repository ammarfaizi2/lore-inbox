Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUKWNhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUKWNhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUKWNhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:37:43 -0500
Received: from [213.69.232.58] ([213.69.232.58]:56328 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S261236AbUKWNhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:37:32 -0500
Date: Tue, 23 Nov 2004 14:38:05 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Cc: nico-kernel@schottelius.org
Subject: vmstat: zero cs | system debug
Message-ID: <20041123133805.GF3775@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Some minutes ago I had the following problem:

- a fileserver with many process in 'D' state
- vmstat shows zero context switches
- more or less zero access to the system
- system load of ~150 (many smbd processes with 'D')
- raid looked fine
- no errors in dmesg
- no mysterious processes
- system not hacked (as its in our company lan)
- after rebooting it seems to work
- the initialization of the  Adaptec AHA-2940U/UW/D / AIC-7881U took
  quite long, but it works

My questions:

- what could I have done to find out the problem?
-> I did ps axu, vmstat, cat /proc/mdstat, free, netstat -an
- does zero context switches mean there is one process using
  completly the cpu? if so, why was I able to start vmstat?

- what todo to fix the problem?
-> tried killall -9 smbd apache ...

- is there some TFM for reading about "Linux system analyzing"?

Thanks for any answer,

Nico


--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQaM9O7OTBMvCUbrlAQIH1A/+Oi36k3SsKnwbVo2wSTuHtUWcNceJi9QC
u+oorhagppHPRKC70JlHm3IyPxjnevyjslL01+I2Cg9uPeEn+NyH1+/vn14eFEHI
Lob/aGKRBcGfpO+yYUjgJhcgLe20ytGaiC2HFRBwc+SsmlQ/+Kz241ShM6TaEmZh
U5QJtA6wKal780Dg6bTtrkamneUK9Osogzi8rbVUS6vjwUnoJ6LWCF5Z5mSSr4wE
cZyGR/AYJvAVGIy7gdXEq6EwpBnQXNWtyHbmCDSajFoGdjboxFZBTKSNI9qcAGI7
Btt+dW7dCQvTkBieu+9v4Qab0V/o0hbrVnqmM50gLI0wXmYGDvw6QwBzPz5GbYlc
C0plM0GlRMwJJEz/vfGt0v9t/lJwMXqfdtQOfeLom/gjP1nvrF0Sg7mABwj79O0a
UcIGcVIpCNdWFULQ69f86Cr0vLmO7Fcx8EB64JNUL8iPkKuHrBGf1Stgcvefn0fv
Ml+jK4+3AY+3DpJuqBJEdOny865urAoQhw0GR6ivwln7GvqY1D7hI5TLuL9Ahxf/
oz0RNCbv9aJdVtIqLxnjay3QFImV9q0oVM3MDvAJrdtYCaAwIIUR6Jm0xxL4/0n0
CYITKE5otegm1q4JFeG2AL5lLIGku/2RK73nPIYw7HiQ4FXz4wERl+rGD5n93nj7
p0/GZll2MA4=
=iRRo
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
