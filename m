Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUDSVKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUDSVKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUDSVKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:10:49 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:7040 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261742AbUDSVK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:10:28 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1082392797.2559.54.camel@lade.trondhjem.org>
References: <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
	 <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea>
	 <1082228313.2580.25.camel@lade.trondhjem.org> <20040417190107.GA4179@flea>
	 <1082228963.2580.34.camel@lade.trondhjem.org>
	 <20040417201914.B21974@flint.arm.linux.org.uk>
	 <1082256704.3619.68.camel@lade.trondhjem.org>
	 <1082392797.2559.54.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-fj+nyMYxSqEW7zegQW+n"
Message-Id: <1082409028.3360.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 17:10:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fj+nyMYxSqEW7zegQW+n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-04-19 at 12:39, Trond Myklebust wrote:

> It turned out there were a few extra issues that weren't fixed by the
> previous patch. Thanks to boris@macbeth.rhoen.de for helping debug them.
> 
> Hopefully this will be the final set of fixes.

Sigh. It wasn't... The remote path was still not getting set properly.
Here's the final version. Tested, and it should now work according to
spec!

Cheers,
  Trond

--=-fj+nyMYxSqEW7zegQW+n
Content-Description: 
Content-Disposition: inline; filename=linux-2.6.6-02-fix_nfsroot.dif
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=iso-8859-1

IG5mc3Jvb3QuYyB8ICAgMzAgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxl
cyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtdSAt
LXJlY3Vyc2l2ZSAtLW5ldy1maWxlIC0tc2hvdy1jLWZ1bmN0aW9uIGxpbnV4LTIuNi42LTAxLXNv
ZnQvZnMvbmZzL25mc3Jvb3QuYyBsaW51eC0yLjYuNi0wMi1maXhfbmZzcm9vdC9mcy9uZnMvbmZz
cm9vdC5jDQotLS0gbGludXgtMi42LjYtMDEtc29mdC9mcy9uZnMvbmZzcm9vdC5jCTIwMDQtMDQt
MTkgMTI6Mjc6NTEuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi42LjYtMDItZml4X25mc3Jv
b3QvZnMvbmZzL25mc3Jvb3QuYwkyMDA0LTA0LTE5IDE2OjI2OjEyLjAwMDAwMDAwMCAtMDQwMA0K
QEAgLTExNywxMSArMTE3LDE2IEBAIHN0YXRpYyBpbnQgbW91bnRfcG9ydCBfX2luaXRkYXRhID0g
MDsJCS8NCiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KIA0KIGVudW0gew0KKwkvKiBPcHRpb25zIHRo
YXQgdGFrZSBpbnRlZ2VyIGFyZ3VtZW50cyAqLw0KIAlPcHRfcG9ydCwgT3B0X3JzaXplLCBPcHRf
d3NpemUsIE9wdF90aW1lbywgT3B0X3JldHJhbnMsIE9wdF9hY3JlZ21pbiwNCi0JT3B0X2FjcmVn
bWF4LCBPcHRfYWNkaXJtaW4sIE9wdF9hY2Rpcm1heCwgT3B0X3NvZnQsIE9wdF9oYXJkLCBPcHRf
aW50ciwNCisJT3B0X2FjcmVnbWF4LCBPcHRfYWNkaXJtaW4sIE9wdF9hY2Rpcm1heCwNCisJLyog
T3B0aW9ucyB0aGF0IHRha2Ugbm8gYXJndW1lbnRzICovDQorCU9wdF9zb2Z0LCBPcHRfaGFyZCwg
T3B0X2ludHIsDQogCU9wdF9ub2ludHIsIE9wdF9wb3NpeCwgT3B0X25vcG9zaXgsIE9wdF9jdG8s
IE9wdF9ub2N0bywgT3B0X2FjLCANCiAJT3B0X25vYWMsIE9wdF9sb2NrLCBPcHRfbm9sb2NrLCBP
cHRfdjIsIE9wdF92MywgT3B0X3VkcCwgT3B0X3RjcCwNCi0JT3B0X2Jyb2tlbl9zdWlkLCBPcHRf
ZXJyLA0KKwlPcHRfYnJva2VuX3N1aWQsDQorCS8qIEVycm9yIHRva2VuICovDQorCU9wdF9lcnIN
CiB9Ow0KIA0KIHN0YXRpYyBtYXRjaF90YWJsZV90IHRva2VucyA9IHsNCkBAIC0xNDYsOSArMTUx
LDEzIEBAIHN0YXRpYyBtYXRjaF90YWJsZV90IHRva2VucyA9IHsNCiAJe09wdF9ub2FjLCAibm9h
YyJ9LA0KIAl7T3B0X2xvY2ssICJsb2NrIn0sDQogCXtPcHRfbm9sb2NrLCAibm9sb2NrIn0sDQor
CXtPcHRfdjIsICJuZnN2ZXJzPTIifSwNCiAJe09wdF92MiwgInYyIn0sDQorCXtPcHRfdjMsICJu
ZnN2ZXJzPTMifSwNCiAJe09wdF92MywgInYzIn0sDQorCXtPcHRfdWRwLCAicHJvdG89dWRwIn0s
DQogCXtPcHRfdWRwLCAidWRwIn0sDQorCXtPcHRfdGNwLCAicHJvdG89dGNwIn0sDQogCXtPcHRf
dGNwLCAidGNwIn0sDQogCXtPcHRfYnJva2VuX3N1aWQsICJicm9rZW5fc3VpZCJ9LA0KIAl7T3B0
X2VyciwgTlVMTH0NCkBAIC0xNjksMTggKzE3OCwxOSBAQCBzdGF0aWMgaW50IF9faW5pdCByb290
X25mc19wYXJzZShjaGFyICpuDQogCWlmICghbmFtZSkNCiAJCXJldHVybiAxOw0KIA0KLQlpZiAo
bmFtZVswXSAmJiBzdHJjbXAobmFtZSwgImRlZmF1bHQiKSl7DQotCQlzdHJsY3B5KGJ1ZiwgbmFt
ZSwgTkZTX01BWFBBVEhMRU4pOw0KLQkJcmV0dXJuIDE7DQotCX0NCisJLyogU2V0IHRoZSBORlMg
cmVtb3RlIHBhdGggKi8NCisJcCA9IHN0cnNlcCgmbmFtZSwgIiwiKTsNCisJaWYgKHBbMF0gIT0g
J1wwJyAmJiBzdHJjbXAocCwgImRlZmF1bHQiKSAhPSAwKQ0KKwkJc3RybGNweShidWYsIHAsIE5G
U19NQVhQQVRITEVOKTsNCisNCiAJd2hpbGUgKChwID0gc3Ryc2VwICgmbmFtZSwgIiwiKSkgIT0g
TlVMTCkgew0KIAkJaW50IHRva2VuOyANCiAJCWlmICghKnApDQogCQkJY29udGludWU7DQogCQl0
b2tlbiA9IG1hdGNoX3Rva2VuKHAsIHRva2VucywgYXJncyk7DQogDQotCQkvKiAldSB0b2tlbnMg
b25seSAqLw0KLQkJaWYgKG1hdGNoX2ludCgmYXJnc1swXSwgJm9wdGlvbikpDQorCQkvKiAldSB0
b2tlbnMgb25seS4gQmV3YXJlIGlmIHlvdSBhZGQgbmV3IHRva2VucyEgKi8NCisJCWlmICh0b2tl
biA8IE9wdF9zb2Z0ICYmIG1hdGNoX2ludCgmYXJnc1swXSwgJm9wdGlvbikpDQogCQkJcmV0dXJu
IDA7DQogCQlzd2l0Y2ggKHRva2VuKSB7DQogCQkJY2FzZSBPcHRfcG9ydDoNCkBAIC0yNjUsNiAr
Mjc1LDcgQEAgc3RhdGljIGludCBfX2luaXQgcm9vdF9uZnNfcGFyc2UoY2hhciAqbg0KIAkJCQly
ZXR1cm4gMDsNCiAJCX0NCiAJfQ0KKw0KIAlyZXR1cm4gMTsNCiB9DQogDQpAQCAtMjgzLDkgKzI5
NCw2IEBAIHN0YXRpYyBpbnQgX19pbml0IHJvb3RfbmZzX25hbWUoY2hhciAqbmENCiAJbmZzX2Rh
dGEuZmxhZ3MgICAgPSBORlNfTU9VTlRfTk9OTE07CS8qIE5vIGxvY2tkIGluIG5mcyByb290IHll
dCAqLw0KIAluZnNfZGF0YS5yc2l6ZSAgICA9IE5GU19ERUZfRklMRV9JT19CVUZGRVJfU0laRTsN
CiAJbmZzX2RhdGEud3NpemUgICAgPSBORlNfREVGX0ZJTEVfSU9fQlVGRkVSX1NJWkU7DQotCW5m
c19kYXRhLmJzaXplCSAgPSAwOw0KLQluZnNfZGF0YS50aW1lbyAgICA9IDc7DQotCW5mc19kYXRh
LnJldHJhbnMgID0gMzsNCiAJbmZzX2RhdGEuYWNyZWdtaW4gPSAzOw0KIAluZnNfZGF0YS5hY3Jl
Z21heCA9IDYwOw0KIAluZnNfZGF0YS5hY2Rpcm1pbiA9IDMwOw0K

--=-fj+nyMYxSqEW7zegQW+n--
