Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVIHIQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVIHIQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIHIQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:16:06 -0400
Received: from mail.curamsoftware.com ([193.120.164.2]:30365 "EHLO
	mail.curamsoftware.com") by vger.kernel.org with ESMTP
	id S1751345AbVIHIQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:16:06 -0400
X-IronPort-AV: i="3.96,178,1122850800"; 
   d="txt'?scan'208"; a="456044:sNHT41322384"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5B44D.88B3CF5C"
Subject: The BogoMIPS value sometimes too low on Intel Mobile P3
Date: Thu, 8 Sep 2005 09:15:54 +0100
Message-ID: <949F43A185737046A32445D37D15EC0201BE7645@Mail04.curamsoftware.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: The BogoMIPS value sometimes too low on Intel Mobile P3
Thread-Index: AcW0TYh4q2IFxRMUTnyvSYP3jbGn3g==
From: "Martin Vlk" <MVlk@curamsoftware.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jens Pittler" <jpitt@physik.uni-leipzig.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5B44D.88B3CF5C
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi folks,
I am running a custom-built kernel 2.6.10 on an Intel Mobile P3 processor. =
(Acer
TravelMate 620)

>From time to time it happens to me that on boot-up the USB mouse doesn't wo=
rk.
When I try a USB camera in this situation it doesn't work either.

I discovered that when the USB devices don't work the BogoMIPS value calcul=
ated
is far lower than it should be. For example it is 32 whereas normally it sh=
ould
be around 1450.

The low BogoMIPS value causes the USB init delays to be calculated too shor=
t and
the devices are not given enough time to initialize.

It happens in approximately 45% of boot-ups and the only way I know of to m=
ake
it work again is restart. Very often restart is needed multiple times befor=
e it
starts working again.

I tried to switch processor power management settings in BIOS, but with no
success so far. Also today I discovered another BIOS setting related to Int=
el
SpeedStep technology and I tried to change the value to try if I get any be=
tter
behaviour. Will see in few days.

Attached are log examples from both successful and unsuccessful boot-ups. I
noticed the detected processor speed varies and also different hi-res
timesources are used (tsc, pmtmr). Is that of any significance?

Any idea what the problem and solution is?

Thanks
Martin V.


The information in this email is confidential and may be legally privileged.
It is intended solely for the addressee. Access to this email by anyone else
is unauthorized. If you are not the intended recipient, any disclosure,
copying, distribution or any action taken or omitted to be taken in reliance
on it, is prohibited and may be unlawful. If you are not the intended
addressee please contact the sender and dispose of this e-mail. Thank you.

------_=_NextPart_001_01C5B44D.88B3CF5C
Content-Type: text/plain;
	name="logs.txt"
Content-Transfer-Encoding: base64
Content-Description: logs.txt
Content-Disposition: attachment;
	filename="logs.txt"

RGV0ZWN0ZWQgNzMzLjQ0MCBNSHogcHJvY2Vzc29yLg0KVXNpbmcgdHNjIGZvciBoaWdoLXJlcyB0
aW1lc291cmNlDQpDb25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1DQpEZW50cnkgY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykNCklu
b2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA1LCAxMzEwNzIgYnl0
ZXMpDQpNZW1vcnk6IDUwODE4NGsvNTE1OTA0ayBhdmFpbGFibGUgKDE1NjhrIGtlcm5lbCBjb2Rl
LCA3MjQ0ayByZXNlcnZlZCwgODY5ayBkYXRhLCAxNTJrIGluaXQsIDBrPj4+aGlnaG1lbSkNCkNo
ZWNraW5nIGlmIHRoaXMgcHJvY2Vzc29yIGhvbm91cnMgdGhlIFdQIGJpdCBldmVuIGluIHN1cGVy
dmlzb3IgbW9kZS4uLk9rLg0KQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiAxNDQ5Ljk4IEJvZ29N
SVBTIChscGo9NzI0OTkyKQ0KDQpEZXRlY3RlZCA5OTkuOTkyIE1IeiBwcm9jZXNzb3IuDQpVc2lu
ZyBwbXRtciBmb3IgaGlnaC1yZXMgdGltZXNvdXJjZQ0KQ29uc29sZTogY29sb3VyIGR1bW15IGRl
dmljZSA4MHgyNQ0KRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVy
OiA2LCAyNjIxNDQgYnl0ZXMpDQpJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4
IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzKQ0KTWVtb3J5OiA1MDgxODRrLzUxNTkwNGsgYXZhaWxh
YmxlICgxNTY4ayBrZXJuZWwgY29kZSwgNzI0NGsgcmVzZXJ2ZWQsIDg2OWsgZGF0YSwgMTUyayBp
bml0LCAwaz4+PmhpZ2htZW0pDQpDaGVja2luZyBpZiB0aGlzIHByb2Nlc3NvciBob25vdXJzIHRo
ZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1vZGUuLi5Pay4NCkNhbGlicmF0aW5nIGRlbGF5
IGxvb3AuLi4gMzIuNTcgQm9nb01JUFMgKGxwaj0xNjI4OCkNCg0KRGV0ZWN0ZWQgMTAwMC4xMzUg
TUh6IHByb2Nlc3Nvci4NClVzaW5nIHBtdG1yIGZvciBoaWdoLXJlcyB0aW1lc291cmNlDQpDb25z
b2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1DQpEZW50cnkgY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykNCklub2RlLWNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMpDQpNZW1vcnk6IDUw
ODE4NGsvNTE1OTA0ayBhdmFpbGFibGUgKDE1NjhrIGtlcm5lbCBjb2RlLCA3MjQ0ayByZXNlcnZl
ZCwgODY5ayBkYXRhLCAxNTJrIGluaXQsIDBrIGhpZ2htZW0pDQpDaGVja2luZyBpZiB0aGlzIHBy
b2Nlc3NvciBob25vdXJzIHRoZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1vZGUuLi5Pay4N
CkNhbGlicmF0aW5nIGRlbGF5IGxvb3AuLi4gMTA0MC4zOCBCb2dvTUlQUyAobHBqPTUyMDE5MikN
Cg0KRGV0ZWN0ZWQgMTAwMC4yODUgTUh6IHByb2Nlc3Nvci4NClVzaW5nIHBtdG1yIGZvciBoaWdo
LXJlcyB0aW1lc291cmNlDQpDb25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1DQpEZW50
cnkgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRl
cykNCklub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA1LCAxMzEw
NzIgYnl0ZXMpDQpNZW1vcnk6IDUwODE4NGsvNTE1OTA0ayBhdmFpbGFibGUgKDE1NjhrIGtlcm5l
bCBjb2RlLCA3MjQ0ayByZXNlcnZlZCwgODY5ayBkYXRhLCAxNTJrIGluaXQsIDBrPj4+aGlnaG1l
bSkNCkNoZWNraW5nIGlmIHRoaXMgcHJvY2Vzc29yIGhvbm91cnMgdGhlIFdQIGJpdCBldmVuIGlu
IHN1cGVydmlzb3IgbW9kZS4uLk9rLg0KQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiA2NS4xNSBC
b2dvTUlQUyAobHBqPTMyNTc2KQ0KDQo=

------_=_NextPart_001_01C5B44D.88B3CF5C--
