Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130545AbQKGAYg>; Mon, 6 Nov 2000 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129236AbQKGAY0>; Mon, 6 Nov 2000 19:24:26 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:49592 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S130577AbQKGAYO>; Mon, 6 Nov 2000 19:24:14 -0500
Date: Tue, 7 Nov 2000 00:24:06 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Tomasz Motylewski <motyl@stan.chemie.unibas.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build
In-Reply-To: <Pine.LNX.4.21.0011070059120.24007-100000@crds.chemie.unibas.ch>
Message-ID: <Pine.LNX.4.21.0011070022440.2301-200000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1131172320-365402259-973556646=:2301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1131172320-365402259-973556646=:2301
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 7 Nov 2000, Tomasz Motylewski wrote:

> 2.2.18pre19:
> ide-probe.c:400: `rtc_lock' undeclared (first use this function)
> ide-probe.c:400: (Each undeclared identifier is reported only once
> ide-probe.c:400: for each function it appears in.)

See the attached patch.  Just declares it as an extern spinlock_t, as
per a boatload of other places in the kernel.

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

---1131172320-365402259-973556646=:2301
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rtc_lock.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0011070024060.2301@pc24.sr.bham.ac.uk>
Content-Description: 
Content-Disposition: attachment; filename="rtc_lock.diff"

LS0tIGxpbnV4L2RyaXZlcnMvYmxvY2svaWRlLXByb2JlLmMub3JpZwlTYXQg
Tm92ICA0IDA2OjMyOjQzIDIwMDANCisrKyBsaW51eC9kcml2ZXJzL2Jsb2Nr
L2lkZS1wcm9iZS5jCVNhdCBOb3YgIDQgMDY6MzI6NTIgMjAwMA0KQEAgLTQz
LDYgKzQzLDggQEANCiAjaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4NCiAjaW5j
bHVkZSA8YXNtL2lvLmg+DQogDQorZXh0ZXJuIHNwaW5sb2NrX3QgcnRjX2xv
Y2s7DQorDQogI2luY2x1ZGUgImlkZS5oIg0KIA0KIHN0YXRpYyBpbmxpbmUg
dm9pZCBkb19pZGVudGlmeSAoaWRlX2RyaXZlX3QgKmRyaXZlLCBieXRlIGNt
ZCkNCg==
---1131172320-365402259-973556646=:2301--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
