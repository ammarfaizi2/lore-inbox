Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310146AbSCGIMO>; Thu, 7 Mar 2002 03:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310139AbSCGIME>; Thu, 7 Mar 2002 03:12:04 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:60609 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S293553AbSCGILv>; Thu, 7 Mar 2002 03:11:51 -0500
Message-Id: <200203070811.g278BwL19069@lmail.actcom.co.il>
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] via82cxxx recording bug
Date: Thu, 7 Mar 2002 10:11:47 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_N3GLF3RRIM7VXLG01HMB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_N3GLF3RRIM7VXLG01HMB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This fixes a recording problem that I experienced
on an Asus CUV4X mainboard (via686a + cs4299 rev D).

Recording resulted in bad noise when using frags
smaller than a page size (either using default params
with low sample rate or explicit with
SNDCTL_DSP_SETFRAGMENT ioctl).

Some apps that use the sound card (eg, gnomemeeting)
were completely useless.

Patch is against 2.4.19-pre1.

Jeff, I'll appreciate if you could give it at least a
visual inspection - thanks.

-- Itai


--------------Boundary-00=_N3GLF3RRIM7VXLG01HMB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via82cxxx_audio.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="via82cxxx_audio.diff"

LS0tIGRyaXZlcnMvc291bmQvdmlhODJjeHh4X2F1ZGlvLmMub3JpZwlUaHUgTWFyICA3IDA5OjA3
OjMxIDIwMDIKKysrIGRyaXZlcnMvc291bmQvdmlhODJjeHh4X2F1ZGlvLmMJVGh1IE1hciAgNyAw
OTowNjo0NCAyMDAyCkBAIC0yMDUxLDcgKzIwNTEsNyBAQAogCXdoaWxlICgoY291bnQgPiAwKSAm
JiAoY2hhbi0+c2xvcF9sZW4gPCBjaGFuLT5mcmFnX3NpemUpKSB7CiAJCXNpemVfdCBzbG9wX2xl
ZnQgPSBjaGFuLT5mcmFnX3NpemUgLSBjaGFuLT5zbG9wX2xlbjsKIAkJdm9pZCAqYmFzZSA9IGNo
YW4tPnBndGJsW24gLyAoUEFHRV9TSVpFIC8gY2hhbi0+ZnJhZ19zaXplKV0uY3B1YWRkcjsKLQkJ
dW5zaWduZWQgb2ZzID0gbiAlIChQQUdFX1NJWkUgLyBjaGFuLT5mcmFnX3NpemUpOworCQl1bnNp
Z25lZCBvZnMgPSAobiAlIChQQUdFX1NJWkUgLyBjaGFuLT5mcmFnX3NpemUpKSAqIGNoYW4tPmZy
YWdfc2l6ZTsKIAogCQlzaXplID0gKGNvdW50IDwgc2xvcF9sZWZ0KSA/IGNvdW50IDogc2xvcF9s
ZWZ0OwogCQlpZiAoY29weV90b191c2VyICh1c2VyYnVmLAo=

--------------Boundary-00=_N3GLF3RRIM7VXLG01HMB--
