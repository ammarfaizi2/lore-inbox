Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTEETct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTEETct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:32:49 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:24208 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id S261249AbTEETcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:32:47 -0400
Date: Mon, 5 May 2003 15:43:29 -0400
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: microcode driver fails on PIII-Celeron
Message-ID: <20030505194329.GA2094@rivenstone.net>
Mail-Followup-To: tigran@veritas.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

    The microcode driver in the kernel fails for me on my laptop with
a PIII-era Celeron 900.  I've tested both 2.4 and 2.5 kernels over
course of a year or so; all abort with the same error when trying to
load the microcode:

microcode: CPU0 no microcode found! (sig=68a, pflags=32)

    My amateur reading of the code leads me to think the processor
might be misidentified somehow (or something, my head doesn't like bit
operations).

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 897.366
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1773.56

    FWIW, this is a Debian unstable system, using the microcode
utilities as packaged for Debian.  The laptop is a Dell Inspiron 2500,
based on the i815 chipset.

    Is this a bug, or is this really not supposed to work?

--
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tr7gWv4KsgKfSVgRAr+3AJ46GTfiJ6j12VoEgny4mBUkyREuvgCeNHx+
/SYPdnJZlcwSCi7uW5TE2KE=
=pLjo
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
