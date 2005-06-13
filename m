Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFMTIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFMTIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFMTIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:08:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49164 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261190AbVFMTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:08:21 -0400
Message-Id: <200506131907.j5DJ7e4G017545@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Thomas Renninger <trenn@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2 
In-Reply-To: Your message of "Mon, 13 Jun 2005 20:01:11 +0200."
             <42ADC9E7.30901@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <200506130454.j5D4suNY006032@turing-police.cc.vt.edu> <20050613152507.GB7862@atomide.com> <200506131647.j5DGl0ke009926@turing-police.cc.vt.edu>
            <42ADC9E7.30901@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118689649_5914P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 15:07:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118689649_5914P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jun 2005 20:01:11 +0200, Thomas Renninger said:

> > Should there be a C3/C4?  Is my laptop just plain borked? :)
> Depends on your machine and BIOS, whether it's supported -> seems as if it's not.
> 
> You could verify by having a deeper look in your FADT/DSDT.
> You need the acpi tools from Len Brown (acpidmp/acpixtract) and the iasl Intel ACPI
> compiler.
> AFAIK checking for C-support is rather robust in recent kernels as long as you don't have a broken
> DSDT table.

OK, found acpidmp and iasl, now have a decompiled DSDT - now to figure out
if it's busticated or not.... :)

> Maybe you find a newer BIOS supporting C3?

Nope, I just checked, and the A13 BIOS from 02/06/2004 is the latest that Dell
has released for the C840.  Not much hope there unless there's some special
secret site that even newer BIOS updates hide until they escape.. ;)
 
> To be honest, I doubt you save much power even with dyn tick enabled if you only have support
> for C1 and C2. The pmstats tool from Tony (see link above)
> could tell you nicely whether you gain anything.

Well, it's a start, anyhow. :)

--==_Exmh_1118689649_5914P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrdlxcC3lWbTT17ARAr2YAJ9uURNe0s8eumaFNVyNjnkcwkHwPwCg50us
LY9XD0XnXJg35b8r3Eq1T3s=
=v7z9
-----END PGP SIGNATURE-----

--==_Exmh_1118689649_5914P--
