Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKCXLA>; Fri, 3 Nov 2000 18:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKCXKu>; Fri, 3 Nov 2000 18:10:50 -0500
Received: from ares.ssi.bg ([195.138.149.70]:24324 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129033AbQKCXKZ>;
	Fri, 3 Nov 2000 18:10:25 -0500
Date: Sat, 4 Nov 2000 01:09:42 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
Message-ID: <Pine.LNX.4.04.10011040055420.834-200000@u>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="214105322-1293188493-973300182=:834"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--214105322-1293188493-973300182=:834
Content-Type: TEXT/PLAIN; charset=US-ASCII


	Hello,

On Fri, 3 Nov 2000, Josue Emmanuel Amaro wrote:

> It would be great if it could be a kernel configuration time option.

	Something like the attached old patch for 2.2. It is very
optimistic in using 64MB as min value for TASK_UNMAPPED_BASE while
the real min is above 128MB (where malloc starts). May be needs tuning for
other archs. You still need to select good value for TASK_SIZE/PAGE_OFFSET
at compile time. I run the patch safely with
echo 195887104 > /proc/sys/kernel/task_unmapped_base


Regards

--
Julian Anastasov <ja@ssi.bg>

--214105322-1293188493-973300182=:834
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="unmapped-2214pre14-2.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.04.10011040109421.834@u>
Content-Description: /proc/sys/kernel/task_unmapped_base
Content-Disposition: attachment; filename="unmapped-2214pre14-2.diff"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvc3lzY3RsLmgub3JpZwlGcmkgRGVj
IDE3IDAwOjA0OjM2IDE5OTkNCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4L3N5
c2N0bC5oCUZyaSBEZWMgMTcgMDA6MjI6MjYgMTk5OQ0KQEAgLTEwNiw2ICsx
MDYsNyBAQA0KIAlLRVJOX1NZU1JRPTM4LAkJLyogaW50OiBTeXNyZXEgZW5h
YmxlICovDQogCUtFUk5fU0hNQUxMPTQxLAkJLyogaW50OiBtYXhpbXVtIHNp
emUgb2Ygc2hhcmVkIG1lbW9yeSAqLw0KIAlLRVJOX1NQQVJDX1NUT1BfQT00
NCwJLyogaW50OiBTcGFyYyBTdG9wLUEgZW5hYmxlICovDQorCUtFUk5fVEFT
S19VTk1BUFBFRF9CQVNFPTQ1LA0KIH07DQogDQogDQotLS0gbGludXgva2Vy
bmVsL3N5c2N0bC5jLm9yaWcJRnJpIERlYyAxNyAwMDowNDozNiAxOTk5DQor
KysgbGludXgva2VybmVsL3N5c2N0bC5jCUZyaSBEZWMgMTcgMDA6MjU6NTkg
MTk5OQ0KQEAgLTUxLDYgKzUxLDEyIEBADQogZXh0ZXJuIGludCBzaG1hbGxf
bWF4Ow0KICNlbmRpZg0KIA0KKyNpZiBkZWZpbmVkKENPTkZJR18yR0IpIHx8
IGRlZmluZWQoQ09ORklHXzNHQikgfHwgZGVmaW5lZChDT05GSUdfMUdCKQ0K
K2V4dGVybiBpbnQgbWluX3Rhc2tfdW5tYXBwZWRfYmFzZTsNCitleHRlcm4g
aW50IGN1cl90YXNrX3VubWFwcGVkX2Jhc2U7DQorZXh0ZXJuIGludCBtYXhf
dGFza191bm1hcHBlZF9iYXNlOw0KKyNlbmRpZg0KKw0KICNpZmRlZiBfX3Nw
YXJjX18NCiBleHRlcm4gY2hhciByZWJvb3RfY29tbWFuZCBbXTsNCiBleHRl
cm4gaW50IHN0b3BfYV9lbmFibGVkOw0KQEAgLTIyNiw2ICsyMzIsMTEgQEAN
CiAJe0tFUk5fU0hNQUxMLCAic2htYWxsIiwgJnNobWFsbCwgc2l6ZW9mIChp
bnQpLA0KIAkgMDY0NCwgTlVMTCwgJnByb2NfZG9pbnR2ZWNfbWlubWF4LCAm
c3lzY3RsX2ludHZlYywNCiAJIE5VTEwsICZ6ZXJvX3ZhbHVlLCAmc2htYWxs
X21heH0sDQorI2VuZGlmDQorI2lmIGRlZmluZWQoQ09ORklHXzJHQikgfHwg
ZGVmaW5lZChDT05GSUdfM0dCKSB8fCBkZWZpbmVkKENPTkZJR18xR0IpDQor
CXtLRVJOX1RBU0tfVU5NQVBQRURfQkFTRSwgInRhc2tfdW5tYXBwZWRfYmFz
ZSIsICZjdXJfdGFza191bm1hcHBlZF9iYXNlLCBzaXplb2YgKGludCksDQor
CTA2NDQsIE5VTEwsICZwcm9jX2RvaW50dmVjX21pbm1heCwgJnN5c2N0bF9p
bnR2ZWMsDQorCU5VTEwsICZtaW5fdGFza191bm1hcHBlZF9iYXNlLCAmbWF4
X3Rhc2tfdW5tYXBwZWRfYmFzZX0sDQogI2VuZGlmDQogI2lmZGVmIENPTkZJ
R19NQUdJQ19TWVNSUQ0KIAl7S0VSTl9TWVNSUSwgInN5c3JxIiwgJnN5c3Jx
X2VuYWJsZWQsIHNpemVvZiAoaW50KSwNCi0tLSBsaW51eC9tbS9tbWFwLmMu
b3JpZwlGcmkgRGVjIDE3IDAwOjA0OjM2IDE5OTkNCisrKyBsaW51eC9tbS9t
bWFwLmMJRnJpIERlYyAxNyAwMDoyODoxMSAxOTk5DQpAQCAtNDEsNiArNDEs
MTIgQEANCiANCiBpbnQgc3lzY3RsX292ZXJjb21taXRfbWVtb3J5Ow0KIA0K
KyNpZiBkZWZpbmVkKENPTkZJR18yR0IpIHx8IGRlZmluZWQoQ09ORklHXzNH
QikgfHwgZGVmaW5lZChDT05GSUdfMUdCKQ0KK2ludCBtaW5fdGFza191bm1h
cHBlZF9iYXNlID0gMHgwNDAwMDAwMDsNCitpbnQgY3VyX3Rhc2tfdW5tYXBw
ZWRfYmFzZSA9IFRBU0tfVU5NQVBQRURfQkFTRTsNCitpbnQgbWF4X3Rhc2tf
dW5tYXBwZWRfYmFzZSA9IDB4N0ZDMDAwMDA7DQorI2VuZGlmDQorDQogLyog
Q2hlY2sgdGhhdCBhIHByb2Nlc3MgaGFzIGVub3VnaCBtZW1vcnkgdG8gYWxs
b2NhdGUgYQ0KICAqIG5ldyB2aXJ0dWFsIG1hcHBpbmcuDQogICovDQpAQCAt
MzYyLDcgKzM2OCwxMSBAQA0KIAlpZiAobGVuID4gVEFTS19TSVpFKQ0KIAkJ
cmV0dXJuIDA7DQogCWlmICghYWRkcikNCisjaWYgZGVmaW5lZChDT05GSUdf
MkdCKSB8fCBkZWZpbmVkKENPTkZJR18zR0IpIHx8IGRlZmluZWQoQ09ORklH
XzFHQikNCisJCWFkZHIgPSAodW5zaWduZWQgbG9uZykgY3VyX3Rhc2tfdW5t
YXBwZWRfYmFzZTsNCisjZWxzZQ0KIAkJYWRkciA9IFRBU0tfVU5NQVBQRURf
QkFTRTsNCisjZW5kaWYNCiAJYWRkciA9IFBBR0VfQUxJR04oYWRkcik7DQog
DQogCWZvciAodm1tID0gZmluZF92bWEoY3VycmVudC0+bW0sIGFkZHIpOyA7
IHZtbSA9IHZtbS0+dm1fbmV4dCkgew0K
--214105322-1293188493-973300182=:834--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
