Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTEYDQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 23:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTEYDQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 23:16:18 -0400
Received: from [128.173.39.63] ([128.173.39.63]:29312 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261292AbTEYDQQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 23:16:16 -0400
Message-Id: <200305250329.h4P3TGoH004620@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Fix NMI watchdog documentation 
In-Reply-To: Your message of "Sat, 24 May 2003 15:11:06 EDT."
             <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com> 
From: Valdis.Kletnieks@vt.edu
References: <3ECFC2D6.2020007@gmx.net> <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com>
            <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1378069916P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 24 May 2003 23:29:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1378069916P
Content-Type: text/plain; charset=us-ascii

On Sat, 24 May 2003 15:11:06 EDT, Zwane Mwaikambo said:

> Forgot this bit;
> 
> w/ CONFIG_X86_LOCAL_APIC=y you only have nmi_watchdog=2
> 
> w/ CONFIG_X86_IO_APIC=y you have nmi_watchdog=1 and 2
> 
> w/ CONFIG_SMP you have nmi_watchdog=1 and 2 as it depends on 
> CONFIG_X86_IO_APIC

% grep APIC /usr/src/linux-2.5.69/.config
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

but 'dmesg' on my Dell Latitude C840 laptop tells me:

Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.

Is this nmi_watchdog="forget about it dave" time, or is there some way to
get this to work?

--==_Exmh_1378069916P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+0DiLcC3lWbTT17ARAm11AKCd9QpA6GVpMPmWrsZPFaVlCq+/WgCg54Fu
6ti05X6A8mtycT+TX/k1hsY=
=orpQ
-----END PGP SIGNATURE-----

--==_Exmh_1378069916P--
