Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131611AbRAJROK>; Wed, 10 Jan 2001 12:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132811AbRAJROA>; Wed, 10 Jan 2001 12:14:00 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:11773 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131611AbRAJRNo>; Wed, 10 Jan 2001 12:13:44 -0500
Date: Wed, 10 Jan 2001 17:13:37 +0000 (GMT)
From: Charles McLachlan <cim20@mrao.cam.ac.uk>
To: <linux-kernel@vger.kernel.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: [PATCH] 2.4.0 agpgart with i815 and external card.
In-Reply-To: <12302DEB1F3D@vcnet.vc.cvut.cz>
Message-ID: <Pine.SOL.4.30.0101101704070.9183-200000@mraosd.ra.phy.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-758783491-979146817=:9183"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-758783491-979146817=:9183
Content-Type: TEXT/PLAIN; charset=US-ASCII


My problem was that I didn't pay enough attention to the configuration
options. I opted for *both* the 440LX/BX/GX, 815, 840, 850 support
(CONFIG_AGP_INTEL) *and* I810/I815 (on-board) support (CONFIG_AGP_I810).

The latter was taking precedence over the former, and getting confused.

Petr Vandrovec has made the very good point that, to stop others from
getting as confused as me, agpgart should default to generic intel if it
can't find the onboard i815 video card.

It's a very small patch (one line really) which I present for your
consideration.

Thanks to Alan Cox and Petr for putting me right.

Charlie - Queens' College - Cavendish Astrophysics - 07866 636318

---559023410-758783491-979146817=:9183
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=agppatch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0101101713370.9183@mraosd.ra.phy.cam.ac.uk>
Content-Description: 
Content-Disposition: attachment; filename=agppatch

LS0tIGRyaXZlcnMvY2hhci9hZ3AvYWdwZ2FydF9iZV9vcmlnaW5hbC5jCVdl
ZCBKYW4gMTAgMTY6NTk6MzUgMjAwMQ0KKysrIGRyaXZlcnMvY2hhci9hZ3Av
YWdwZ2FydF9iZS5jCVdlZCBKYW4gMTAgMTc6MDA6NTQgMjAwMQ0KQEAgLTIz
NzMsOSArMjM3Myw5IEBADQogCQkJaWYgKGk4MTBfZGV2ID09IE5VTEwpIHsN
CiAJCQkJcHJpbnRrKEtFUk5fRVJSIFBGWCAiYWdwZ2FydDogRGV0ZWN0ZWQg
YW4gIg0KIAkJCQkgICAgICAgIkludGVsIGk4MTUsIGJ1dCBjb3VsZCBub3Qg
ZmluZCB0aGUiDQotCQkJCSAgICAgICAiIHNlY29uZGFyeSBkZXZpY2UuXG4i
KTsNCi0JCQkJYWdwX2JyaWRnZS50eXBlID0gTk9UX1NVUFBPUlRFRDsNCi0J
CQkJcmV0dXJuIC1FTk9ERVY7DQorCQkJCSAgICAgICAiIHNlY29uZGFyeSBk
ZXZpY2UuIEFzc3VtaW5nIGEgIg0KKwkJCQkgICAgICAgIm5vbi1pbnRlZ3Jh
dGVkIHZpZGVvIGNhcmQuXG4iKTsNCisJCQkJYnJlYWs7DQogCQkJfQ0KIAkJ
CXByaW50ayhLRVJOX0lORk8gUEZYICJhZ3BnYXJ0OiBEZXRlY3RlZCBhbiBJ
bnRlbCBpODE1ICINCiAJCQkgICAgICAgIkNoaXBzZXQuXG4iKTsNCg==
---559023410-758783491-979146817=:9183--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
