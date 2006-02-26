Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWBZPM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWBZPM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 10:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWBZPM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 10:12:27 -0500
Received: from tag.witbe.net ([81.88.96.48]:37257 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1751218AbWBZPM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 10:12:26 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <linux.nics@intel.com>, <cramerj@intel.com>, <john.ronciak@intel.com>,
       <Ganesh.Venkatesan@intel.com>
Subject: Re: [2.4.32 - 2.6.15.4] e1000 - Fix mii interface
Date: Sun, 26 Feb 2006 16:12:48 +0100
Organization: Witbe.net
Message-ID: <01e101c63ae7$1b417990$2001a8c0@cortex>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01E2_01C63AEF.7D05E190"
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <9a8748490602260700s2e82a623mcf2d778aa109bb00@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcY65VJXq8Vx2DnqQNa50lfVlM/bLgAAWklg
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01E2_01C63AEF.7D05E190
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hello,

> Ok, great, I was just wondering since I would have made one if you had
> no plans to do so.

Well, I was just waiting to make sure it was interesting for someone ;)

Here is it, verified with tab and not spaces... but attached as my mailer
is likely to cripple anything I try to inline...

Signed-off-by: Paul Rolland <rol@as2917.net>

Cheers,
Paul

------=_NextPart_000_01E2_01C63AEF.7D05E190
Content-Type: application/octet-stream;
	name="e1000.patch-2.6.15.4"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="e1000.patch-2.6.15.4"

diff -urN linux-2.6.15.4.orig/drivers/net/e1000/e1000_main.c =
linux-2.6.15.4/drivers/net/e1000/e1000_main.c=0A=
--- linux-2.6.15.4.orig/drivers/net/e1000/e1000_main.c	Fri Feb 10 =
07:22:48 2006=0A=
+++ linux-2.6.15.4/drivers/net/e1000/e1000_main.c	Sun Feb 26 15:04:40 =
2006=0A=
@@ -4153,29 +4153,29 @@=0A=
 =0A=
 	/* Fiber NICs only allow 1000 gbps Full duplex */=0A=
 	if((adapter->hw.media_type =3D=3D e1000_media_type_fiber) &&=0A=
-		spddplx !=3D (SPEED_1000 + DUPLEX_FULL)) {=0A=
+		spddplx !=3D (SPEED_1000 + FULL_DUPLEX)) {=0A=
 		DPRINTK(PROBE, ERR, "Unsupported Speed/Duplex configuration\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
 	switch(spddplx) {=0A=
-	case SPEED_10 + DUPLEX_HALF:=0A=
+	case SPEED_10 + HALF_DUPLEX:=0A=
 		adapter->hw.forced_speed_duplex =3D e1000_10_half;=0A=
 		break;=0A=
-	case SPEED_10 + DUPLEX_FULL:=0A=
+	case SPEED_10 + FULL_DUPLEX:=0A=
 		adapter->hw.forced_speed_duplex =3D e1000_10_full;=0A=
 		break;=0A=
-	case SPEED_100 + DUPLEX_HALF:=0A=
+	case SPEED_100 + HALF_DUPLEX:=0A=
 		adapter->hw.forced_speed_duplex =3D e1000_100_half;=0A=
 		break;=0A=
-	case SPEED_100 + DUPLEX_FULL:=0A=
+	case SPEED_100 + FULL_DUPLEX:=0A=
 		adapter->hw.forced_speed_duplex =3D e1000_100_full;=0A=
 		break;=0A=
-	case SPEED_1000 + DUPLEX_FULL:=0A=
+	case SPEED_1000 + FULL_DUPLEX:=0A=
 		adapter->hw.autoneg =3D 1;=0A=
 		adapter->hw.autoneg_advertised =3D ADVERTISE_1000_FULL;=0A=
 		break;=0A=
-	case SPEED_1000 + DUPLEX_HALF: /* not supported */=0A=
+	case SPEED_1000 + HALF_DUPLEX: /* not supported */=0A=
 	default:=0A=
 		DPRINTK(PROBE, ERR, "Unsupported Speed/Duplex configuration\n");=0A=
 		return -EINVAL;=0A=

------=_NextPart_000_01E2_01C63AEF.7D05E190--

