Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbRE0WOY>; Sun, 27 May 2001 18:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262511AbRE0WOO>; Sun, 27 May 2001 18:14:14 -0400
Received: from pc1-camb6-0-cust57.cam.cable.ntl.com ([62.253.135.57]:20358
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S262498AbRE0WOE>; Sun, 27 May 2001 18:14:04 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Abramo Bagnara <abramo@alsa-project.org>, linux@arm.linux.org.uk,
        davem@caip.rutgers.edu, anton@linuxcare.com.au,
        Ralf Baechle <ralf@oss.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures 
In-Reply-To: Message from Adrian Bunk <bunk@fs.tum.de> 
   of "Sun, 27 May 2001 23:07:38 +0200." <Pine.NEB.4.33.0105272301280.8551-100000@mimas.fachschaften.tu-muenchen.de> 
In-Reply-To: <Pine.NEB.4.33.0105272301280.8551-100000@mimas.fachschaften.tu-muenchen.de> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1121109888P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 27 May 2001 23:10:00 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E1548jY-0004D2-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1121109888P
Content-Type: text/plain; charset=us-ascii

>--- include/asm-arm/atomic.h.old	Sun May 27 22:30:58 2001
>+++ include/asm-arm/atomic.h	Sun May 27 22:58:20 2001
>@@ -12,6 +12,7 @@
>  *   13-04-1997	RMK	Made functions atomic!
>  *   07-12-1997	RMK	Upgraded for v2.1.
>  *   26-08-1998	PJB	Added #ifdef __KERNEL__
>+ *   27-05-2001	APB     Removed #ifdef __KERNEL__
>  */
> #ifndef __ASM_ARM_ATOMIC_H
> #define __ASM_ARM_ATOMIC_H
>@@ -30,7 +31,6 @@

This is no good.  The ARM kernel just doesn't provide any atomic primitives 
that will work in user space.  If you want atomicity you have to use 
libpthread.

p.



--==_Exmh_-1121109888P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

>--- include/asm-arm/atomic.h.old	Sun May 27 22:30:58 2001
>+++ include/asm-arm/atomic.h	Sun May 27 22:58:20 2001
>@@ -12,6 +12,7 @@
>  *   13-04-1997	RMK	Made functions atomic!
>  *   07-12-1997	RMK	Upgraded for v2.1.
>  *   26-08-1998	PJB	Added #ifdef __KERNEL__
>+ *   27-05-2001	APB     Removed #ifdef __KERNEL__
>  */
> #ifndef __ASM_ARM_ATOMIC_H
> #define __ASM_ARM_ATOMIC_H
>@@ -30,7 +31,6 @@

This is no good.  The ARM kernel just doesn't provide any atomic primitives 
that will work in user space.  If you want atomicity you have to use 
libpthread.

p.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7EXs4VTLPJe9CT30RAvUbAKDaa1jAUofWYw0z0u808GhOfWEj5QCfW2j+
n/gYS07GAolG6ISDUbOKDnY=
=2+Qj
-----END PGP SIGNATURE-----

--==_Exmh_-1121109888P--
