Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbTANRqw>; Tue, 14 Jan 2003 12:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTANRqw>; Tue, 14 Jan 2003 12:46:52 -0500
Received: from grendel.firewall.com ([66.28.56.41]:47768 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S264859AbTANRqs>; Tue, 14 Jan 2003 12:46:48 -0500
Date: Tue, 14 Jan 2003 18:55:28 +0100
From: Marek Habersack <grendel@caudium.net>
To: linux-kernel@vger.kernel.org
Subject: XFS problems (hard lockup and oops on startup) with 2.5.5{6,7}
Message-ID: <20030114175528.GA1213@thanes.org>
Reply-To: grendel@caudium.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

  The kernel 2.5.56 seems to have changed something that affected the XFS
code as I'm getting hit by one (and possibly two) bugs related to it now.
What happens is that the machine suddenly freezes (running Debian/Sid -
XFree 4.2.1, glibc 2.3.1, gnome2 - nothing out of ordinary) so that SysRq
keys don't have any effect (but Numlock still toggles the led on the
keyboard), machine is inaccessible from the net and the only cure is hard
reboot. Nothing gets logged on the freeze and on reboot when XFS attempts to
check the first filesystem the kernel oopses with Oops code 0002, in the
interrupt handler. Nothing gets logged, of course, so I can't provide the
full backtrace right now - I'll try to get it logged through the serial console
if it happens again with 2.5.58. I have copied some values by hand from the
screen (until I lost patience... :)):

Unable to handle kernel paging request at virtual address 000500074
 printing EIP

C0138652
*PDE: 00000000
Oops: 0002
EIP: 0060:[<c0138662>]
EFLAGS: 00010016
EAX: 00050070 EBE: EFBB8000 ECX: EFBB8040 EDX: 0A000000
ESI: EFFEFE50 EDI: 00000000 EBP: EFFEFE5C ESP: C0403ECC
DS: 007B ES: 007B SS: 0069

Process: swapper (PID: 0, threadinfo=C0402000 TASK: C03DBC00)

The only way to get back to 2.5.5{6,7} is
to reboot to 2.5.55 or earlier whose XFS is able to recover the filesystem
and then go back to .5{6,7}. My machine config is attached. Is anyone else
observing such behavior?

TIA,

marek

--HcAYCG3uE/tztfnV
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config-2.5.57.bz2"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JE8Pq3909GIf5uoRAkxcAJ4sYMhCdZ9cLRTmVYOS9GRy5WJR/wCfZ1dF
VJzISXYEYrn86VQXCuYSj1c=
=kiXq
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
