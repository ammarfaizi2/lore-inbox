Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTDXBix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTDXBiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 21:38:52 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51977
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263463AbTDXBiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 21:38:50 -0400
Date: Wed, 23 Apr 2003 18:47:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
Subject: ide-2.5.68.patch
Message-ID: <Pine.LNX.4.10.10304231834240.2033-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430322656-22962417-1051148856=:2033"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-22962417-1051148856=:2033
Content-Type: text/plain; charset=us-ascii


LKML et al.

This patch is to promote Bartlomiej to a well earned position as the
Global IDE Maintainer, as I have stepped tp the side to handle the SATA
and vendor chipset issues.  My time here was to clean up the transport to
allow the simplicity of the protocol to be expressed.

If there is an issue where one believes I need tp be included in the
thread please CC me as I limit my reading of lkml directly.

This patch also addresses some text whose intent may be a restriction to
GPL; however, GPL itself is flawed as it relates to concatenation or
appending addition information to a binary program, be it a kernel or app.
whose current license status is GPL or LGPL.  With this in mind, I will
formally announce that all of my contributions to the kernel over the past
5 years or so are to be dual licensed in OSL/GPL format.  I would strongly
suggest any person who has a stake in the kernel to review OSL and
consider.

If anyone has an issue with this change, get over it.  If you can not get
over it, you can pay for the legal opinion for review.

Regards,

Andre Hedrick
LAD Storage Consulting Group

The (retiring) Linux ATA/IDE guy

--1430322656-22962417-1051148856=:2033
Content-Type: text/plain; charset=us-ascii; name="ide-2.5.68.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10304231847360.2033@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="ide-2.5.68.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNS42OC5wcmlzdGluZS9NQUlOVEFJTkVSUyBs
aW51eC0yLjUuNjgvTUFJTlRBSU5FUlMNCi0tLSBsaW51eC0yLjUuNjgucHJp
c3RpbmUvTUFJTlRBSU5FUlMJU2F0IEFwciAxOSAxOTo1MDowMSAyMDAzDQor
KysgbGludXgtMi41LjY4L01BSU5UQUlORVJTCVdlZCBBcHIgMjMgMTM6MjA6
MTYgMjAwMw0KQEAgLTg0Niw2ICs4NDYsOSBAQA0KIFM6CVN1cHBvcnRlZCAN
CiANCiBJREUgRFJJVkVSIFtHRU5FUkFMXQ0KK1A6CUJhcnRsb21pZWogWm9s
bmllcmtpZXdpY3oNCitNOglCLlpvbG5pZXJraWV3aWN6QGVsa2EucHcuZWR1
LnBsDQorTToJYmt6QGxpbnV4LWlkZS5vcmcNCiBMOglsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQogTDoJbGludXgtaWRlQHZnZXIua2VybmVsLm9y
Zw0KIFM6CU1haW50YWluZWQNCkBAIC04NzAsNiArODczLDEzIEBADQogTDoJ
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KIFM6CU1haW50YWluZWQN
CiANCitJREUvQ0hJUFNFVFMgQU5EIFRBU0tGSUxFIFRSQU5TUE9SVA0KK1A6
CUFuZHJlIEhlZHJpY2sNCitNOglhbmRyZUBsaW51eC1pZGUub3JnDQorTDoJ
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KK0w6CWxpbnV4LWlkZUB2
Z2VyLmtlcm5lbC5vcmcNCitTOglNYWludGFpbmVkDQorDQogSUVFRSAxMzk0
IFNVQlNZU1RFTQ0KIFA6CUJlbiBDb2xsaW5zDQogTToJYmNvbGxpbnNAZGVi
aWFuLm9yZw0KQEAgLTE1OTAsNiArMTYwMCwxMiBAQA0KIE06CWNocmlzdGVy
QHdlaW5pZ2VsLnNlDQogVzoJaHR0cDovL3d3dy53ZWluaWdlbC5zZQ0KIFM6
CVN1cHBvcnRlZA0KKw0KK1NFUklBTCBBVEEgMS4wIEFORCBJSQ0KK1A6CUFu
ZHJlIEhlZHJpY2sNCitNOglhbmRyZUBzZXJpYWxhdGEub3JnDQorTToJYW5k
cmVAbGludXgtaWRlLm9yZw0KK1M6CU1haW50YWluZWQNCiANCiBTR0kgVklT
VUFMIFdPUktTVEFUSU9OIDMyMCBBTkQgNTQwDQogUDoJQW5kcmV5IFBhbmlu
DQpkaWZmIC11ck4gbGludXgtMi41LjY4LnByaXN0aW5lL2RyaXZlcnMvaWRl
L0lERS5LRVkuc2lnbmluZyBsaW51eC0yLjUuNjgvZHJpdmVycy9pZGUvSURF
LktFWS5zaWduaW5nDQotLS0gbGludXgtMi41LjY4LnByaXN0aW5lL2RyaXZl
cnMvaWRlL0lERS5LRVkuc2lnbmluZwlXZWQgRGVjIDMxIDE2OjAwOjAwIDE5
NjkNCisrKyBsaW51eC0yLjUuNjgvZHJpdmVycy9pZGUvSURFLktFWS5zaWdu
aW5nCVdlZCBBcHIgMjMgMTY6MjE6MzEgMjAwMw0KQEAgLTAsMCArMSwyNyBA
QA0KKw0KK1RoZSBvcmlnaW5hbCB0ZXh0IGluIGlkZS1pby5jDQorDQorLyoN
CisgKiBGb3IgdGhlIGF2b2lkYW5jZSBvZiBkb3VidCB0aGUgInByZWZlcnJl
ZCBmb3JtIiBvZiB0aGlzIGNvZGUgaXMgb25lIHdoaWNoDQorICogaXMgaW4g
YW4gb3BlbiBub24gcGF0ZW50IGVuY3VtYmVyZWQgZm9ybWF0LiBXaGVyZSBj
cnlwdG9ncmFwaGljIGtleSBzaWduaW5nDQorICogZm9ybXMgcGFydCBvZiB0
aGUgcHJvY2VzcyBvZiBjcmVhdGluZyBhbiBleGVjdXRhYmxlIHRoZSBpbmZv
cm1hdGlvbg0KKyAqIGluY2x1ZGluZyBrZXlzIG5lZWRlZCB0byBnZW5lcmF0
ZSBhbiBlcXVpdmFsZW50bHkgZnVuY3Rpb25hbCBleGVjdXRhYmxlDQorICog
YXJlIGRlZW1lZCB0byBiZSBwYXJ0IG9mIHRoZSBzb3VyY2UgY29kZS4NCisg
Ki8NCisNCitUaGlzIGlzc3VlcyBhcmUgY29uY2VybnMgZm9yIHNlY3VyaXR5
IHNpZ25pbmcgb2Yga2VybmVscy4NCisNCitTaW5jZSBHUEwgY292ZXJzIHRo
ZSBjYXNlIG9mIGFkZGl0aW9uYWwgY29kZSBhZGRlZCBvciBsaWtlZCB0byB0
aGUgcHJvZ3JhbQ0KK211c3QgYWxzbyBiZSBHUEwsIHdlbGwgdGhpcyBpcyBv
YnZpb3VzIC4uLiBCVVQgR1BMIGhhcyBubyBsYW5ndWFnZSB0byBoYW5kbGUN
Citjb25jYXRlbmF0aW9uIG9yIGNvbWJpbmVkIHdvcmsuICBUaGlzIGlzIGEg
ZmF0YWwgZmxhdyBpbiBHUEwuDQorDQorVGhpcyBpcyBhbiBpbmZvcm1hdGl2
ZSBkb2N1bWVudCwgbm90IGEgbm9ybWF0aXZlLg0KKw0KK1NlZSBPU0wgYXR0
YWNoZWQuDQoraHR0cDovL3d3dy5vcGVuc291cmNlLm9yZy9saWNlbnNlcy9v
c2wucGhwDQoraHR0cDovL3d3dy5vcGVuc291cmNlLm9yZy9saWNlbnNlcy9v
c2wtMS4xLnR4dA0KKw0KKw0KK0FuZHJlIEhlZHJpY2sNCitMaW51eCBBVEEg
RGV2ZWxvcG1lbnQNCisNCmRpZmYgLXVyTiBsaW51eC0yLjUuNjgucHJpc3Rp
bmUvZHJpdmVycy9pZGUvaWRlLWlvLmMgbGludXgtMi41LjY4L2RyaXZlcnMv
aWRlL2lkZS1pby5jDQotLS0gbGludXgtMi41LjY4LnByaXN0aW5lL2RyaXZl
cnMvaWRlL2lkZS1pby5jCVNhdCBBcHIgMTkgMTk6NTA6MzkgMjAwMw0KKysr
IGxpbnV4LTIuNS42OC9kcml2ZXJzL2lkZS9pZGUtaW8uYwlXZWQgQXByIDIz
IDEyOjQ3OjA1IDIwMDMNCkBAIC0xNiwxMyArMTYsOCBAQA0KICAqIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZSB0aGUgR05VDQogICogR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLg0KICAqDQotICogRm9yIHRoZSBhdm9pZGFuY2Ug
b2YgZG91YnQgdGhlICJwcmVmZXJyZWQgZm9ybSIgb2YgdGhpcyBjb2RlIGlz
IG9uZSB3aGljaA0KLSAqIGlzIGluIGFuIG9wZW4gbm9uIHBhdGVudCBlbmN1
bWJlcmVkIGZvcm1hdC4gV2hlcmUgY3J5cHRvZ3JhcGhpYyBrZXkgc2lnbmlu
Zw0KLSAqIGZvcm1zIHBhcnQgb2YgdGhlIHByb2Nlc3Mgb2YgY3JlYXRpbmcg
YW4gZXhlY3V0YWJsZSB0aGUgaW5mb3JtYXRpb24NCi0gKiBpbmNsdWRpbmcg
a2V5cyBuZWVkZWQgdG8gZ2VuZXJhdGUgYW4gZXF1aXZhbGVudGx5IGZ1bmN0
aW9uYWwgZXhlY3V0YWJsZQ0KLSAqIGFyZSBkZWVtZWQgdG8gYmUgcGFydCBv
ZiB0aGUgc291cmNlIGNvZGUuDQorICogU0VFIEV4dGVybmFsIGZpbGUgZm9y
IGNvbmNlcm5zIGFib3V0ICJwcmVmZXJyZWQgZm9ybSIuDQogICovDQotIA0K
ICANCiAjaW5jbHVkZSA8bGludXgvY29uZmlnLmg+DQogI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0K
--1430322656-22962417-1051148856=:2033--
