Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTIEImi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbTIEImh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:42:37 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:56836 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S262050AbTIEImA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:42:00 -0400
Date: Fri, 5 Sep 2003 10:41:57 +0200
From: Frederic Gobry <frederic.gobry@smartdata.ch>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 does not detect my touchpad
Message-ID: <20030905084157.GA13745@rhin>
References: <20030904135737.GA7956@rhin> <20030904165405.A2969@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20030904165405.A2969@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> We conclude that there is no AUX port.
> No PS/2 mouse that can be used.

Does it mean that the hardware is somehow lying or is the check too
strong ?

> You can to put #if 0 ... #endif around the four
> if statements following the comment
>=20
> /*
>  * Bit assignment test - filters out PS/2 i8042's in AT mode
>  */
>=20
> in i8042.c (since also your mouse was filtered away).

I've done that. Enclosed are some logs from my tests. In short:

     - with no psmouse_noext option, the synaptics touchpad is
       detected, but there a lots of synchro lost error messages.

     - with psmouse_noext set, the mouse is erratic when using XFree
       (not with the synaptics specific driver)

Fr=E9d=E9ric

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=kern-synaptics

--------------------------------------------------
At boot:
--------------------------------------------------

Sep  5 10:27:40 pium kernel: mice: PS/2 mouse device common for all mice
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [1]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [1]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 0f <- i8042 (return) [1]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: a9 <- i8042 (return) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 5b <- i8042 (return) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: a5 <- i8042 (return) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [3]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [3]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [5]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [8]
Sep  5 10:27:40 pium kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [9]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [14]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [14]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [14]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [14]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [15]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [16]
Sep  5 10:27:40 pium kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [20]
Sep  5 10:27:40 pium kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep  5 10:27:40 pium kernel: serio: i8042 KBD port at 0x60,0x64 irq 1



--------------------------------------------------
When modprobing psmouse (no option):
--------------------------------------------------


Sep  5 10:28:31 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [68938]
Sep  5 10:28:31 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [68953]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [149818]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [149818]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149819]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [149819]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149822]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [149823]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149824]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: f6 -> i8042 (parameter) [149824]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149827]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149827]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [149827]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149830]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149830]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [149830]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149833]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149834]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [149834]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149836]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149837]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [149837]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149839]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149839]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [149839]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149843]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149843]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [149843]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149846]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149846]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [149846]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149848]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149849]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [149849]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149852]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149853]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [149853]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149855]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, aux, 12) [149856]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [149857]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, aux, 12) [149860]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [149861]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: ff -> i8042 (parameter) [149861]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [149863]
Sep  5 10:29:52 pium kernel: synaptics reset failed
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150157]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: ff -> i8042 (parameter) [150157]
Sep  5 10:29:52 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150160]
Sep  5 10:29:53 pium kernel: synaptics reset failed
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150454]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: ff -> i8042 (parameter) [150454]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150457]
Sep  5 10:29:53 pium kernel: synaptics reset failed
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150747]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [150747]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150750]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150751]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150751]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150753]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150754]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150754]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150757]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150758]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150758]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150760]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150760]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150760]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150763]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150763]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150763]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150766]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150767]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150767]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150769]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150770]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150770]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150772]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150773]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150773]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150776]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150776]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [150776]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150779]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, aux, 12) [150780]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [150781]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, aux, 12) [150784]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150784]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [150784]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150787]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150787]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150787]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150791]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150791]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150791]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150793]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150794]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150794]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150796]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150797]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150797]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150800]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150800]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150800]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150803]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150803]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150803]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150806]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150806]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150806]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150809]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150810]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [150810]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150812]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150813]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [150813]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150815]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 0f <- i8042 (interrupt, aux, 12) [150818]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 42 <- i8042 (interrupt, aux, 12) [150819]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: a1 <- i8042 (interrupt, aux, 12) [150822]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150822]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [150822]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150825]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150825]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150825]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150828]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150829]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150829]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150832]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150833]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150833]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150835]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150836]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150836]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150839]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150839]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150839]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150842]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150842]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150842]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150845]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150845]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150845]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150848]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150849]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [150849]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150851]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150852]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [150852]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150854]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux, 12) [150857]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [150858]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 1b <- i8042 (interrupt, aux, 12) [150861]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150861]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [150861]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150864]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150864]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150864]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150867]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150868]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [150868]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150870]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150871]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150871]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150873]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150874]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [150874]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150877]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150877]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150877]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150880]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150880]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 01 -> i8042 (parameter) [150880]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150882]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150883]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150883]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150886]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150887]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 01 -> i8042 (parameter) [150887]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150890]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150891]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [150891]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150893]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150893]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 14 -> i8042 (parameter) [150893]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150897]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150897]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [150897]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150900]
Sep  5 10:29:53 pium kernel: Synaptics Touchpad, model: 1
Sep  5 10:29:53 pium kernel:  Firware: 4.6
Sep  5 10:29:53 pium kernel:  Sensor: 15
Sep  5 10:29:53 pium kernel:  new absolute packet format
Sep  5 10:29:53 pium kernel:  Touchpad has extended capability bits
Sep  5 10:29:53 pium kernel:  -> four buttons
Sep  5 10:29:53 pium kernel:  -> multifinger detection
Sep  5 10:29:53 pium kernel:  -> palm detection
Sep  5 10:29:53 pium kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150905]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [150905]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150908]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150908]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [150908]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150911]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150912]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [150912]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150914]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150915]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [150915]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150917]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150917]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [150917]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150921]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150921]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [150921]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150924]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150924]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [150924]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150926]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150927]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: ea -> i8042 (parameter) [150927]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150930]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [150931]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [150931]
Sep  5 10:29:53 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [150933]


--------------------------------------------------
When touching the touchpad:
--------------------------------------------------


Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167149]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, aux, 12) [167150]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 0a <- i8042 (interrupt, aux, 12) [167153]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: dc <- i8042 (interrupt, aux, 12) [167154]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: df <- i8042 (interrupt, aux, 12) [167157]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 90 <- i8042 (interrupt, aux, 12) [167158]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167162]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167163]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 23 <- i8042 (interrupt, aux, 12) [167166]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167167]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux, 12) [167169]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b4 <- i8042 (interrupt, aux, 12) [167171]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167176]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167177]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 25 <- i8042 (interrupt, aux, 12) [167179]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167181]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, aux, 12) [167183]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b3 <- i8042 (interrupt, aux, 12) [167185]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167190]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167191]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 29 <- i8042 (interrupt, aux, 12) [167193]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167195]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 0d <- i8042 (interrupt, aux, 12) [167197]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b5 <- i8042 (interrupt, aux, 12) [167198]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167205]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167206]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 2b <- i8042 (interrupt, aux, 12) [167207]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167210]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 0b <- i8042 (interrupt, aux, 12) [167211]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b8 <- i8042 (interrupt, aux, 12) [167212]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167217]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167220]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 2c <- i8042 (interrupt, aux, 12) [167221]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167222]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux, 12) [167225]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b6 <- i8042 (interrupt, aux, 12) [167226]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167231]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167234]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 2e <- i8042 (interrupt, aux, 12) [167235]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167236]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 05 <- i8042 (interrupt, aux, 12) [167239]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, aux, 12) [167240]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167244]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167245]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 30 <- i8042 (interrupt, aux, 12) [167248]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167249]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 0c <- i8042 (interrupt, aux, 12) [167251]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: a8 <- i8042 (interrupt, aux, 12) [167253]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167258]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167260]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, aux, 12) [167262]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167264]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 0f <- i8042 (interrupt, aux, 12) [167265]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 99 <- i8042 (interrupt, aux, 12) [167268]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167272]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167273]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, aux, 12) [167275]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167278]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 0c <- i8042 (interrupt, aux, 12) [167279]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 84 <- i8042 (interrupt, aux, 12) [167282]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167286]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167288]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, aux, 12) [167289]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167292]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 19 <- i8042 (interrupt, aux, 12) [167293]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 69 <- i8042 (interrupt, aux, 12) [167294]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167299]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167302]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 33 <- i8042 (interrupt, aux, 12) [167303]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167306]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 29 <- i8042 (interrupt, aux, 12) [167307]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 4f <- i8042 (interrupt, aux, 12) [167308]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167313]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167316]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 33 <- i8042 (interrupt, aux, 12) [167317]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167318]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 23 <- i8042 (interrupt, aux, 12) [167321]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, aux, 12) [167322]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167326]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, aux, 12) [167327]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 33 <- i8042 (interrupt, aux, 12) [167330]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167331]
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 2b <- i8042 (interrupt, aux, 12) [167332]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:09 pium kernel: drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, aux, 12) [167335]
Sep  5 10:30:09 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167340]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux, 12, timeout) [167343]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, aux, 12) [167346]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 34 <- i8042 (interrupt, aux, 12) [167347]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167350]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 35 <- i8042 (interrupt, aux, 12) [167351]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: ed <- i8042 (interrupt, aux, 12) [167354]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167355]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, aux, 12) [167356]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 34 <- i8042 (interrupt, aux, 12) [167359]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167360]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 3b <- i8042 (interrupt, aux, 12) [167362]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: c3 <- i8042 (interrupt, aux, 12) [167364]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167368]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, aux, 12) [167370]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 33 <- i8042 (interrupt, aux, 12) [167371]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167374]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux, 12) [167375]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 97 <- i8042 (interrupt, aux, 12) [167378]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167383]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, aux, 12) [167384]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, aux, 12) [167385]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167388]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 5a <- i8042 (interrupt, aux, 12) [167389]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 6f <- i8042 (interrupt, aux, 12) [167392]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167395]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, aux, 12) [167397]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 24 <- i8042 (interrupt, aux, 12) [167399]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167400]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 6e <- i8042 (interrupt, aux, 12) [167403]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 4c <- i8042 (interrupt, aux, 12) [167404]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, aux, 12) [167408]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, aux, 12) [167409]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux, 12) [167412]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: d8 <- i8042 (interrupt, aux, 12) [167413]
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, aux, 12) [167414]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 4th byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: f8 <- i8042 (interrupt, aux, 12) [167417]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 88 <- i8042 (interrupt, aux, 12) [167421]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [167422]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [167424]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte
Sep  5 10:30:10 pium kernel: drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, aux, 12) [167426]
Sep  5 10:30:10 pium kernel: Synaptics driver lost sync at 1st byte


--------------------------------------------------
At rmmod:
--------------------------------------------------


Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [191604]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [191604]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [191604]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [191604]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [191605]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [191605]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [191607]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [191610]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [191610]
Sep  5 10:30:34 pium kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [191610]



--------------------------------------------------
At modprobe psmouse with psmouse_noext=1
--------------------------------------------------


Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [441044]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [441044]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441044]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [441044]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441046]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [441049]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441049]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: f6 -> i8042 (parameter) [441049]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441052]
Sep  5 10:34:42 pium kernel: input: PS/2 Generic Mouse on isa0060/serio1
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441052]
Sep  5 10:34:42 pium kernel: drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [441052]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441055]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441055]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [441055]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441058]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441058]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [441058]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441060]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441060]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [441060]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441063]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441063]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [441063]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441065]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441065]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [441065]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441067]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441067]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [441067]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441070]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441070]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: ea -> i8042 (parameter) [441070]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441072]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [441072]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [441072]
Sep  5 10:34:43 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [441074]


--------------------------------------------------
When touching the touchpad:
--------------------------------------------------


Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [541964]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12) [541965]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, aux, 12) [541967]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [541977]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux, 12) [541980]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 05 <- i8042 (interrupt, aux, 12) [541981]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [541990]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fd <- i8042 (interrupt, aux, 12) [541991]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, aux, 12) [541994]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [542004]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fb <- i8042 (interrupt, aux, 12) [542007]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux, 12, timeout) [542010]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 09 <- i8042 (interrupt, aux, 12) [542013]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [542018]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fb <- i8042 (interrupt, aux, 12) [542019]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 0c <- i8042 (interrupt, aux, 12) [542022]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [542031]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [542033]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 0d <- i8042 (interrupt, aux, 12) [542034]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [542046]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fb <- i8042 (interrupt, aux, 12) [542047]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 0d <- i8042 (interrupt, aux, 12) [542048]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [542058]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12) [542061]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 0b <- i8042 (interrupt, aux, 12) [542062]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [542072]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12) [542075]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux, 12) [542076]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux, 12) [542086]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [542087]
Sep  5 10:36:23 pium kernel: drivers/input/serio/i8042.c: 04 <- i8042 (interrupt, aux, 12) [542090]

--ReaqsoxgOBHFXBhH--

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/WExVFjQHpltE9KURAnaVAKCq9waXZUnGse61bx2ZSmkkyz1VAACeJqlA
pJonY6jl1FItNW2unT84FwE=
=rUZ2
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
