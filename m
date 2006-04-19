Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWDSSfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWDSSfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWDSSft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:35:49 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:63151 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751030AbWDSSft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:35:49 -0400
Message-Id: <200604191835.k3JIZfeL015424@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 1/11] security: AppArmor - Integrate into kbuild 
In-Reply-To: Your message of "Wed, 19 Apr 2006 10:49:13 PDT."
             <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com> 
From: Valdis.Kletnieks@vt.edu
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
            <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145471741_2985P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Apr 2006 14:35:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145471741_2985P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Apr 2006 10:49:13 PDT, Tony Jones said:

> --- /dev/null
> +++ linux-2.6.17-rc1/security/apparmor/Kconfig
> @@ -0,0 +1,9 @@
> +config SECURITY_APPARMOR
> +	tristate "AppArmor support"
> +	depends on SECURITY!=n
> +	help

This probably needs to be

	depends on SECURITY!=n && SELINUX!=y

unless you want to get into some *really* messy composition issues....

--==_Exmh_1145471741_2985P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERoL9cC3lWbTT17ARAuOdAKCxFl+2nYRCSCId/mBEUhhVCJK1SgCg/heW
RRIc3PG+fuknDunE9clkW1g=
=KBsH
-----END PGP SIGNATURE-----

--==_Exmh_1145471741_2985P--
