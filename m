Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSAVRVp>; Tue, 22 Jan 2002 12:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288256AbSAVRVg>; Tue, 22 Jan 2002 12:21:36 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:31632 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S288153AbSAVRVT>; Tue, 22 Jan 2002 12:21:19 -0500
Date: Tue, 22 Jan 2002 18:21:18 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [right one][patch] amd athlon cooling on kt266/266a chipset 
Message-ID: <Pine.LNX.4.40.0201221817410.11025-200000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-947385803-1046103454-1011720078=:11025"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---947385803-1046103454-1011720078=:11025
Content-Type: TEXT/PLAIN; charset=US-ASCII

in the first mail, i forget to append the patch ... this one is the right
mail to look at ... (sorry)


hi there!

a few month ago someone has posted a patch for enabling the disconneect
on STPGND detect function in the kt133/kt133a chipset. for those who don't
know what this does: it sets a bit in a register of the northbridge of the
chipset to enable the power saving modes of the athlon/duron/athlon xp
prozessors.
i did not found any patch which enables this function on an kt266/kt266a
board. so i modified this patch (
http://groups.google.com/groups?q=via_disconnect&hl=en&selm=linux.kernel.20010903002855.A645%40gondor.com&rnum=1
)
to support the kt266 and kt266a chipset to.

now i am looking for people to test the patch and repord, whether it works
allright on other computers than my computer (i tested this patch on an
epox 8kha+ whith an xp1600+).

if you want to test this patch:
1. first apply the patch
2. enable generel-setup -> acpi , acpi-bus-maager , prozessor
   in the kernel config
3. add to the "append" line in /etc/lilo.conf the "amd_disconnect=yes"
statemand (or after reboot enter at the kernel-boot-prompt
"amd_disconnect=yes")
4. build a knew kernel
5. report to me, whether you have problems ...

if the patch gets a good feedback, maybe it is something for the official
kernel tree ?

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de


---947385803-1046103454-1011720078=:11025
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="amd_cool.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.40.0201221821180.11025@infcip10.uni-trier.de>
Content-Description: 
Content-Disposition: attachment; filename="amd_cool.diff"

LS0tIGxpbnV4LTIuNC4xNy1vcmlnL2RyaXZlcnMvcGNpL3F1aXJrcy5jCVN1
biBOb3YgMTEgMTk6MDk6MzMgMjAwMQ0KKysrIGxpbnV4L2RyaXZlcnMvcGNp
L3F1aXJrcy5jCVR1ZSBKYW4gMjIgMTY6NTA6MDUgMjAwMg0KQEAgLTIxLDYg
KzIxLDIzIEBADQogDQogI3VuZGVmIERFQlVHDQogDQorLyogUG93ZXIgU2F2
aW5nIGZvciBBdGhsb24vRHVyb24gQ1BVcyBvbiBWaWEgQ2hpcHNldHMgaGFz
IHRvIGJlIGVuYWJsZWQgYnllIA0KKyAqIGtlcm5lbC1ib290LW9wdGlvbiAi
YW1kX2Rpc2Nvbm5lY3Q9eWVzIiAuIFRoaXMgaXMgY2F1c2UgaXQgbG9va3Mg
bGlrZSANCisgKiB0aGVyZSBhcmUgc29tZSBzdGFiaWxpdHkgcHJvYmxlbXMg
b24gc29tZSBib2FyZHMgd2hlbiB0aGlzIG9wdGlvbiBpcyANCisgKiBlbmFi
bGVkLg0KKyAqLw0KKw0KK2ludCBlbmFibGVfYW1kX2Rpc2Nvbm5lY3Q7DQor
DQorc3RhdGljIGludCBfX2luaXQgYW1kX2Rpc2Nvbm5lY3Rfc2V0dXAgKGNo
YXIgKnN0cikgew0KKyAgICAgICAgaWYoIXN0cm5jbXAoc3RyLCJ5ZXMiLDMp
KSB7DQorICAgICAgICAgICAgICAgIGVuYWJsZV9hbWRfZGlzY29ubmVjdD0x
Ow0KKwkJCQkJICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KKyAgICAgICAgcmV0dXJuIDE7DQorfQ0KKw0KK19f
c2V0dXAoImFtZF9kaXNjb25uZWN0PSIsIGFtZF9kaXNjb25uZWN0X3NldHVw
KTsNCisNCiAvKiBEZWFsIHdpdGggYnJva2VuIEJJT1MnZXMgdGhhdCBuZWds
ZWN0IHRvIGVuYWJsZSBwYXNzaXZlIHJlbGVhc2UsDQogICAgd2hpY2ggY2Fu
IGNhdXNlIHByb2JsZW1zIGluIGNvbWJpbmF0aW9uIHdpdGggdGhlIDgyNDQx
RlgvUFBybyBNVFJScyAqLw0KIHN0YXRpYyB2b2lkIF9faW5pdCBxdWlya19w
YXNzaXZlX3JlbGVhc2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCkBAIC0xNDYs
NiArMTYzLDQ3IEBADQogCXByaW50ayhLRVJOX0lORk8gIkFwcGx5aW5nIFZJ
QSBzb3V0aGJyaWRnZSB3b3JrYXJvdW5kLlxuIik7DQogfQ0KIA0KKy8qIFBv
d2VyIFNhdmluZyBmb3IgQXRobG9uL0R1cm9uL0F0aG9uWFAgQ1BVcyBvbiBW
aWEgQ2hpcHNldHMuDQorICogRm91bmQgaW4gdGhlIG5ldCBhbmQgbW9kaWZp
ZWQgZm9yIHN1cHBvcnRpbmcgS1QyNjYvS1QyNjZBIGNoaXBzZXRzDQorICog
YnkgRGFuaWVsIE5vZmZ0eiA8bm9mZnR6QGNhc3Rvci51bmktdHJpZXIuZGU+
DQorICogVGhpcyBGdW5rdGlvbiBtdXN0IGJlIGVuYWJsZWQgYnkga2VybmVs
IGJvb3Rpbmcgb3B0aW9uICJ2aWFfZGlzY29ubmVjdD15ZXMiIQ0KKyAqLw0K
Kw0KK3N0YXRpYyB2b2lkIF9faW5pdCBxdWlya19hbWRkaXNjb25uZWN0KHN0
cnVjdCBwY2lfZGV2ICpkZXYpDQorew0KKwl1MTYgZGlkOw0KKwl1MzIgcmVz
MzI7DQorCQ0KKwlpZighZW5hYmxlX2FtZF9kaXNjb25uZWN0KSByZXR1cm47
DQorDQorICAgICAgICBwY2lfcmVhZF9jb25maWdfd29yZChkZXYsUENJX0RF
VklDRV9JRCwmZGlkKTsNCisNCisJDQorCWlmKGRpZD09UENJX0RFVklDRV9J
RF9WSUFfODM2N18wKQ0KKwl7DQorCQlwY2lfcmVhZF9jb25maWdfZHdvcmQo
ZGV2LDB4OTImMHhmYywmcmVzMzIpOw0KKwkJaWYgKChyZXMzMiYweDAwODAw
MDAwKT09MCkgDQorCQl7DQorCQkJcHJpbnRrKEtFUk5fSU5GTyAiRW5hYmxp
bmcgZGlzY29ubmVjdCBpbiBWSUEgbm9ydGhicmlkZ2U6IEtUMjY2LzI2NkEg
Y2hpcHNldCBmb3VuZC5cbiIpOw0KKwkJCXJlczMyfD0weDAwODAwMDAwOw0K
KwkJCXBjaV93cml0ZV9jb25maWdfZHdvcmQoZGV2LDB4OTImMHhmYyxyZXMz
Mik7DQorCQl9IGVsc2UNCisJCQlwcmludGsoS0VSTl9JTkZPICJEaXNjb25u
ZWN0IGFscmVhZHkgYW5hYmxlZCBpbiBWSUEgbm9ydGhicmlkZ2UuXG4iKTsN
CisNCisJfQ0KKwllbHNlIGlmKChkaWQ9PVBDSV9ERVZJQ0VfSURfVklBXzgz
NjNfMCl8fChkaWQ9PVBDSV9ERVZJQ0VfSURfVklBXzgzNzFfMCkpDQorCXsN
CisJCXBjaV9yZWFkX2NvbmZpZ19kd29yZChkZXYsMHg1MiYweGZjLCZyZXMz
Mik7DQorCSAgICAgICAgaWYgKChyZXMzMiYweDAwODAwMDAwKT09MCkgDQor
CQl7CQ0KKwkJCXByaW50ayhLRVJOX0lORk8gIkVuYWJsaW5nIGRpc2Nvbm5l
Y3QgaW4gVklBIG5vcnRoYnJpZGdlOiBLVDEzMy9LWDEzMyBjaGlwc2V0IGZv
dW5kXG4iKTsNCisJCQlyZXMzMnw9MHgwMDgwMDAwMDsNCisJCQlwY2lfd3Jp
dGVfY29uZmlnX2R3b3JkKGRldiwweDUyJjB4ZmMscmVzMzIpOw0KKwkJfSBl
bHNlDQorCQkJcHJpbnRrKEtFUk5fSU5GTyAiRGlzY29ubmVjdCBhbHJlYWR5
IGFuYWJsZWQgaW4gVklBIG5vcnRoYnJpZGdlLlxuIik7DQorCQkNCisJfQ0K
K30NCiAvKg0KICAqCVZJQSBBcG9sbG8gVlAzIG5lZWRzIEVUQkYgb24gQlQ4
NDgvODc4DQogICovDQpAQCAtNDg1LDYgKzU0Myw5IEBADQogCXsgUENJX0ZJ
WFVQX0ZJTkFMLAlQQ0lfVkVORE9SX0lEX1ZJQSwJUENJX0RFVklDRV9JRF9W
SUFfODM2M18wLAlxdWlya192aWFsYXRlbmN5IH0sDQogCXsgUENJX0ZJWFVQ
X0ZJTkFMLAlQQ0lfVkVORE9SX0lEX1ZJQSwJUENJX0RFVklDRV9JRF9WSUFf
ODM3MV8xLAlxdWlya192aWFsYXRlbmN5IH0sDQogCXsgUENJX0ZJWFVQX0ZJ
TkFMLAlQQ0lfVkVORE9SX0lEX1ZJQSwJMHgzMTEyCS8qIE5vdCBvdXQgeWV0
ID8gKi8sCXF1aXJrX3ZpYWxhdGVuY3kgfSwNCisJeyBQQ0lfRklYVVBfRklO
QUwsICAgICAgUENJX1ZFTkRPUl9JRF9WSUEsICAgICAgUENJX0RFVklDRV9J
RF9WSUFfODM2N18wLAlxdWlya19hbWRkaXNjb25uZWN0IH0sDQorICAgICAg
ICB7IFBDSV9GSVhVUF9GSU5BTCwgICAgICBQQ0lfVkVORE9SX0lEX1ZJQSwg
ICAgICBQQ0lfREVWSUNFX0lEX1ZJQV84MzYzXzAsICAgICAgIHF1aXJrX2Ft
ZGRpc2Nvbm5lY3QgfSwNCisgICAgICAgIHsgUENJX0ZJWFVQX0ZJTkFMLCAg
ICAgIFBDSV9WRU5ET1JfSURfVklBLCAgICAgIFBDSV9ERVZJQ0VfSURfVklB
XzgzNzFfMCwgICAgICAgcXVpcmtfYW1kZGlzY29ubmVjdCB9LA0KIAl7IFBD
SV9GSVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0Vf
SURfVklBXzgyQzU3NiwJcXVpcmtfdnNmeCB9LA0KIAl7IFBDSV9GSVhVUF9G
SU5BTCwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzgy
QzU5N18wLAlxdWlya192aWFldGJmIH0sDQogCXsgUENJX0ZJWFVQX0hFQURF
UiwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzgyQzU5
N18wLAlxdWlya192dDgyYzU5OF9pZCB9LA0K
---947385803-1046103454-1011720078=:11025--
