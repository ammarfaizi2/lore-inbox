Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267955AbTAMS2L>; Mon, 13 Jan 2003 13:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267943AbTAMS2J>; Mon, 13 Jan 2003 13:28:09 -0500
Received: from h80ad2749.async.vt.edu ([128.173.39.73]:17536 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267892AbTAMS2H>; Mon, 13 Jan 2003 13:28:07 -0500
Message-Id: <200301131836.h0DIalRX005606@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.56] (partial known) bugs/compile errors 
In-Reply-To: Your message of "Mon, 13 Jan 2003 10:02:00 +0100."
             <20030113090200.GA1096@schottelius.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030113090200.GA1096@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_918559007P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jan 2003 13:36:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_918559007P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jan 2003 10:02:00 +0100, Nico Schottelius <schottelius@wdt.de>  said:

> WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/aha152x_cs.ko needs=
>  unknown symbol aha152x_driver_template
> WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/fdomain_cs.ko needs=
>  unknown symbol fdomain_driver_template
> WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/fdomain_cs.ko needs=
>  unknown symbol fdomain_16x0_reset
> WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/fdomain_cs.ko needs=
>  unknown symbol fdomain_setup
> WARNING: /lib/modules/2.5.56/kernel/drivers/message/i2o/i2o_pci.ko needs un=
> known symbol i2o_sys_init
> WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unknown sym=
> bol usb_bus_list_lock
> WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unknown sym=
> bol usb_bus_list
> WARNING: /lib/modules/2.5.56/kernel/fs/nfsd/nfsd.ko needs unknown symbol ha=
> sh_mem
> WARNING: /lib/modules/2.5.56/kernel/arch/i386/kernel/microcode.ko needs unk=
> nown symbol devfs_set_file_size

I can't speak for the others being known, but I posted a fix for the
microcode.ko one the other day.  That one was pretty clearly a EXPORT_SYMBOL
line that got overzealously removed in 2.5.47 (the next 4 EXPORT_SYMBOLS in the
file got removed as part of a code cleanup, one line too many got nuked, I
guess)

I had a few others that went away when I upgraded to Rusty's 0.9.8 version
of module-init-tools that correctly dealt with EXPORT_GPL_SYMBOL....

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_918559007P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Iwc8cC3lWbTT17ARAiVJAJsGRWrOGfPc3CFJzUVOXzlVHPiiPACfWVQm
lMKMDEwlTAbIO1mRRsUB+nk=
=tUjn
-----END PGP SIGNATURE-----

--==_Exmh_918559007P--
