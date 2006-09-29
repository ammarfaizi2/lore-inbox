Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161322AbWI2R4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbWI2R4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWI2R4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:56:21 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40605 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751234AbWI2R4T (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:56:19 -0400
Message-Id: <200609291756.k8THuHAc008660@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 2/2] libata: _SDD support
In-Reply-To: Your message of "Thu, 28 Sep 2006 11:30:43 PDT."
             <20060928113043.2dd47049.kristen.c.accardi@intel.com>
From: Valdis.Kletnieks@vt.edu
References: <20060928182211.076258000@localhost.localdomain>
            <20060928113043.2dd47049.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159552577_3377P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 13:56:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159552577_3377P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Sep 2006 11:30:43 PDT, Kristen Carlson Accardi said:
> _SDD (Set Device Data) is an ACPI method that is used to tell the 
> firmware what the identify data is of the device that is attached to
> the port.  It is an optional method, and it's ok for it to be missing. 
> Because of this, we always return success from the routine that calls
> this method, even if the execution fails.

I'm OK on it returning success if the _SDD is missing entirely.  And I see
where it's properly droppping a KERN_DEBUG-level printk if it misbehaves.
Whether it should continue on and return success anyhow, I'm not sure.  Can one
of the ACPI wizards comment on that?


--==_Exmh_1159552577_3377P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFHV5AcC3lWbTT17ARAkKJAKD9k5z4IeQ6Jugkhzey5mxDaVhMOwCfSZhR
RMZSCGD+8REjEtgxEYSIexQ=
=fvUr
-----END PGP SIGNATURE-----

--==_Exmh_1159552577_3377P--
