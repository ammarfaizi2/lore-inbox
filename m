Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTEEMgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTEEMgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:36:51 -0400
Received: from [195.95.38.160] ([195.95.38.160]:35324 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262163AbTEEMgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:36:50 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org, Devilkin-lkml@blindguardian.org
Subject: Re: [2.5.69] Irda troubles
Date: Mon, 5 May 2003 14:49:53 +0200
User-Agent: KMail/1.5.1
References: <200305051437.30347.devilkin-lkml@blindguardian.org>
In-Reply-To: <200305051437.30347.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051449.58730.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 14:37, DevilKin wrote:
> Hello list,
>
> Today I've tried to get my infrared synchronisation to my palm pilot
> working. Unfortunately, it doesn't work - I get nothing at all. It worked
> fine under 2.4.20.
>
> The modules in question are irda, ircomm and ircomm_tty.
>
> Upon load of the modules, this is shown in the logs:
>
> IrCOMM protocol (Dag Brattli)
> Module ircomm_tty cannot be unloaded due to unsafe usage in
> include/linux/module.h:457
> ircomm_tty_attach_cable()
> ircomm_tty_ias_register()
> ircomm_tty_close()
> ircomm_tty_shutdown()
> ircomm_tty_detach_cable()
> ircomm_close()
>
> And that's all. I cannot open /dev/ircomm0 or ircomm1, which are:
>
> laptop:/usr/src/linux/net/irda/ircomm# ls -l /dev/ircomm*
> crw-rw----    1 root     dialout  161,   0 Dec 16 14:34 /dev/ircomm0
> crw-rw----    1 root     dialout  161,   1 Dec 16 14:34 /dev/ircomm1
>

Furthermore, I forgot to add this:

laptop:/home/devilkin# findchip -v
Found SMC FDC37N958FR Controller at 0x3f0, DevID=0x01, Rev. 1
    SIR Base 0x2f8, FIR Base 0x280
    IRQ = 3, DMA = 4
    Enabled: yes, Suspended: no
    UART compatible: yes
    Half duplex delay = 3 us

CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tl3zpuyeqyCEh60RAimgAJwKhpL6VIB23/LNgo6ba8/bvCkC6wCeNTsJ
0jbz0gZfeybqHy5NT2obsgY=
=x/Ml
-----END PGP SIGNATURE-----

