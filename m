Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUAFDAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUAFDAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:00:19 -0500
Received: from h80ad2537.async.vt.edu ([128.173.37.55]:4480 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265327AbUAFDAN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:00:13 -0500
Message-Id: <200401060259.i062xrb3002240@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>, "Yu, Luming" <luming.yu@intel.com>
Cc: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch 
In-Reply-To: Your message of "Mon, 05 Jan 2004 18:08:59 PST."
             <20040105180859.7e20e87a.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <1073354003.4101.11.camel@idefix.homelinux.org>
            <20040105180859.7e20e87a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_303263568P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jan 2004 21:59:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_303263568P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jan 2004 18:08:59 PST, Andrew Morton said:

> Thanks, the acpi-20031203 patch seems to have introduced a handful of
> regressions.

As suggested by Yu Luming, the patch at http://bugzilla.kernel.org/show_bug.cgi?id=1766
is confirmed to fix my issue.  2.6.1-rc1-mm2 with that patch gives me:

%  cat /proc/acpi/battery/BAT0/state 
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      66000 mWh
present voltage:         16548 mV
% cat /proc/acpi/battery/BAT0/info  
present:                 yes
design capacity:         66000 mWh
last full capacity:      62400 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            0004M778
serial number:           1084
battery type:            LION
OEM info:                SANYO


--==_Exmh_303263568P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+iSocC3lWbTT17ARAi5PAJ9nZ7OutqgAo53TBdgkevtGKjzBYgCg4BYK
dvgt9rzbpdFjYvtIJuHVRS4=
=yq3j
-----END PGP SIGNATURE-----

--==_Exmh_303263568P--
