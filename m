Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWGQT5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWGQT5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWGQT5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:57:48 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52609 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751172AbWGQT5s (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:57:48 -0400
Message-Id: <200607171957.k6HJvPHT022236@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org, keir@xensource.com,
       Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
In-Reply-To: Your message of "Mon, 17 Jul 2006 20:53:30 +0200."
             <20060717185330.GA32264@rhlx01.fht-esslingen.de>
From: Valdis.Kletnieks@vt.edu
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153166245_13479P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jul 2006 15:57:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153166245_13479P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Jul 2006 20:53:30 +0200, Andreas Mohr said:
> Hi all,
> 

>         for (i = 0; i < 4; i++) {
>                 j = INDEX(i);
>                 do {

>                         if (j < (INDEX(i)) && i < 3)
>                                 list = varray[i + 1]->vec + (INDEX(i + 1));
>                         goto found;
>                 } while (j != (INDEX(i)));
>         }
> found:

> Excuse me, but why do we have a while loop here if the last instruction in
> the while loop is a straight "goto found"?

Consider if we take the 'goto found' when i==1.  We leave not only the do/while
but also the for loop.  A 'continue' instead would leave the do/while and then
drive the i==2 and subsequent 'for' iterations....

(Unless my C mastery has severely faded of late?)

--==_Exmh_1153166245_13479P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEu+ulcC3lWbTT17ARAmfSAKC/sIXHd+Vdo7+7uNR+P4MuHhScwQCfRAzw
aFwUsggK1md2Bg10UzWZFak=
=Bnub
-----END PGP SIGNATURE-----

--==_Exmh_1153166245_13479P--
