Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289350AbSA1T54>; Mon, 28 Jan 2002 14:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289374AbSA1T5p>; Mon, 28 Jan 2002 14:57:45 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:34951 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289362AbSA1T4E>;
	Mon, 28 Jan 2002 14:56:04 -0500
Date: Mon, 28 Jan 2002 14:56:04 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Steven Hassani <hassani@its.caltech.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <Pine.GSO.4.42.0201252339350.8662-100000@blinky>
Message-ID: <Pine.LNX.4.30.0201281452480.9637-200000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-74666095-2073819214-1012247764=:9637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---74666095-2073819214-1012247764=:9637
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Sat, 26 Jan 2002, Steven Hassani wrote:

> 	I'm running a compaq presario 700us: duron 950 mhz on a via mobo
> (vt8363/8365 etc).  When running kernel 2.4.17 with athlon optimizations,
> the box has kernel panics, segmentation faults, and other errors.
> When setting to K6 though, the box appears to be stable.  So does the fix
> included in pci-pc.c not work with my system?  Has anyone else been
> getting these errors after using this fix?  Thanks.
> Steve

The new pci-pc.c fix is not in kernel 2.4.17.  You can try the 2.4.18-pre
kernels, or you can try applying the patch youself to the 2.4.17 source
tree.

After you do that, one easy way to tell if the fix is being applied to your system is
to look at your dmesg output and see if something like "Trying to stomp on
VIA Northbridge bug..." is one of the early bootup messages.....


I am attaching the pci-pc.c patch to this email.  It may or may not help
you.  There are also other issues with Athlons/Durons and AGP, that kernel
developers are now working on.. so it could also be one of those issues.
:)

-Calin

---74666095-2073819214-1012247764=:9637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="via_northbridge_bug_stomper_new_2_4_17.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0201281456040.9637@rtlab.med.cornell.edu>
Content-Description: 
Content-Disposition: attachment; filename="via_northbridge_bug_stomper_new_2_4_17.patch"

ZGlmZiAtdSAtciB2YW5pbGxhL2FyY2gvaTM4Ni9rZXJuZWwvcGNpLXBjLmMg
cGF0Y2hlZC9hcmNoL2kzODYva2VybmVsL3BjaS1wYy5jDQotLS0gdmFuaWxs
YS9hcmNoL2kzODYva2VybmVsL3BjaS1wYy5jCUZyaSBEZWMgMjEgMTI6NDE6
NTMgMjAwMQ0KKysrIHBhdGNoZWQvYXJjaC9pMzg2L2tlcm5lbC9wY2ktcGMu
YwlTYXQgRGVjIDIyIDA4OjI0OjQ0IDIwMDENCkBAIC0xMTA5LDIyICsxMTA5
LDI5IEBADQogfQ0KIA0KIC8qDQotICogTm9ib2R5IHNlZW1zIHRvIGtub3cg
d2hhdCB0aGlzIGRvZXMuIERhbW4uDQorICogQWRkcmVzc2VzIGlzc3VlcyB3
aXRoIHByb2JsZW1zIGluIHRoZSBtZW1vcnkgd3JpdGUgcXVldWUgdGltZXIg
aW4NCisgKiBjZXJ0YWluIFZJQSBOb3J0aGJyaWRnZXMuICBUaGlzIGJ1Z2Zp
eCBpcyBwZXIgVklBJ3Mgc3BlY2lmaWNhdGlvbnMuDQogICoNCi0gKiBCdXQg
aXQgZG9lcyBzZWVtIHRvIGZpeCBzb21lIHVuc3BlY2lmaWVkIHByb2JsZW0N
Ci0gKiB3aXRoICdtb3ZudHEnIGNvcGllcyBvbiBBdGhsb25zLg0KLSAqDQot
ICogVklBIDgzNjMgY2hpcHNldDoNCi0gKiAgLSBiaXQgNyBhdCBvZmZzZXQg
MHg1NTogRGVidWcgKFJXKQ0KKyAqIFZJQSA4MzYzLDg2MjIsODM2MSBOb3J0
aGJyaWRnZXM6DQorICogIC0gYml0cyAgNSwgNiwgNyBhdCBvZmZzZXQgMHg1
NSBuZWVkIHRvIGJlIHR1cm5lZCBvZmYNCisgKiBWSUEgODM2NyAoS1QyNjZ4
KSBOb3J0aGJyaWRnZXM6DQorICogIC0gYml0cyAgNSwgNiwgNyBhdCBvZmZz
ZXQgMHg5NSBuZWVkIHRvIGJlIHR1cm5lZCBvZmYNCiAgKi8NCi1zdGF0aWMg
dm9pZCBfX2luaXQgcGNpX2ZpeHVwX3ZpYV9hdGhsb25fYnVnKHN0cnVjdCBw
Y2lfZGV2ICpkKQ0KK3N0YXRpYyB2b2lkIF9faW5pdCBwY2lfZml4dXBfdmlh
X25vcnRoYnJpZGdlX2J1ZyhzdHJ1Y3QgcGNpX2RldiAqZCkNCiB7DQogCXU4
IHY7DQotCXBjaV9yZWFkX2NvbmZpZ19ieXRlKGQsIDB4NTUsICZ2KTsNCi0J
aWYgKHYgJiAweDgwKSB7DQotCQlwcmludGsoIlRyeWluZyB0byBzdG9tcCBv
biBBdGhsb24gYnVnLi4uXG4iKTsNCi0JCXYgJj0gMHg3ZjsgLyogY2xlYXIg
Yml0IDU1LjcgKi8NCi0JCXBjaV93cml0ZV9jb25maWdfYnl0ZShkLCAweDU1
LCB2KTsNCisJaW50IHdoZXJlID0gMHg1NTsNCisNCisJaWYgKGQtPmRldmlj
ZSA9PSBQQ0lfREVWSUNFX0lEX1ZJQV84MzY3XzApIHsNCisJCXdoZXJlID0g
MHg5NTsgLyogdGhlIG1lbW9yeSB3cml0ZSBxdWV1ZSB0aW1lciByZWdpc3Rl
ciBpcyANCisJCQkJIGRpZmZlcmVudCBmb3IgdGhlIGt0MjY2eCdzOiAweDk1
IG5vdCAweDU1ICovDQorCX0NCisNCisJcGNpX3JlYWRfY29uZmlnX2J5dGUo
ZCwgd2hlcmUsICZ2KTsNCisJaWYgKHYgJiAweGUwKSB7DQorCQlwcmludGso
IlRyeWluZyB0byBzdG9tcCBvbiBWSUEgTm9ydGhicmlkZ2UgYnVnLi4uXG4i
KTsNCisJCXYgJj0gMHgxZjsgLyogY2xlYXIgYml0cyA1LCA2LCA3ICovDQor
CQlwY2lfd3JpdGVfY29uZmlnX2J5dGUoZCwgd2hlcmUsIHYpOw0KIAl9DQog
fQ0KIA0KQEAgLTExMzcsNyArMTE0NCwxMCBAQA0KIAl7IFBDSV9GSVhVUF9I
RUFERVIsCVBDSV9WRU5ET1JfSURfU0ksCVBDSV9ERVZJQ0VfSURfU0lfNTU5
NywJCXBjaV9maXh1cF9sYXRlbmN5IH0sDQogCXsgUENJX0ZJWFVQX0hFQURF
UiwJUENJX1ZFTkRPUl9JRF9TSSwJUENJX0RFVklDRV9JRF9TSV81NTk4LAkJ
cGNpX2ZpeHVwX2xhdGVuY3kgfSwNCiAgCXsgUENJX0ZJWFVQX0hFQURFUiwJ
UENJX1ZFTkRPUl9JRF9JTlRFTCwJUENJX0RFVklDRV9JRF9JTlRFTF84MjM3
MUFCXzMsCXBjaV9maXh1cF9waWl4NF9hY3BpIH0sDQotCXsgUENJX0ZJWFVQ
X0hFQURFUiwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklB
XzgzNjNfMCwJcGNpX2ZpeHVwX3ZpYV9hdGhsb25fYnVnIH0sDQorCXsgUENJ
X0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0Vf
SURfVklBXzgzNjNfMCwJcGNpX2ZpeHVwX3ZpYV9ub3J0aGJyaWRnZV9idWcg
fSwNCisJeyBQQ0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1ZJQSwJ
UENJX0RFVklDRV9JRF9WSUFfODYyMiwJICAgICAgICBwY2lfZml4dXBfdmlh
X25vcnRoYnJpZGdlX2J1ZyB9LA0KKwl7IFBDSV9GSVhVUF9IRUFERVIsCVBD
SV9WRU5ET1JfSURfVklBLAlQQ0lfREVWSUNFX0lEX1ZJQV84MzYxLAkgICAg
ICAgIHBjaV9maXh1cF92aWFfbm9ydGhicmlkZ2VfYnVnIH0sDQorCXsgUENJ
X0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0Vf
SURfVklBXzgzNjdfMCwJcGNpX2ZpeHVwX3ZpYV9ub3J0aGJyaWRnZV9idWcg
fSwNCiAJeyAwIH0NCiB9Ow0KIA0KZGlmZiAtdSAtciB2YW5pbGxhL2luY2x1
ZGUvbGludXgvcGNpX2lkcy5oIHBhdGNoZWQvaW5jbHVkZS9saW51eC9wY2lf
aWRzLmgNCi0tLSB2YW5pbGxhL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCUZy
aSBEZWMgMjEgMTI6NDI6MDMgMjAwMQ0KKysrIHBhdGNoZWQvaW5jbHVkZS9s
aW51eC9wY2lfaWRzLmgJU2F0IERlYyAyMiAwODoxNjo1NSAyMDAxDQpAQCAt
OTQ2LDcgKzk0Niw5IEBADQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX1ZJQV84
MjMzXzcJMHgzMDY1DQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX1ZJQV84MkM2
ODZfNgkweDMwNjgNCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzgyMzNf
MAkweDMwNzQNCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzg2MjIJCTB4
MzEwMg0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODIzM0NfMAkweDMx
MDkNCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVklBXzgzNjEJCTB4MzExMg0K
ICNkZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODYzM18wCTB4MzA5MQ0KICNk
ZWZpbmUgUENJX0RFVklDRV9JRF9WSUFfODM2N18wCTB4MzA5OQ0KICNkZWZp
bmUgUENJX0RFVklDRV9JRF9WSUFfODZDMTAwQQkweDYxMDANCg==
---74666095-2073819214-1012247764=:9637--
