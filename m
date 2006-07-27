Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWG0V2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWG0V2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWG0V2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:28:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35480 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751157AbWG0V2h (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:28:37 -0400
Message-Id: <200607272128.k6RLSJMW027138@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       andrew.j.wade@gmail.com, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
In-Reply-To: Your message of "Thu, 27 Jul 2006 12:56:55 PDT."
             <20060727125655.f5f443ea.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060727015639.9c89db57.akpm@osdl.org> <200607281546.09592.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
            <20060727125655.f5f443ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154035699_3017P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 17:28:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154035699_3017P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Jul 2006 12:56:55 PDT, Andrew Morton said:
> On Fri, 28 Jul 2006 15:46:08 -0400
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > Hello,
> > 
> > Some change between -rc1-mm2 and -rc2-mm1 broke Kubuntu's udev
> > (079-0ubuntu34). In particular /dev/mem went missing, and /dev/null had
> > bogus permissions (crw-------). I've kludged around the problem by
> > populating /lib/udev/devices from a good /dev, but I'm assuming the
> > breakage was unintentional.
> > 
> 
> /dev/null damage is due to a combination of vdso-hash-style-fix.patch and
> doing the kernel build as root (don't do that).

Hmm... I thought the vdso-hash whoops caused /dev/null to get removed and
thus recreated as a regular file - Andrew Wade is showing it as being
mode 600 - but still a 'char special'?

Or did udev get there before somebody managed to recreate it, and it
stuck funky permissions on it?

--==_Exmh_1154035699_3017P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyS/zcC3lWbTT17ARAvhyAKDZAxAO+3bWEsHyVxcVtHTGOSm2+wCeOrsS
TvLjMobEvFwIzH6yDEeXTIQ=
=Jbv2
-----END PGP SIGNATURE-----

--==_Exmh_1154035699_3017P--
