Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAOLwQ>; Mon, 15 Jan 2001 06:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131159AbRAOLwH>; Mon, 15 Jan 2001 06:52:07 -0500
Received: from chiara.elte.hu ([157.181.150.200]:28432 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131042AbRAOLvx>;
	Mon, 15 Jan 2001 06:51:53 -0500
Date: Mon, 15 Jan 2001 12:51:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux RAID Mailing List <linux-raid@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] fixes for RAID1/RAID5 hot-add/hot-remove, 2.4.0-ac9
Message-ID: <Pine.LNX.4.30.0101151248200.1398-200000@e2>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-1901406066-979559483=:1398"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-1901406066-979559483=:1398
Content-Type: TEXT/PLAIN; charset=US-ASCII


- the attached patch (against -ac9) fixes a bug in the RAID1 and RAID4/5
  code that made raidhotremove fail under certain (rare) circumstances.
  Please apply.

	Ingo

--655616-1901406066-979559483=:1398
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="raidfix-2.4.0-ac9-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0101151251230.1398@e2>
Content-Description: 
Content-Disposition: attachment; filename="raidfix-2.4.0-ac9-A0"

LS0tIGxpbnV4L2RyaXZlcnMvbWQvcmFpZDEuYy5vcmlnCU1vbiBEZWMgMTEg
MjI6MTk6MzUgMjAwMA0KKysrIGxpbnV4L2RyaXZlcnMvbWQvcmFpZDEuYwlN
b24gSmFuIDE1IDE0OjQ1OjM1IDIwMDENCkBAIC04MzIsNiArODMyLDcgQEAN
CiAJc3RydWN0IG1pcnJvcl9pbmZvICp0bXAsICpzZGlzaywgKmZkaXNrLCAq
cmRpc2ssICphZGlzazsNCiAJbWRwX3N1cGVyX3QgKnNiID0gbWRkZXYtPnNi
Ow0KIAltZHBfZGlza190ICpmYWlsZWRfZGVzYywgKnNwYXJlX2Rlc2MsICph
ZGRlZF9kZXNjOw0KKwltZGtfcmRldl90ICpzcGFyZV9yZGV2LCAqZmFpbGVk
X3JkZXY7DQogDQogCXByaW50X3JhaWQxX2NvbmYoY29uZik7DQogCW1kX3Nw
aW5fbG9ja19pcnEoJmNvbmYtPmRldmljZV9sb2NrKTsNCkBAIC05ODksNiAr
OTkwLDEwIEBADQogCQkvKg0KIAkJICogZG8gdGhlIHN3aXRjaCBmaW5hbGx5
DQogCQkgKi8NCisJCXNwYXJlX3JkZXYgPSBmaW5kX3JkZXZfbnIobWRkZXYs
IHNwYXJlX2Rlc2MtPm51bWJlcik7DQorCQlmYWlsZWRfcmRldiA9IGZpbmRf
cmRldl9ucihtZGRldiwgZmFpbGVkX2Rlc2MtPm51bWJlcik7DQorCQl4Y2hn
X3ZhbHVlcyhzcGFyZV9yZGV2LT5kZXNjX25yLCBmYWlsZWRfcmRldi0+ZGVz
Y19ucik7DQorDQogCQl4Y2hnX3ZhbHVlcygqc3BhcmVfZGVzYywgKmZhaWxl
ZF9kZXNjKTsNCiAJCXhjaGdfdmFsdWVzKCpmZGlzaywgKnNkaXNrKTsNCiAN
Ci0tLSBsaW51eC9kcml2ZXJzL21kL3JhaWQ1LmMub3JpZwlNb24gSmFuIDE1
IDE0OjQ1OjUwIDIwMDENCisrKyBsaW51eC9kcml2ZXJzL21kL3JhaWQ1LmMJ
TW9uIEphbiAxNSAxNDo0NjowMSAyMDAxDQpAQCAtMTcwNyw2ICsxNzA3LDcg
QEANCiAJc3RydWN0IGRpc2tfaW5mbyAqdG1wLCAqc2Rpc2ssICpmZGlzaywg
KnJkaXNrLCAqYWRpc2s7DQogCW1kcF9zdXBlcl90ICpzYiA9IG1kZGV2LT5z
YjsNCiAJbWRwX2Rpc2tfdCAqZmFpbGVkX2Rlc2MsICpzcGFyZV9kZXNjLCAq
YWRkZWRfZGVzYzsNCisJbWRrX3JkZXZfdCAqc3BhcmVfcmRldiwgKmZhaWxl
ZF9yZGV2Ow0KIA0KIAlwcmludF9yYWlkNV9jb25mKGNvbmYpOw0KIAltZF9z
cGluX2xvY2tfaXJxKCZjb25mLT5kZXZpY2VfbG9jayk7DQpAQCAtMTg3OCw2
ICsxODc5LDEwIEBADQogCQkvKg0KIAkJICogZG8gdGhlIHN3aXRjaCBmaW5h
bGx5DQogCQkgKi8NCisJCXNwYXJlX3JkZXYgPSBmaW5kX3JkZXZfbnIobWRk
ZXYsIHNwYXJlX2Rlc2MtPm51bWJlcik7DQorCQlmYWlsZWRfcmRldiA9IGZp
bmRfcmRldl9ucihtZGRldiwgZmFpbGVkX2Rlc2MtPm51bWJlcik7DQorCQl4
Y2hnX3ZhbHVlcyhzcGFyZV9yZGV2LT5kZXNjX25yLCBmYWlsZWRfcmRldi0+
ZGVzY19ucik7DQorDQogCQl4Y2hnX3ZhbHVlcygqc3BhcmVfZGVzYywgKmZh
aWxlZF9kZXNjKTsNCiAJCXhjaGdfdmFsdWVzKCpmZGlzaywgKnNkaXNrKTsN
CiANCg==
--655616-1901406066-979559483=:1398--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
