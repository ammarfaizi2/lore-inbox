Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVIMHe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVIMHe2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVIMHe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:34:28 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:20959 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S932382AbVIMHe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 03:34:27 -0400
Date: Tue, 13 Sep 2005 09:34:36 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Message-ID: <20050913093436.4ae3b2c4@laptop.hypervisor.org>
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Tue__13_Sep_2005_09_34_36_+0200_cLM2ENbCJC6/EVVS";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Tue__13_Sep_2005_09_34_36_+0200_cLM2ENbCJC6/EVVS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Sep 2005 20:34:17 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13,=
=20
LT> and that means that the merge window is closed. I've released a=20
LT> 2.6.14-rc1, and we're now all supposed to help just clean up and fix=20
LT> everything, and aim for a really solid 2.6.14 release.

I'm getting a linker error due to disable_timer_pin_1, which is defined in
io_apic.c as int disable_timer_pin_1 __initdata;

but I'm building with

CONFIG_X86_UP_APIC=3Dy
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=3Dy

The error is in setup.c, which can't find the variable since io_apic.c isn't
being compiled in.

arch/i386/kernel/built-in.o(.init.text+0xd51): In function `parse_cmdline_e=
arly':
: undefined reference to `disable_timer_pin_1'
make: *** [.tmp_vmlinux1] Error 1

-Udo.

--Signature_Tue__13_Sep_2005_09_34_36_+0200_cLM2ENbCJC6/EVVS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDJoEPnhRzXSM7nSkRAla5AJ9a3+gMha2VhdS6HW2lUJue78SBsACfcVmW
bIog4AVUn+ewS1TdAhPqKSg=
=PVUz
-----END PGP SIGNATURE-----

--Signature_Tue__13_Sep_2005_09_34_36_+0200_cLM2ENbCJC6/EVVS--
