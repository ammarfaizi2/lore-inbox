Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWHXSmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWHXSmC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHXSmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:42:02 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33178 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030446AbWHXSmA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:42:00 -0400
Message-Id: <200608241841.k7OIfmRB004765@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okuji@enbug.org
Subject: Re: [patch 0/5] RFC: fault-injection capabilities
In-Reply-To: Your message of "Wed, 23 Aug 2006 20:32:43 +0900."
             <20060823113243.210352005@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20060823113243.210352005@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1156444906_3023P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 14:41:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1156444906_3023P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Aug 2006 20:32:43 +0900, Akinobu Mita said:

> For example about kmalloc failures:
> 
> /debug/failslab/probability
> 
> 	specifies how often it should fail in percent.

As others have noted, the *right* semantics for this is being able to inject a
1% or higher rate in the code you're interested in, while maintaining a 0
injection rate for things outside the module under test.  Maybe a /debug/
failslab/address_start and address_end, and a userspace helper that peeks at a
System.map and injects the right values - then it's a simple compare of the
high/low addresses provided against the caller address.


--==_Exmh_1156444906_3023P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE7fLqcC3lWbTT17ARAvA6AJ0XHtnVMlHMELOg9qNCbE8CEHI6AQCg9EZB
e0j9BN4ZEo7DYI9yGs00nd8=
=bvk0
-----END PGP SIGNATURE-----

--==_Exmh_1156444906_3023P--
