Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTJ0LRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 06:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTJ0LRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 06:17:15 -0500
Received: from psemail.epfl.ch ([128.178.50.179]:39183 "HELO psemail.epfl.ch")
	by vger.kernel.org with SMTP id S261575AbTJ0LRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 06:17:01 -0500
Date: Mon, 27 Oct 2003 12:16:53 +0100
From: Frederic Gobry <frederic.gobry@smartdata.ch>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test9] PS/2 touchpad issues
Message-ID: <20031027111653.GA8550@rhin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(please CC your answers to me, thanks)

I still cannot have my synaptics touchpad to work with test9. This is
on a Compaq Presario 1694.

The i8042 driver does not recognize my PS/2 AUX port unless I comment
out the bit assignment tests in i8042.c/i8042_check_aux (), line 655
and following.

When I comment out this section, the AUX port is detected (see
attachment 1)

Then, when I insert the psmouse module (with support for synaptics
touchpads), the touchpad cannot be initialized. This used to pass with
test6. Then, the touchpad behaves like in PS/2 mode, that is,
erratically (jumps from one side of the screen to the other at the
slightest touch) [The logs are in attachment 2]

Third situation: psmouse with noext=3D1. The device is detected, but
acts as jumpily as previously [attach. 3]

I guess having the synaptics being undetected is the least problem,
the two main issues are with the port not being discovered by default,
and the touchpad moving my pointer frantically... Any hints on how to
fix that ?

Fr=E9d=E9ric

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=test9-detect

mice: PS/2 mouse device common for all mice
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: 0f <- i8042 (return) [1]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: a9 <- i8042 (return) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: 5b <- i8042 (return) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [2]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [3]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [5]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [8]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [8]
serio: i8042 AUX port at 0x60,0x64 irq 12
drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [8]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [8]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [8]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [35]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [40]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [40]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [40]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [40]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [40]
drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [40]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [41]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [41]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [41]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [41]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [41]
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=test9-psmouse-ext

drivers/input/serio/i8042.c: 60 -> i8042 (command) [231458]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [231458]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231459]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [231459]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231462]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [231465]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231465]
drivers/input/serio/i8042.c: f6 -> i8042 (parameter) [231465]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231468]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231469]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231469]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231471]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231472]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231472]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231475]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231476]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231476]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231478]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231478]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231478]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231481]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231481]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231481]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231485]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231485]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231485]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231487]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231488]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231488]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231490]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231491]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231491]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231494]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231494]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [231494]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231497]
drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, aux, 12) [231498]
drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [231499]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, aux, 12) [231502]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231503]
drivers/input/serio/i8042.c: ff -> i8042 (parameter) [231503]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231505]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 12) [231891]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [231892]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231893]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [231893]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231895]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231896]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231896]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231899]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231899]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231899]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231902]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231902]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231902]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231905]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231905]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231905]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231908]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231909]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231909]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231911]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231912]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231912]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231914]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231915]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231915]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231918]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231918]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [231918]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231921]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231921]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [231921]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231924]
drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, aux, 12) [231926]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux, 12, timeout) [231929]
drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [231932]
Unable to query/initialize Synaptics hardware.
input: PS/2 Synaptics TouchPad on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231934]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [231934]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, aux, 12) [231934]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231935]
drivers/input/serio/i8042.c: 3c -> i8042 (parameter) [231935]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231937]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231938]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [231938]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231939]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231940]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [231940]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231941]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231942]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [231942]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231944]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231945]
drivers/input/serio/i8042.c: ea -> i8042 (parameter) [231945]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231946]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [231947]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [231947]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231948]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [231951]


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=test9-psmouse-noext

drivers/input/serio/i8042.c: 60 -> i8042 (command) [415772]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [415772]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [415773]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [415773]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [415774]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [415774]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [415776]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [415779]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [415780]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [415780]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [423196]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [423196]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423197]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [423197]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423200]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [423201]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423202]
drivers/input/serio/i8042.c: f6 -> i8042 (parameter) [423202]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423205]
input: PS/2 Generic Mouse on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423206]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [423206]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423209]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423210]
drivers/input/serio/i8042.c: 3c -> i8042 (parameter) [423210]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423212]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423213]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [423213]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423216]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423216]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [423216]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423219]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423219]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [423219]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423222]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423222]
drivers/input/serio/i8042.c: ea -> i8042 (parameter) [423222]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423225]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [423226]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [423226]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [423228]

--FCuugMFkClbJLl1L--

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/nP6lFjQHpltE9KURAqgUAJwLBpCEGqWnMqLxwzOjUy53lHw50QCglbKC
vsKtWoZF9N9JpM1B/OLHJNQ=
=FDMc
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
