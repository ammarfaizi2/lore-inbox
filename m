Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTEEMYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbTEEMYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:24:23 -0400
Received: from [195.95.38.160] ([195.95.38.160]:11759 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262160AbTEEMYW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:24:22 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org, Devilkin-lkml@blindguardian.org
Subject: [2.5.69] Irda troubles
Date: Mon, 5 May 2003 14:37:24 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051437.30347.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello list,

Today I've tried to get my infrared synchronisation to my palm pilot working. 
Unfortunately, it doesn't work - I get nothing at all. It worked fine under 
2.4.20.

The modules in question are irda, ircomm and ircomm_tty.

Upon load of the modules, this is shown in the logs:

IrCOMM protocol (Dag Brattli)
Module ircomm_tty cannot be unloaded due to unsafe usage in 
include/linux/module.h:457
ircomm_tty_attach_cable()
ircomm_tty_ias_register()
ircomm_tty_close()
ircomm_tty_shutdown()
ircomm_tty_detach_cable()
ircomm_close()

And that's all. I cannot open /dev/ircomm0 or ircomm1, which are:

laptop:/usr/src/linux/net/irda/ircomm# ls -l /dev/ircomm*
crw-rw----    1 root     dialout  161,   0 Dec 16 14:34 /dev/ircomm0
crw-rw----    1 root     dialout  161,   1 Dec 16 14:34 /dev/ircomm1

Any ideas what i can try?

Thanks!

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tlsGpuyeqyCEh60RAtT6AJ0Zk6OtrGusNclRDCUaW+WUns+W/gCeJIGT
/HSsVfdmKWay1z29zJG5xzE=
=CRAC
-----END PGP SIGNATURE-----

