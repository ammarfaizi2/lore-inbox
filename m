Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUFTKur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUFTKur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 06:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUFTKur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 06:50:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14047 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264668AbUFTKup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 06:50:45 -0400
Date: Sun, 20 Jun 2004 12:50:25 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Zach, Yoav" <yoav.zach@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Handle non-readable binfmt_misc executables
Message-ID: <20040620105025.GA9349@devserv.devel.redhat.com>
References: <2C83850C013A2540861D03054B478C060416BC17@hasmsx403.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <2C83850C013A2540861D03054B478C060416BC17@hasmsx403.ger.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 20, 2004 at 01:41:30PM +0300, Zach, Yoav wrote:
> I'm not sure I understand the problem. Load_elf_binary also
> uses sys_close for recovery in case of error. Can you please
> give me more details on the problems you see with using sys_close ?

for one, sys_close, while currently exported, shouldn't be really.
(it is exported right now for a few drivers that have invalid firmware
loaders that haven't been converted to the firmware loading framework).
In addition it's way overkill, you created the fd so half the safety
precautions shouldn/t be needed

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA1WvwxULwo51rQBIRAl66AJoCKAwi/tOm65GXrFdAQLqaWPAhIQCfcMip
a2g9gS3W7rkYA4wRFoqn3cw=
=ItPk
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
