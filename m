Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWA2Mfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWA2Mfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 07:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWA2Mfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 07:35:41 -0500
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:58557 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750946AbWA2Mfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 07:35:41 -0500
Message-ID: <43DCB687.1090605@poczta.fm>
Date: Sun, 29 Jan 2006 13:35:19 +0100
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] CONFIG_KOBJECT_UEVENTS in 2.6.15
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig195F218F89E8294C220527A4"
X-EMID: 4564f138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig195F218F89E8294C220527A4
Content-Type: multipart/mixed;
 boundary="------------090900070000070504000602"

This is a multi-part message in MIME format.
--------------090900070000070504000602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings.

IMHO since CONFIG_KOBJECT_UEVENT depends on CONFIG_EMBEDDED it should be
placed in this menu. Now it is in "General setup", what might cause, or
I am such a dumb, some confusion because it is invisible "without any
reason" until C_E is. Here you are a patch that, let me say, fixes the
Kconfig file.

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


----------------------------------------------------------------------
Kobiety i samochody... piekne! >>> http://link.interia.pl/f18f5 

--------------090900070000070504000602
Content-Type: text/x-patch;
 name="kconfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kconfig.diff"

--- /tmp/Kconfig-2.6.15-orig	2006-01-29 13:22:33.000000000 +0100
+++ /tmp/Kconfig-2.6.15	2006-01-29 13:25:10.000000000 +0100
@@ -205,25 +205,6 @@
 	  modules require HOTPLUG functionality, but a module built
 	  outside the kernel tree does. Such modules require Y here.

-config KOBJECT_UEVENT
-	bool "Kernel Userspace Events" if EMBEDDED
-	depends on NET
-	default y
-	help
-	  This option enables the kernel userspace event layer, which is a
-	  simple mechanism for kernel-to-user communication over a netlink
-	  socket.
-	  The goal of the kernel userspace events layer is to provide a simple
-	  and efficient events system, that notifies userspace about kobject
-	  state changes. This will enable applications to just listen for
-	  events instead of polling system devices and files.
-	  Hotplug events (kobject addition and removal) are also available on
-	  the netlink socket in addition to the execution of /sbin/hotplug if
-	  CONFIG_HOTPLUG is enabled.
-
-	  Say Y, unless you are building a system requiring minimal memory
-	  consumption.
-
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
@@ -362,6 +343,25 @@
 	  option replaces shmem and tmpfs with the much simpler ramfs code,
 	  which may be appropriate on small systems without swap.

+config KOBJECT_UEVENT
+	bool "Kernel Userspace Events" if EMBEDDED
+	depends on NET
+	default y
+	help
+	  This option enables the kernel userspace event layer, which is a
+	  simple mechanism for kernel-to-user communication over a netlink
+	  socket.
+	  The goal of the kernel userspace events layer is to provide a simple
+	  and efficient events system, that notifies userspace about kobject
+	  state changes. This will enable applications to just listen for
+	  events instead of polling system devices and files.
+	  Hotplug events (kobject addition and removal) are also available on
+	  the netlink socket in addition to the execution of /sbin/hotplug if
+	  CONFIG_HOTPLUG is enabled.
+
+	  Say Y, unless you are building a system requiring minimal memory
+	  consumption.
+
 config CC_ALIGN_FUNCTIONS
 	int "Function alignment" if EMBEDDED
 	default 0

--------------090900070000070504000602--
--------------enig195F218F89E8294C220527A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD3LaQNdzY8sm9K9wRAv7kAJ9iu8RCupEEGYrhHUvtqUlHCgtdCQCfd3Ru
2sRMkhml2seN76Opz3ZbGgo=
=s3kx
-----END PGP SIGNATURE-----

--------------enig195F218F89E8294C220527A4--
