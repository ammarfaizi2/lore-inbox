Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUAZFzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 00:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbUAZFzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 00:55:21 -0500
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:63383 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S265505AbUAZFzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 00:55:14 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
Keywords: module
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
	<Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
	<microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org>
	<20040125222242.A24443@mail.kroptech.com>
	<microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org>
	<200401260521.i0Q5LRha021370@turing-police.cc.vt.edu>
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Mon, 26 Jan 2004 15:55:06 +1000
In-Reply-To: <200401260521.i0Q5LRha021370@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Mon, 26 Jan 2004 00:21:27 -0500")
Message-ID: <microsoft-free.87d697s18l.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

* Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

  > On Mon, 26 Jan 2004 15:06:48 +1000, Steve Youngs <sryoungs@bigpond.net.au>  said:
  >> > A boolean is just a one-bit reference count. If the maximum number of
  >> > simultaneous 'users' for a given module is one, then a boolean will work.
  >> > If there is potential for more than one simultaneous user then you need
  >> > more bits.
  >> 
  >> Why?  A module is either being used or it isn't, the number of uses
  >> shouldn't even come into it.

  > OK. There's 2 users of the module.  The first one exits.  How does
  > it (or anything else) know that it's NOT safe to just clear the
  > in-use bit and clean it up?

Because the 2nd user is still using the module so its in-use bit
should still be set.  Remember that when the module was first loaded
it registered a function with the kernel for testing whether the
module is in use.

I must be overlooking something because I see the answer so clearly.
Maybe if someone could give me a real world example of a situation
where it'd be hard/impossible/unsafe to unload a module and I'll see
if my ideas can be applied.



-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAkAUq7wACgkQHSfbS6lLMANqhACbBQG73p0s88uQVVbBNPt8JWxp
k8wAoIEhv65WL3gX0MJgL0XiDVSBmq8y
=mYI6
-----END PGP SIGNATURE-----
--=-=-=--
