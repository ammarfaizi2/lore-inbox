Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUC2Rsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbUC2Rsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:48:43 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:20691 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263032AbUC2RpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:45:04 -0500
Subject: 2.6.5-mm4 & mm5 speedtouch adsl-start timeout
From: equi-NoX <equi-NoX@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oo4Gg5ms/gFNvmR0mYd1"
Message-Id: <1080582292.10546.31.camel@ender.WORKGROUP>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 19:44:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oo4Gg5ms/gFNvmR0mYd1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

To be connected on the Internet I usually type:

modem_run -k -f /etc/ppp/mgmt.o
br2684ctl -b -c 0 -a 0.8.35
adsl-start


I am used to have that syslog when I connect my computer threw rp-pppoe
(3.5), here on a linux-2.6.5-rc2-mm3

Mar 29 18:13:52 ender login(pam_unix)[3745]: session opened for user
root by (uid=3D0)
Mar 29 18:13:54 ender modem_run[3766]: modem_run version 1.2 started by
root uid 0
Mar 29 18:13:56 ender usb 1-1: bulk timeout on ep5in
Mar 29 18:13:56 ender usbfs: USBDEVFS_BULK failed dev 2 ep 0x85 len 512
ret -110
Mar 29 18:14:18 ender modem_run[3779]: [monitoring report] ADSL link
went up
Mar 29 18:14:30 ender modem_run[3766]: ADSL synchronization has been
obtained
Mar 29 18:14:30 ender modem_run[3766]: ADSL line is up (608 kbit/s down
| 160 kbit/s up)
Mar 29 18:14:32 ender divert: allocating divert_blk for nas0
Mar 29 18:14:32 ender bridge: Interface "nas0" created sucessfully
Mar 29 18:14:32 ender bridge: Communicating over ATM 0.8.35,
encapsulation: LLC
Mar 29 18:14:32 ender bridge: Interface configured
Mar 29 18:14:32 ender bridge: RFC 1483/2684 bridge daemon started
Mar 29 18:14:34 ender pppd[3818]: pppd 2.4.1 started by root, uid 0
Mar 29 18:14:34 ender divert: not allocating divert_blk for non-ethernet
device ppp0
Mar 29 18:14:34 ender pppd[3818]: Using interface ppp0
Mar 29 18:14:34 ender pppd[3818]: Connect: ppp0 <--> /dev/pts/0

Mar 29 18:14:34 ender pppoe[3819]: PADS: Service-Name: ''
Mar 29 18:14:34 ender pppoe[3819]: PPP session is 47712
Mar 29 18:14:37 ender pppd[3818]: Remote message: CHAP authentication
success, unit 1268
Mar 29 18:14:37 ender pppd[3818]: local  IP address 193.253.xxx.xxx
Mar 29 18:14:37 ender pppd[3818]: remote IP address 193.253.xxx.xxx



but with mm4 and mm5 patches of linux-2.6.5-rc2 I have a timeout on
adsl-start:

Mar 29 18:09:29 ender login(pam_unix)[3748]: session opened for user
root by (uid=3D0)
Mar 29 18:09:30 ender modem_run[3769]: modem_run version 1.2 started by
root uid 0
Mar 29 18:09:33 ender usb 1-1: bulk timeout on ep5in
Mar 29 18:09:33 ender usbfs: USBDEVFS_BULK failed dev 2 ep 0x85 len 512
ret -110
Mar 29 18:10:20 ender modem_run[3782]: [monitoring report] ADSL link
went up
Mar 29 18:10:36 ender modem_run[3769]: ADSL synchronization has been
obtained
Mar 29 18:10:36 ender modem_run[3769]: ADSL line is up (608 kbit/s down
| 160 kbit/s up)
Mar 29 18:10:38 ender divert: allocating divert_blk for nas0
Mar 29 18:10:38 ender bridge: Interface "nas0" created sucessfully
Mar 29 18:10:38 ender bridge: Communicating over ATM 0.8.35,
encapsulation: LLC
Mar 29 18:10:38 ender bridge: Interface configured
Mar 29 18:10:38 ender bridge: RFC 1483/2684 bridge daemon started
Mar 29 18:10:40 ender pppd[3821]: pppd 2.4.1 started by root, uid 0
Mar 29 18:10:40 ender divert: not allocating divert_blk for non-ethernet
device ppp0
Mar 29 18:10:40 ender pppd[3821]: Using interface ppp0
Mar 29 18:10:40 ender pppd[3821]: Connect: ppp0 <--> /dev/pts/0

Mar 29 18:11:11 ender pppd[3821]: LCP: timeout sending Config-Requests
Mar 29 18:11:11 ender pppd[3821]: Connection terminated.
Mar 29 18:11:11 ender divert: no divert_blk to free, ppp0 not ethernet
Mar 29 18:11:15 ender pppoe[3822]: Timeout waiting for PADS packets
Mar 29 18:11:15 ender pppd[3821]: Exit.



equi-NoX
--=20
hoping helping

--=-oo4Gg5ms/gFNvmR0mYd1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAaGCUrEI/NqtpJI4RAiAEAKCTm7jI6AGlrVCPh7DnihoQrZ3yLQCgvyY3
rKRHtcod3XQrFBiiwwIqNU4=
=Hg1f
-----END PGP SIGNATURE-----

--=-oo4Gg5ms/gFNvmR0mYd1--

