Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRC3OaX>; Fri, 30 Mar 2001 09:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRC3OaO>; Fri, 30 Mar 2001 09:30:14 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:4112 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131446AbRC3OaH>; Fri, 30 Mar 2001 09:30:07 -0500
Date: Fri, 30 Mar 2001 15:29:21 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Juan Piernas Canovas <piernas@ditec.um.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 && ppa: total lockup. No problem with 2.2.17
Message-ID: <20010330152921.Q10553@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0103301519370.13429@ditec.um.es> <Pine.LNX.4.21.0103301554310.14247-100000@ditec.um.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="K1SnTjlYS/YgcDEx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103301554310.14247-100000@ditec.um.es>; from piernas@ditec.um.es on Fri, Mar 30, 2001 at 03:55:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 30, 2001 at 03:55:01PM +0200, Juan Piernas Canovas wrote:

> The kernel configuration is the same in both 2.2.17 and 2.2.19.
> Perhaps, the problem is not in the ppa module, but in the parport,
> parport_pc or parport_probe modules.

There weren't any parport changes in 2.2.18->2.2.19, and the ones in
2.2.17->2.2.18 won't affect you unless you are using a PCI card.

Could you please try this patch and let me know if the behaviour
changes?

Thanks,
Tim.
*/

--- linux/drivers/scsi/ppa.h.eh	Fri Mar 30 15:27:43 2001
+++ linux/drivers/scsi/ppa.h	Fri Mar 30 15:27:52 2001
@@ -178,7 +178,6 @@
 		eh_device_reset_handler:	NULL,			\
 		eh_bus_reset_handler:		ppa_reset,		\
 		eh_host_reset_handler:		ppa_reset,		\
-		use_new_eh_code:		1,			\
 		bios_param:			ppa_biosparam,		\
 		this_id:			-1,			\
 		sg_tablesize:			SG_ALL,			\

--K1SnTjlYS/YgcDEx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6xJhAONXnILZ4yVIRAjk7AJwIETfSX4VC+MwqUCO1jItdFhBh/gCeN4SS
gMAhMcA9dxLspoDw09/mpCw=
=p7lK
-----END PGP SIGNATURE-----

--K1SnTjlYS/YgcDEx--
