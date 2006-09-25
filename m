Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWIYAiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWIYAiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 20:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWIYAiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 20:38:51 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:38086
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751593AbWIYAiu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 20:38:50 -0400
Message-Id: <200609250038.k8P0cEX1017825@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jeff Garzik <jeff@garzik.org>
Cc: Grant Coady <gcoady.lk@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 make oldconfig missed SATA
In-Reply-To: Your message of "Sun, 24 Sep 2006 20:12:10 EDT."
             <45171EDA.1040602@garzik.org>
From: Valdis.Kletnieks@vt.edu
References: <n73eh2d2ido2oimfqn798hp029lshga5qf@4ax.com>
            <45171EDA.1040602@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159144693_16795P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Sep 2006 20:38:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159144693_16795P
Content-Type: text/plain; charset=us-ascii

On Sun, 24 Sep 2006 20:12:10 EDT, Jeff Garzik said:
> Grant Coady wrote:
> > 2.6.18-mm1 make oldconfig didn't pull SATA config from 2.6.18 old screen to
 
> > the new libata screen, caught me out -- this may be an issue for 2.6.19 
> > upgraders that a quick make oldconfig rebuild will fail to boot?
> 
> The symbols changed.  No facility for upgrading .config symbols... 
> people who config their own kernels are expected to handle such things...

I remember getting hit with this several times in the last few -mm's as I
did bisecting and kept crossing over the patch that did that. Fortunately,
'make oldconfig' was nice enough to keep me honest and prompt me for the new
symbol names.

What the Kbuild system *could* use is, for the end of 'make oldconfig', a
report like this for 'y' or 'm' symbols that have evaporated:

The following enabled symbols found in the .config were not defined in any Kconfig file:
CONFIG_FROOBY
CONFIG_DEBUG_FROOBY

So people aren't totally mystified   Admittedly, I've only gotten bit by
silently dissapearing symbols 4-5 times since 2.5.55 or so, but the times
it happened it would have been nice to know....

(OK, I admit it - at least once of those 4-5 times it was because I ran
'make oldconfig' and I hadn't applied a local patch that added a Kconfig option.
Even in that case, a "Yo, dood, something went poof" msg would have saved me
a lot of bang-head-against-wall debugging. :)

--==_Exmh_1159144693_16795P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFFyT1cC3lWbTT17ARAin3AJ9XYDJ3FHdueyteOKxlT3z4QDm1OwCfetf8
Q2aQAM/rVBMmEoDL4lpvZEU=
=rELC
-----END PGP SIGNATURE-----

--==_Exmh_1159144693_16795P--
