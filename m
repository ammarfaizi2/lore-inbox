Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTEXHxw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 03:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTEXHxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 03:53:51 -0400
Received: from h80ad2699.async.vt.edu ([128.173.38.153]:57766 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264221AbTEXHxu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 03:53:50 -0400
Message-Id: <200305240805.h4O85f9O009429@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>, Phil Cayton <phil.cayton@intel.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [RFC] [PATCH] Net device error logging (revised) 
In-Reply-To: Your message of "Fri, 23 May 2003 23:21:24 PDT."
             <3ECF0F64.AAD25389@us.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <3ECF0F64.AAD25389@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_66314912P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 24 May 2003 04:05:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_66314912P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 May 2003 23:21:24 PDT, Jim Keniston said:

> - With Steve Hemminger's creation of the "net" device class a few days
> ago, the network device's interface name is now sufficient to find the
> information about the underlying device in sysfs (even without running
> ethtool).  So these macros no longer log the device's driver name and
> bus ID.

Is something *else* logging the driver name and bus ID?

Just because an interface is called 'eth2' when the message is logged
doesn't mean it's still eth2 when you actually *read* the message.
And no, you *can't* rely on finding the "renaming bus-ID to ethN" message
in the logs - if the system is unstable the last bit of local logging may
go bye-bye if not synced, and messages about network hardware problems are
*very* prone to not making it to the syslog server (I wonder why? ;).

Been there, done that, it's not fun.  Almost swapped out the wrong eth1
a *second* time before realizing what was really going on...

--==_Exmh_66314912P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+zyfUcC3lWbTT17ARAlRpAKCjpTPiL/ZOwFIEGMOgKHKVQZxtkwCgkyOB
gHbZjNch5l9CS35Uzq4x93M=
=X1IW
-----END PGP SIGNATURE-----

--==_Exmh_66314912P--
