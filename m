Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754887AbWKZXYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbWKZXYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbWKZXYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:24:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:58295 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1754887AbWKZXYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:24:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=WagMR5vNIwXz51/A7boC0wrdFpAjFwJPcDlkFu1zM1kNPcuHbJ3Y45U7o62kOUejp47EzPeAwFjOrefUPubWqK0fwrWLcNi0Geu1tS1WDCqrFtFh7E3lldrsimC7wTOlTwcOTnnWPffWB0JMamAscnTOA/+1aqHGxJ5XxBrcFVY=
Message-ID: <86802c440611261524p6b170f50rf7db3eafd4f7602e@mail.gmail.com>
Date: Sun, 26 Nov 2006 15:24:32 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/3] x86: when acpi_noirq is set, use mptable instead of MADT
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_60601_20367167.1164583472873"
X-Google-Sender-Auth: 29e08edf71f248a2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_60601_20367167.1164583472873
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



------=_Part_60601_20367167.1164583472873
Content-Type: text/x-patch; name="ai_3.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ai_3.diff"
X-Attachment-Id: f_ev02wv6c

W1BBVENIIDMvM10geDg2OiB3aGVuIGFjcGlfbm9pcnEgaXMgc2V0LCB1c2UgbXB0YWJsZSBpbnN0
ZWFkIG9mIE1BRFQKCldoZW4gdXNpbmcgcGNpPW5vYWNwaSwgb3IgYXBjaT1ub2lycSwgYWNwaV9u
b2lycSBpcyBzZXQuIFdlIHNob3VsZCBza2lwCmFjcGlfcHJvY2Vzc19tYWR0LiBCZWNhdXNlIGl0
IHdpbGwgc2V0IGFjcGlfbGFwaWMgYW5kIGFjcGlfaW9hcGljLCBhdCBsYXN0Cm1wdGFibGUgaXMg
c2tpcHBlZCwgYnV0IHdlIG5lZWQgaW8gYXBpYyByb3V0aW5nIHRhYmxlIGluIG1wdGFibGUuCgpT
aWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1IDx5aW5naGFpLmx1QGFtZC5jb20+CgpkaWZmIC0tZ2l0
IGEvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL2Jvb3QuYyBiL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS9i
b290LmMKaW5kZXggZDEyZmI5Ny4uNmQ2MmRkMSAxMDA2NDQKLS0tIGEvYXJjaC9pMzg2L2tlcm5l
bC9hY3BpL2Jvb3QuYworKysgYi9hcmNoL2kzODYva2VybmVsL2FjcGkvYm9vdC5jCkBAIC0xMjQy
LDcgKzEyNDIsMTUgQEAgaW50IF9faW5pdCBhY3BpX2Jvb3RfaW5pdCh2b2lkKQogCS8qCiAJICog
UHJvY2VzcyB0aGUgTXVsdGlwbGUgQVBJQyBEZXNjcmlwdGlvbiBUYWJsZSAoTUFEVCksIGlmIHBy
ZXNlbnQKIAkgKi8KLQlhY3BpX3Byb2Nlc3NfbWFkdCgpOworCS8qIHdpdGggYWNwaV9ub2lycSB3
ZSBkb24ndCBuZWVkIHRvIHByb2Nlc3MgbWFkdCwgaXQgd2lsbCBzZXQKKwkgKglhY3BpX2xhcGlj
IGFuZCBhY3BpX2lvYXBpYywgdGhleSB3aWxsIG1ha2UgZ2V0X3NtcF9jb25maWcgYWthLgorCSAq
CU1QVEFCTEUgYmUgc2tpcHBlZCBhbmQgbXBfaXJxcyB3aWxsIG5vdCBpbmNsdWRlIGVudHJpZXMg
Zm9yIAorCSAqCWlycSByb3V0aW5nIGZvciBpbyBhcGljLCB0aGVuIHBpcnFfZW5hYmxlX2lycSB0
b2dldGhlciB3aXRoIAorCSAqIAlJT19BUElDX2dldF9QQ0lfaXJxX3ZlY3RvciBjYW4gbm90IGZp
bmQgaXJxIGluIG1wX2lycXMgZm9yIAorCSAqIAlkZXZpY2VzIHRoYXQgYXJlIHVzaW5nIElPQVBJ
QworCSAqLworCWlmKCFhY3BpX25vaXJxICYmICFhY3BpX3BjaV9kaXNhYmxlZCkKKwkJYWNwaV9w
cm9jZXNzX21hZHQoKTsKIAogCWFjcGlfdGFibGVfcGFyc2UoQUNQSV9IUEVULCBhY3BpX3BhcnNl
X2hwZXQpOwogCg==
------=_Part_60601_20367167.1164583472873--
