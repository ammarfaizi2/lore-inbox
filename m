Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267844AbTGTT0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbTGTT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:26:47 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:58601 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S267844AbTGTT0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:26:46 -0400
Message-Id: <200307201939.h6KJdqxs005419@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Makefile 'rpm' target on Red Hat (8.0/9)
Date: Sun, 20 Jul 2003 21:40:23 +0200
Organization: Linux Kernel Austria
X-Mailer: Oracle Outlook Connector 3.4 40812
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=-------18644ec818644ec8
X-MailScanner-Information: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format

---------18644ec818644ec8
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks!

Since Red Hat moved options like '-ta', '-ba' (all the _build_ targets) awa=
y from the command 'rpm' to 'rpmbuild', the 'rpm' target is 'broken' (this =
is true for - at least - 2.4.19 'til 2.4.21-pre5). This is of course not a =
really big bug, but it also can be easily solved, by simply changing 'rpm -=
ta' to 'rpmbuild -ta'.

I'm not sure about other distributions like SuSE, Mandrake...

If 'rpmbuild' doesn't work on other rpm-based distributions (like the two a=
bove) I would recommend checking for /etc/redhat-release... Patch for Makef=
ile (from kver 2.4.21-pre5) attached.

Best regards,
 Oliver

---------18644ec818644ec8
Content-Type: application/octet-stream; name=Makefile.patch
Content-Disposition: attachment; filename=Makefile.patch
Content-Transfer-Encoding: base64

LS0tIE1ha2VmaWxlLm9sZCAgICAgICAgMjAwMy0wNy0yMCAyMToxNDo1OS4wMDAwMDAwMDAg
KzAyMDANCisrKyBNYWtlZmlsZSAgICAyMDAzLTA3LTIwIDIxOjM2OjQ3LjAwMDAwMDAwMCAr
MDIwMA0KQEAgLTEzLDYgKzEzLDkgQEANCiAgICAgICAgICBlbHNlIGVjaG8gc2g7IGZpIDsg
ZmkpDQogVE9QRElSIDo9ICQoc2hlbGwgL2Jpbi9wd2QpDQoNCitSUE0gOj0gJChzaGVsbCBp
ZiBbIC1mIC9ldGMvcmVkaGF0LXJlbGVhc2UgXTsgdGhlbiBlY2hvIHJwbWJ1aWxkOyBcDQor
ICAgICAgICAgZWxzZSBlY2hvIHJwbTsgZmkpDQorDQogSFBBVEggICAgICAgICAgPSAkKFRP
UERJUikvaW5jbHVkZQ0KIEZJTkRIUEFUSCAgICAgID0gJChIUEFUSCkvYXNtICQoSFBBVEgp
L2xpbnV4ICQoSFBBVEgpL3Njc2kgJChIUEFUSCkvbmV0ICQoSFBBVEgpL21hdGgtZW11DQoN
CkBAIC00Myw3ICs0Niw4IEBADQoNCiBleHBvcnQgVkVSU0lPTiBQQVRDSExFVkVMIFNVQkxF
VkVMIEVYVFJBVkVSU0lPTiBLRVJORUxSRUxFQVNFIEFSQ0ggXA0KICAgICAgICBDT05GSUdf
U0hFTEwgVE9QRElSIEhQQVRIIEhPU1RDQyBIT1NUQ0ZMQUdTIENST1NTX0NPTVBJTEUgQVMg
TEQgQ0MgXA0KLSAgICAgICBDUFAgQVIgTk0gU1RSSVAgT0JKQ09QWSBPQkpEVU1QIE1BS0Ug
TUFLRUZJTEVTIEdFTktTWU1TIE1PREZMQUdTIFBFUkwNCisgICAgICAgQ1BQIEFSIE5NIFNU
UklQIE9CSkNPUFkgT0JKRFVNUCBNQUtFIE1BS0VGSUxFUyBHRU5LU1lNUyBNT0RGTEFHUyBQ
RVJMIFwNCisgICAgICAgUlBNDQoNCiBhbGw6ICAgZG8taXQtYWxsDQoNCkBAIC01NzAsNSAr
NTc0LDUgQEANCiAgICAgICAgcm0gJChLRVJORUxQQVRIKSA7IFwNCiAgICAgICAgY2QgJChU
T1BESVIpIDsgXA0KICAgICAgICAuIHNjcmlwdHMvbWt2ZXJzaW9uID4gLnZlcnNpb24gOyBc
DQotICAgICAgIHJwbSAtdGEgJChUT1BESVIpLy4uLyQoS0VSTkVMUEFUSCkudGFyLmd6IDsg
XA0KKyAgICAgICAkKFJQTSkgLXRhICQoVE9QRElSKS8uLi8kKEtFUk5FTFBBVEgpLnRhci5n
eiA7IFwNCiAgICAgICAgcm0gJChUT1BESVIpLy4uLyQoS0VSTkVMUEFUSCkudGFyLmd6DQo=

---------18644ec818644ec8--

