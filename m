Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTAFFso>; Mon, 6 Jan 2003 00:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTAFFso>; Mon, 6 Jan 2003 00:48:44 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:61315 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S266161AbTAFFsm>;
	Mon, 6 Jan 2003 00:48:42 -0500
Date: Mon, 6 Jan 2003 05:57:20 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: dummy ethernet driver
Message-ID: <Pine.LNX.4.44.0301060553260.24333-200000@skynet>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-913833367-311338359-1041832640=:24333"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---913833367-311338359-1041832640=:24333
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,
 I have a VAX simulator running on my PC which uses pcap to send/recv
packets, however these packets are never seen on the local machine when
using a real ethernet device (everyone else on the network sees them), now
I only really want the local machine to see them not the network so I
decided I might get away with using loopback, however the simulator
configures its own IP and loopback isn't useful for this as the sim starts
arping and we don't do any arp on loopback.

so I turned to the dummy device but it isn't really a dummy Ethernet
device but rather a useless one :-), so I patched the dummy so it had an
address (hardcoded) is broadcast and loops back packets to itself...

the patch is attached.. is there any reason why the dummy device doesn't
want to do this stuff? I'm just submitting the patch as a request for
comments on why this isn't done anyway in the dummy?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


---913833367-311338359-1041832640=:24333
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=dummy_diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0301060557200.24333@skynet>
Content-Description: 
Content-Disposition: attachment; filename=dummy_diff

LS0tIC91c3Ivc3JjL2xpbnV4L2RyaXZlcnMvbmV0L2R1bW15LmMJMjAwMS0x
MC0wMSAwNToyNjowNi4wMDAwMDAwMDAgKzEwMDANCisrKyAuL2R1bW15LmMJ
MjAwMy0wMS0wNiAxNzowNjo0NC4wMDAwMDAwMDAgKzExMDANCkBAIC0zNSw2
ICszNSw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNs
dWRlIDxsaW51eC9uZXRkZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvaW5p
dC5oPg0KKyNpbmNsdWRlIDxsaW51eC9ldGhlcmRldmljZS5oPg0KIA0KIHN0
YXRpYyBpbnQgZHVtbXlfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KTsNCiBzdGF0aWMgc3RydWN0IG5ldF9kZXZp
Y2Vfc3RhdHMgKmR1bW15X2dldF9zdGF0cyhzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2KTsNCkBAIC01Myw2ICs1NCw3IEBADQogDQogc3RhdGljIGludCBfX2lu
aXQgZHVtbXlfaW5pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIHsNCisJ
dW5zaWduZWQgY2hhciBteWFkZHJbXT0iMTIzNDU2IjsNCiAJLyogSW5pdGlh
bGl6ZSB0aGUgZGV2aWNlIHN0cnVjdHVyZS4gKi8NCiANCiAJZGV2LT5wcml2
ID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IG5ldF9kZXZpY2Vfc3RhdHMpLCBH
RlBfS0VSTkVMKTsNCkBAIC02MCw2ICs2Miw3IEBADQogCQlyZXR1cm4gLUVO
T01FTTsNCiAJbWVtc2V0KGRldi0+cHJpdiwgMCwgc2l6ZW9mKHN0cnVjdCBu
ZXRfZGV2aWNlX3N0YXRzKSk7DQogDQorCW1lbWNweShkZXYtPmRldl9hZGRy
LCBteWFkZHIsIDYpOw0KIAlkZXYtPmdldF9zdGF0cyA9IGR1bW15X2dldF9z
dGF0czsNCiAJZGV2LT5oYXJkX3N0YXJ0X3htaXQgPSBkdW1teV94bWl0Ow0K
IAlkZXYtPnNldF9tdWx0aWNhc3RfbGlzdCA9IHNldF9tdWx0aWNhc3RfbGlz
dDsNCkBAIC03MCw3ICs3Myw4IEBADQogCS8qIEZpbGwgaW4gZGV2aWNlIHN0
cnVjdHVyZSB3aXRoIGV0aGVybmV0LWdlbmVyaWMgdmFsdWVzLiAqLw0KIAll
dGhlcl9zZXR1cChkZXYpOw0KIAlkZXYtPnR4X3F1ZXVlX2xlbiA9IDA7DQot
CWRldi0+ZmxhZ3MgfD0gSUZGX05PQVJQOw0KKy8qCWRldi0+ZmxhZ3MgfD0g
SUZGX05PQVJQOyAqLw0KKwlkZXYtPmZsYWdzIHw9IElGRl9CUk9BRENBU1Q7
DQogCWRldi0+ZmxhZ3MgJj0gfklGRl9NVUxUSUNBU1Q7DQogDQogCXJldHVy
biAwOw0KQEAgLTgyLDggKzg2LDI4IEBADQogDQogCXN0YXRzLT50eF9wYWNr
ZXRzKys7DQogCXN0YXRzLT50eF9ieXRlcys9c2tiLT5sZW47DQorCQ0KKwlp
ZihhdG9taWNfcmVhZCgmc2tiLT51c2VycykgIT0gMSkNCisJICB7DQorCSAg
ICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiMj1za2I7DQorCSAgICBza2I9c2tiX2Ns
b25lKHNrYiwgR0ZQX0FUT01JQyk7ICAgICAgICAgLyogQ2xvbmUgdGhlIGJ1
ZmZlciAqLw0KKwkgICAgaWYoc2tiPT1OVUxMKSB7DQorCSAgICAgIGRldl9r
ZnJlZV9za2Ioc2tiMik7DQorCSAgICAgIHJldHVybiAwOw0KKwkgICAgfQ0K
KwkgICAgZGV2X2tmcmVlX3NrYihza2IyKTsNCisJICB9DQorICAgICAgICBl
bHNlDQorCSAgc2tiX29ycGhhbihza2IpOw0KKw0KKwlza2ItPnByb3RvY29s
PWV0aF90eXBlX3RyYW5zKHNrYixkZXYpOw0KKyAgICAgICAgc2tiLT5kZXY9
ZGV2Ow0KKw0KKyAgICAgICAgc2tiLT5pcF9zdW1tZWQgPSBDSEVDS1NVTV9V
Tk5FQ0VTU0FSWTsNCisJZGV2LT5sYXN0X3J4ID0gamlmZmllczsNCisNCisJ
bmV0aWZfcngoc2tiKTsNCiANCi0JZGV2X2tmcmVlX3NrYihza2IpOw0KIAly
ZXR1cm4gMDsNCiB9DQogDQo=
---913833367-311338359-1041832640=:24333--
