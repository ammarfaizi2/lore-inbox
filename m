Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTDVCpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTDVCpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:45:55 -0400
Received: from fronta-d.sezampro.yu ([194.106.188.51]:49414 "HELO
	fronta-d.sezampro.yu") by vger.kernel.org with SMTP id S262903AbTDVCpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:45:52 -0400
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@sezampro.yu>
To: linux-kernel@vger.kernel.org
Subject: [REPRODUCABLE BUGS] 2.5.68 Radeonfb screwed still... :(
Date: Tue, 22 Apr 2003 04:52:36 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_05Kp+Z+eCkhMZIK"
Message-Id: <200304220452.36541.toptan@sezampro.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_05Kp+Z+eCkhMZIK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

        I've encountered two reproducable bugs, and one feature which can a=
nd=20
can not=20
be called bug:

1. Radeon frame buffer driver still doesn't support mode change in kernel b=
oot=20
params. In 2.6.65 it is OK.

        append line from lilo.conf

    append =3D " hdd=3Dide-scsi video=3Dradeonfb:1024x768-24@100"

        No mether what is in video=3Dradeonfb:..., resolution is always set=
 to=20
80x30 with 60Hz refresh. Same thing happens when there is video=3Dradeon:...

2. Radeon frame buffer mode switching stll gives unexpected results. When=20
switching=20
from lower res to higher, switching is ok but you still have old chararcter=
=20
res. eg. 80x30. The text is located in upper left corner, and the right sid=
e=20
off the text area is filled with garbage. Bellow text area there is nothing.
       =20
3. Cursor disapears when moving with cursor keys. This is very annoying whe=
n=20
you are editing text for example. Making cursror being visible during first=
=20
half of the blink period should solve this, am I right, or there is somethi=
ng=20
else?

        My config is attached, gcc version is 2.95.3.
=2D-=20
Pozdrav,
Tanaskovi=C4=87 Toplica
--Boundary-00=_05Kp+Z+eCkhMZIK
Content-Type: application/x-bzip2;
  name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.bz2"

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

--Boundary-00=_05Kp+Z+eCkhMZIK--


