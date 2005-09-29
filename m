Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVI2Anw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVI2Anw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVI2Anw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:43:52 -0400
Received: from fmr20.intel.com ([134.134.136.19]:48798 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751154AbVI2Anv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:43:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5C48E.D8F74115"
Subject: [PATCH] utilization of kprobe_mutex is incorrect on x86_64
Date: Thu, 29 Sep 2005 08:43:44 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84037185A6@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] utilization of kprobe_mutex is incorrect on x86_64
Thread-Index: AcXEjthj7P595BPcR56TMF+39Sx7ZA==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Cc: <systemtap@sources.redhat.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
X-OriginalArrivalTime: 29 Sep 2005 00:43:45.0779 (UTC) FILETIME=[D92AD430:01C5C48E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5C48E.D8F74115
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 <<kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch>> I found it
when reading the source codes. Basically, the bug could break
kprobe_insn_pages under multi-thread environment. PPC arch also has the
problem.
Here is the patch against x86_64.

Signed-off-by: Zhang Yanmin <Yanmin.zhang@intel.com>



------_=_NextPart_001_01C5C48E.D8F74115
Content-Type: application/octet-stream;
	name="kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch"
Content-Transfer-Encoding: base64
Content-Description: kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch
Content-Disposition: attachment;
	filename="kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch"

ZGlmZiAtTnJhdXAgbGludXgtMi42LjE0LXJjMi9hcmNoL3g4Nl82NC9rZXJuZWwva3Byb2Jlcy5j
IGxpbnV4LTIuNi4xNC1yYzJfZml4L2FyY2gveDg2XzY0L2tlcm5lbC9rcHJvYmVzLmMKLS0tIGxp
bnV4LTIuNi4xNC1yYzIvYXJjaC94ODZfNjQva2VybmVsL2twcm9iZXMuYwkyMDA1LTA5LTI5IDA4
OjM1OjQ2LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE0LXJjMl9maXgvYXJjaC94ODZf
NjQva2VybmVsL2twcm9iZXMuYwkyMDA1LTA5LTI5IDA4OjM2OjI3LjAwMDAwMDAwMCArMDgwMApA
QCAtNzcsOSArNzcsOSBAQCBzdGF0aWMgaW5saW5lIGludCBpc19JRl9tb2RpZmllcihrcHJvYmVf
CiBpbnQgX19rcHJvYmVzIGFyY2hfcHJlcGFyZV9rcHJvYmUoc3RydWN0IGtwcm9iZSAqcCkKIHsK
IAkvKiBpbnNuOiBtdXN0IGJlIG9uIHNwZWNpYWwgZXhlY3V0YWJsZSBwYWdlIG9uIHg4Nl82NC4g
Ki8KLQl1cCgma3Byb2JlX211dGV4KTsKLQlwLT5haW5zbi5pbnNuID0gZ2V0X2luc25fc2xvdCgp
OwogCWRvd24oJmtwcm9iZV9tdXRleCk7CisJcC0+YWluc24uaW5zbiA9IGdldF9pbnNuX3Nsb3Qo
KTsKKwl1cCgma3Byb2JlX211dGV4KTsKIAlpZiAoIXAtPmFpbnNuLmluc24pIHsKIAkJcmV0dXJu
IC1FTk9NRU07CiAJfQpAQCAtMjMxLDkgKzIzMSw5IEBAIHZvaWQgX19rcHJvYmVzIGFyY2hfZGlz
YXJtX2twcm9iZShzdHJ1Y3QKIAogdm9pZCBfX2twcm9iZXMgYXJjaF9yZW1vdmVfa3Byb2JlKHN0
cnVjdCBrcHJvYmUgKnApCiB7Ci0JdXAoJmtwcm9iZV9tdXRleCk7Ci0JZnJlZV9pbnNuX3Nsb3Qo
cC0+YWluc24uaW5zbik7CiAJZG93bigma3Byb2JlX211dGV4KTsKKwlmcmVlX2luc25fc2xvdChw
LT5haW5zbi5pbnNuKTsKKwl1cCgma3Byb2JlX211dGV4KTsKIH0KIAogc3RhdGljIGlubGluZSB2
b2lkIHNhdmVfcHJldmlvdXNfa3Byb2JlKHZvaWQpCg==

------_=_NextPart_001_01C5C48E.D8F74115--
