Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946050AbWGOOir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946050AbWGOOir (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 10:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946052AbWGOOir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 10:38:47 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:129 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1946050AbWGOOiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 10:38:46 -0400
X-Sasl-enc: cbDib7AI9id15+7+tQu64k5dJ4/X/3J9DRQkEL6+7oc5 1152974320
Message-ID: <44B8FE64.6040700@imap.cc>
Date: Sat, 15 Jul 2006 16:40:36 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm2: process `showconsole' used the removed sysctl system
 call
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C28A8AE3C1E8612515E8AF7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C28A8AE3C1E8612515E8AF7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

After installing a 2.6.18-rc1-mm2 kernel without sysctl syscall support
on a standard SuSE 10.0 system, I find the following in my dmesg:

> [   36.955720] warning: process `showconsole' used the removed sysctl system call
> [   39.656410] warning: process `showconsole' used the removed sysctl system call
> [   43.304401] warning: process `showconsole' used the removed sysctl system call
> [   45.717220] warning: process `ls' used the removed sysctl system call
> [   45.789845] warning: process `touch' used the removed sysctl system call

which at face value seems to contradict the statement in the help text
for the CONFIG_SYSCTL_SYSCALL option that "Nothing has been using the
binary sysctl interface for some time time now". (sic)

Meanwhile, the second part of that sentence that "nothing should break"
by disabling it seems to hold true anyway. The system runs fine, and
activating CONFIG_SYSCTL_SYSCALL in the kernel doesn't seem to have any
effect apart from changing the word "removed" to "obsolete" in the above
messages.

HTH
Tilman

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany


--------------enig9C28A8AE3C1E8612515E8AF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEuP5kMdB4Whm86/kRAi2lAJ9IdWLEkGpj6Gb9iuq/p8wcYaLkGgCdGlab
5rk7CApR59TgCjxkIcUW/v8=
=I81C
-----END PGP SIGNATURE-----

--------------enig9C28A8AE3C1E8612515E8AF7--
