Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUHRXzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUHRXzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUHRXzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:55:50 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:65388 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267653AbUHRXzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:55:31 -0400
Date: Wed, 18 Aug 2004 16:55:28 -0700
To: sparclinux@vger.kernel.org
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.6] busybox EFAULT on sparc64
Message-ID: <20040818235528.GA8070@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, sparclinux@vger.kernel.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's an example of a strange phenomenon seen by me and more recently
Jeff Bailey...

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D264482

I'm not sure exactly what's happening here. Summary: passing static
memory to mount(2) returns Bad address, and starting klogd hangs on a
fork(2) call. A mount call will succeed if the memory is copied first
onto the heap. This is 2.6.8 without any SPARC-specific patches, built
for sparc64.

You can check this out at (misnomer)
http://people.debian.org/~joshk/2.4.27/kernel-image-2.6.8-sparc/kernel-imag=
e-2.6.8-1-sparc64_2.4.27-1_sparc.deb
for yourself.

I'm inclined to believe that the two bugs are related; these both happen
with busybox-cvs and the exact same programs work with 2.4. Bastian
Blank suggests that it is the compat wrapper for sys_mount that is not
clean.

Could I get any idea of what is going on here? I'm CC:ing lkml because
this may be a general 2.6 bug that neither Jeff or I have encountered.

--=20
Joshua Kwan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQSPsb6OILr94RG8mAQL9ChAAoVivg5h79ctFmi9KvYUMMYDrGBeH+lLL
B0k3eJmWD91E7s3g0ZxJE9rog7gy3BS7XDTMBTUBv/milnQrtLMTLxDcDk18qOBp
QFK+Y72Htrq0N6QPg/OAdV3Wh4tMCXMKyplqwtOodrBDyksxhkue1Sm01/HGwRGQ
h+uoJBw+kO4uoa0VgUtX6/Ms383fcPuPk2v94+wTAiwIcFDA9ky3koR4fhVQ4WBe
CQdhM0k+Qd2Sg27daye+AyG4kCB13PCRiqbnxtYvUCuBtMY7RcT69CyF7z3WBjUV
vjmxsDAiuaQfpMxWW9w+/DxX5Rdb2LiNGjUcRbXyR8se9e9Zs3TG3QEKMyG3n821
+vJFHrH0Oa9wyoBpKro3ubm3G5NU8OgXprivGQ4/WQ4fYihv4VcdZ9Jodox8Rv0B
EOKcM11Aa7r0PqlMh3rqZ3qwXWaWOs0Sqd2pLpcguoY7GMjF1sLGY5o0qHuucdMW
qI7yenBfChFsq/yX19/vqb/2R5OgJSpjp/SLt7sLdhUMr8zML5kwBzd/5QUsHTF2
Hw33I0fMRowvfGkw16yIjU+cGFwFBoaOi6huwIo34XG6HnlZNsofQHotTCpuRzMd
u6G5yWn1jeeQpAdokCtd9PoEyXjXlLD09BTpQJWUFeGjVRrSzMSS41DO3borLG4q
E670AnVSvEs=
=x+6X
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
