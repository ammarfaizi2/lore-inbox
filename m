Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbTI3Ohq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTI3Ohq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:37:46 -0400
Received: from h80ad2612.async.vt.edu ([128.173.38.18]:34719 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261535AbTI3Ohp (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:37:45 -0400
Message-Id: <200309301437.h8UEbSvl017305@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Robert Love <rml@tech9.net>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was Re: [PATCH] i386 do_machine_check() is redundant. 
In-Reply-To: Your message of "Tue, 30 Sep 2003 00:55:13 EDT."
             <1064897712.4568.32.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org> <1064775868.5045.4.camel@laptop.fenrus.com> <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz> <20030929202604.GA23344@nevyn.them.org> <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz> <200309300449.h8U4nSvl002308@turing-police.cc.vt.edu>
            <1064897712.4568.32.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-228707008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Sep 2003 10:37:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-228707008P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 Sep 2003 00:55:13 EDT, Robert Love said:

> Hm, we may need to do something like:
> 
> 	#define abs(n)	 __builtin_abs((n))
> 
> because -ffreestanding implies -fno-builtin, which disables use of
> built-in functions that do not begin with __builtin.

Well, abs() is the only one I tripped over in my config.  I'm sure there's others
lurking elsewhere in the kernel tree.

The bigger question is whether a patch to support -ffreestanding would be a
good idea - with proper use of the __builtin_* stuff it *should* work, and it will
hopefully cause better kernel code hygiene..

--==_Exmh_-228707008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eZUncC3lWbTT17ARAhSmAKCwWue0In0Gxn0pVlgWDP/R9x1NWACg/ifX
GOJ8tdJ+iaesBwUilQwe6cE=
=4PWq
-----END PGP SIGNATURE-----

--==_Exmh_-228707008P--
