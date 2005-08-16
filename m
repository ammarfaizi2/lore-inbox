Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVHPFSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVHPFSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVHPFSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:18:04 -0400
Received: from h80ad2575.async.vt.edu ([128.173.37.117]:65197 "EHLO
	h80ad2575.async.vt.edu") by vger.kernel.org with ESMTP
	id S965108AbVHPFSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:18:02 -0400
Message-Id: <200508160517.j7G5Hm2D017218@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support 
In-Reply-To: Your message of "Mon, 15 Aug 2005 23:09:28 CDT."
             <1124165368.10755.136.camel@soltek.michaels-house.net> 
From: Valdis.Kletnieks@vt.edu
References: <1124165368.10755.136.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1124169467_3269P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 01:17:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1124169467_3269P
Content-Type: text/plain; charset=us-ascii

On Mon, 15 Aug 2005 23:09:28 CDT, you said:

> No, dcdbas has nothing to do with this. I'll have to submit a patch
> against the docs. The program you need to use already exists and is
> open source. You can use libsmbios to do this.
> http://linux.dell.com/libsmbios/main.

Now I'm confoozled.  Maybe - I suspect we're actually in violent agreement...

On Mon, 15 Aug 2005 17:58:56 CDT, Michael_E_Brown@Dell.com said:
> 	Additionally, we are releasing an open source library (GPL/OSL dual 
> license) that can use these hooks to perform many systems management 
> functions in userspace. See http://linux.dell.com/libsmbios/main/. We 
> should have code in libsmbios to do SMI using this driver within about two 
> weeks.  We currently writing the SMI hooks in libsmbios using this posted 
> version of the driver. I am the maintainer of this project, and it is my goal 
> to have code in libsmbios for every Dell SMI call.

So dcdbas *is* intended as the kernel end of the userspace libsmbios, which
is the suggested way of getting that BIOS updated. OK, I got it now.. ;)

(continuing on)

> The binary you want to use is "activateCmosToken", under bins/output/
> (after compilation). The command line syntax is like this:
> 	activateCmosToken 0x005C
> 
> If you want to cancel a BIOS update that has already been activated
> (per above), use: 	
> 	activateCmosToken 0x005D
> 
> Basically, follow the docs in the RBU docs as far as cat-ing the bios
> update image to the rbu sysfs files, then use the activateCmosToken
> program to tell BIOS to do the update on reboot. 

Ahh... the missing piece I didn't have before. :)

--==_Exmh_1124169467_3269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDAXb7cC3lWbTT17ARArGaAKCALCSbDVi3cRClZXB2b4y5DKYwXQCgvW/p
qbT7iwb5w7I6z9hQvHGerqw=
=LubO
-----END PGP SIGNATURE-----

--==_Exmh_1124169467_3269P--
