Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTEEIlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTEEIlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:41:05 -0400
Received: from pccn7.mppmu.mpg.de ([134.107.2.238]:33727 "EHLO
	pccn7.mppmu.mpg.de") by vger.kernel.org with ESMTP id S262100AbTEEIlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:41:03 -0400
Date: Mon, 5 May 2003 10:53:27 +0200 (CEST)
From: Peter Breitenlohner <peb@mppmu.mpg.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: linux-2.4.20 kernel bug (sound: ac97_codec.c prints garbage)
Message-ID: <Pine.LNX.4.55.0305051038460.4368@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1803957763-736455324-1052124807=:4368"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1803957763-736455324-1052124807=:4368
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan,

you might not exactly be the right person for this, but at least you are
(have been) associated with sound.

PROBLEM:

1. linux-2.4.20 kernel bug (sound: ac97_codec.c prints garbage)

2. A change in drivers/sound/ac97_codec.c introduced between 2.4.18 and
2.4.20 has the consequence that ac97_codec.c prints garbage to the syslog.

3. sound

4. 2.4.20

8. This ought to be fixed as per the attached patch (or equivalent).

Some comments:
1. the format for the first snprintf is broken ("%0x4X" instead of "%4X").
2. the function should return after the first snprintf.

Possibly all this has already been noticed. If not I would appreciate it that
could be fixed for the upcoming 2.4.21.

regards
Peter Breitenlohner <peb@mppmu.mpg.de>
--1803957763-736455324-1052124807=:4368
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.20-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55.0305051053270.4368@pcl321.mppmu.mpg.de>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.20-patch"

LS0tIGxpbnV4LTIuNC4yMC9kcml2ZXJzL3NvdW5kL2FjOTdfY29kZWMuYy5v
cmlnCTIwMDItMTEtMjkgMDA6NTM6MTQuMDAwMDAwMDAwICswMTAwDQorKysg
bGludXgtMi40LjIwL2RyaXZlcnMvc291bmQvYWM5N19jb2RlYy5jCTIwMDMt
MDUtMDMgMTc6NDM6MTQuMDAwMDAwMDAwICswMjAwDQpAQCAtNjY2LDExICs2
NjYsMTMgQEANCiBzdGF0aWMgY2hhciAqY29kZWNfaWQodTE2IGlkMSwgdTE2
IGlkMiwgY2hhciAqYnVmKQ0KIHsNCiAJaWYoaWQxJjB4ODA4MCkNCi0JCXNu
cHJpbnRmKGJ1ZiwgMTAsICIlMHg0WDolMHg0WCIsIGlkMSwgaWQyKTsNCi0J
YnVmWzBdID0gKGlkMSA+PiA4KTsNCi0JYnVmWzFdID0gKGlkMSAmIDB4RkYp
Ow0KLQlidWZbMl0gPSAoaWQyID4+IDgpOw0KLQlzbnByaW50ZihidWYrMywg
NywgIiVkIiwgaWQyJjB4RkYpOw0KKwkJc25wcmludGYoYnVmLCAxMCwgIiUw
NFg6JTA0WCIsIGlkMSwgaWQyKTsNCisJZWxzZSB7DQorCQlidWZbMF0gPSAo
aWQxID4+IDgpOw0KKwkJYnVmWzFdID0gKGlkMSAmIDB4RkYpOw0KKwkJYnVm
WzJdID0gKGlkMiA+PiA4KTsNCisJCXNucHJpbnRmKGJ1ZiszLCA3LCAiJWQi
LCBpZDImMHhGRik7DQorCX0NCiAJcmV0dXJuIGJ1ZjsNCiB9DQogIA0K

--1803957763-736455324-1052124807=:4368--
