Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUCLWbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUCLWbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:31:18 -0500
Received: from fmr05.intel.com ([134.134.136.6]:21912 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263001AbUCLWbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:31:15 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C40881.B32BBB0C"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Kernel 2.6.3 patch for Intel Compiler 8.0
Date: Fri, 12 Mar 2004 14:31:02 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173FEB957@scsmsx402.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.3 patch for Intel Compiler 8.0
Thread-Index: AcQGNbFZ4p/HfpUdR8GS+lTurHorBACRW1HQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Ingo at Pyrillion" <ingo@pyrillion.org>,
       "Norberto Bensa" <norberto+linux-kernel@bensa.ath.cx>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Mar 2004 22:31:03.0078 (UTC) FILETIME=[B3A25460:01C40881]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C40881.B32BBB0C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ingo, Hi

We tried it (2.6.4) our side. As long as we tested, we did not need _any
changes_ to the kernel tree, and I guess what you are missing is a shell
script that calls icc converting the GCC specific options to Intel
compiler.

Attached is the script. Just type "make CC=3Dkicc" for example.

Can you be more specific about the issue with dec_and_lock.c?

Jun

> Hi Jun,
>=20
> the patch I submitted is for icc 8.0, i.e. I386 platform only.
>
> Did I understand your last message right that you even do not
> need a kernel patch for icc, i.e. I386?
>
> If so, then try to compile the 2.6.3 kernel using icc without
> applying my patch and see what happens if icc "tries" to compile
> hybrid code, i.e. mixed assembly and C statements....
> The current icc 8.0 (and also icc 7.0) makes FATAL mistakes
> compiling those mixings. Just check the object file that results
> from "dec_and_lock.c" in arch/i386/lib using a disassembler.
>
> Rgs, Ingo.
 <<kicc>>=20

------_=_NextPart_001_01C40881.B32BBB0C
Content-Type: application/octet-stream;
	name="kicc"
Content-Transfer-Encoding: base64
Content-Description: kicc
Content-Disposition: attachment;
	filename="kicc"

IyBLZXJuZWwgaWNjCiMgVGhpcyBpcyBhIHdyYXBlciBhcm91bmQgaWNjIHRvIGJlIGNvbXBhdGli
bGUgd2l0aCBnY2MgIGZvciBrZXJuZWwgYnVpbGQKIwoKQVJHUz0kQAoKSUNDQVJHUz0iLWlwbyAt
aXBvX29iaiIKS0VSTkFSR1M9IlwKLURfX0dOVUNfXz0zIC1EX19HTlVDX01JTk9SX189MCIKCk5F
V0FSR1M9IiRJQ0NBUkdTIgoKaWYgWyAteiAiJEdDQyIgXSAKdGhlbgoJR0NDPS91c3IvYmluL2dj
YwpmaQoKZm9yIEFSRyBpbiAkQCAgCmRvCgpjYXNlICRBUkcgaW4KLURfX0tFUk5FTF9fICkKCU5F
V0FSR1M9IiRORVdBUkdTICRLRVJOQVJHUyAkQVJHIgoJOzsKCi1PMiB8IC1PMyApCglORVdBUkdT
PSIkTkVXQVJHUyAtTzMiCgk7OwoKLXYgKQoJaWNjIC1WIDI+JjEgfCBncmVwICJWZXJzaW9uXHxJ
bnRlbChSKSIgfCAgcGVybCAtcGkgLWUgJ3RyL1xuLyAvZDsnCglleGl0IDAKCTs7CgotaGVscCAp
CglpY2MgLWhlbHAKCWVjaG8KCWVjaG8ga2ljYzogV3JhcHBlciBhcm91bmQgaWNjIGZvciBnY2Mg
Y29tcGF0aWJpbGl0eQoJZXhpdCAgJD8KCTs7CgotbWFyY2g9aTY4NiApCglORVdBUkdTPSIkTkVX
QVJHUyAtdHBwNiIKCTs7CgotbWFyY2g9cGVudGl1bTQgKQoJTkVXQVJHUz0iJE5FV0FSR1MgLXRw
cDciCgk7OwoKL2Rldi9udWxsIHwgKi5TICkKICAgICAgICAkR0NDICRBUkdTCiAgICAgICAgZXhp
dCAkPwogICAgICAgIDs7CgoKIyBpZ25vcmUgdGhlc2UgZ2NjIG9wdGlvbnMKLVdzdHJpY3QtcHJv
dG90eXBlcyB8IC1Xd3JpdGUtc3RyaW5ncyB8IC1XaW5saW5lIHwgLVduby11bmluaXRpYWxpemVk
IAlcCnwgLVduby1mb3JtYXQgfCAtV25vLXRyaWdyYXBocyB8IC1Xbm8tdW51c2VkIHwgLW5vc3Rk
aW5jIHwgLVdhbGwJXAp8IC1mbm8taW5saW5lLWZ1bmN0aW9ucyB8IC1maW5oaWJpdC1zaXplLWRp
cmVjdGl2ZSB8IC1mbm8tZXhjZXB0aW9ucyAJXAp8IC1mbm8taW5saW5lIHwgLWZmbG9hdC1zdG9y
ZSB8IC1mbm8tYnVpbHRpbiB8IC1mZXhjZXB0aW9ucyB8IC1waXBlIAlcCnwgLWZvbWl0LWZyYW1l
LXBvaW50ZXIgfCAtLXBhcmFtIHwgbWF4LWlubGluZS1pbnNucz0qIAkJCVwKfCAtZnJlbmFtZS1y
ZWdpc3RlcnMgfCAtZmFsaWduLWZ1bmN0aW9ucz0qIHwgLWZuby1zdHJpY3QtYWxpYXNpbmcgCVwK
fCAtZm5vLWNvbW1vbiB8IC1mZml4ZWQtcjEzIHwgLW1iLXN0ZXAgfCAtdHJhZGl0aW9uYWwgCQkJ
XAp8IC1tcHJlZmVycmVkLXN0YWNrLWJvdW5kYXJ5PTIgfCAtbWFyY2g9KiB8IC1tYWxpZ24tZnVu
Y3Rpb25zPSogCVwKfCAtbWFsaWduLWp1bXBzPSogfCAtbWFsaWduLWxvb3BzPSogfCAtZ3N0YWJz
ICkKCTs7CgoqICkKCU5FV0FSR1M9IiRORVdBUkdTICRBUkciCgk7Owplc2FjCgpkb25lCgppY2Mg
JE5FV0FSR1MgCmV4aXQgJD8K

------_=_NextPart_001_01C40881.B32BBB0C--
