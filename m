Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWGaCHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWGaCHz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 22:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWGaCHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 22:07:54 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:23491
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932375AbWGaCHy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 22:07:54 -0400
Message-Id: <200607310206.k6V26abt006083@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
In-Reply-To: Your message of "Sun, 30 Jul 2006 18:49:38 +0200."
             <20060730164938.GA10849@stusta.de>
From: Valdis.Kletnieks@vt.edu
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607292050.37877.ak@suse.de> <20060729185737.GG26963@stusta.de> <200607292104.18030.ak@suse.de> <20060729191938.GH26963@stusta.de> <200607301614.k6UGEpIL023020@turing-police.cc.vt.edu>
            <20060730164938.GA10849@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154311595_2988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Jul 2006 22:06:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154311595_2988P
Content-Type: text/plain; charset=us-ascii

On Sun, 30 Jul 2006 18:49:38 +0200, Adrian Bunk said:
> On Sun, Jul 30, 2006 at 12:14:51PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Sat, 29 Jul 2006 21:19:38 +0200, Adrian Bunk said:
> > 
> > > That was never true in Arjan's patches.
> > > 
> > > The only change is from a gcc version check to a feature check.
> > > 
> > > In both cases, a gcc 4.1 without the appropriate patch applied will 
> > > result in this option not being set.
> > 
> > What do you get if you have a gcc 4.1.1. that has the stack protector option
> > (so a feature check works), but not the fix for gcc PR 28281?
> 
> This is handled correctly in both cases.
> 
> Please read the patches in this thread for more information.

Patches? I read the *patches*. :)  What I missed was this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115412601229175&w=2

was the only thing I found (over in the 5/5 thread) that remotely looked
like an actual workable test, and all Arjan said was:

> the following line is enough actually:

> echo "int foo(void) { char X[200]; return 3; }" | gcc -S -xc -c -O0 -mcmodel=kernel \ -fstack-protector - -o - | grep -q "%gs"

> echo $? (eg return value) gives 0 for the "works" case, "1" for the
> "wrong gcc" case...

I admit missing that one, because it wasn't actually a patch, but a commentary
I managed to not read and digest in detail (in particular, it wasn't at all
clear that his one-liner would DTRT re: PR28281...)


--==_Exmh_1154311595_2988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzWWrcC3lWbTT17ARAonVAKC1ueF4EUfwAJr78UbKj1ZyPk2m4wCfZbZn
LyPpp5/eTgj6EP+q/Lt97NI=
=35yc
-----END PGP SIGNATURE-----

--==_Exmh_1154311595_2988P--
