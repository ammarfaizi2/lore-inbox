Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUJWFFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUJWFFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbUJWFEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:04:32 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:40307 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267939AbUJWEpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:45:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=ST/W3ZIHtDvwX+6ZTL/S92C8b8JvyO3siezfKX1AbcaR27IfqUwggA3KNCavzQT9SLt75q3rvbuDQKrx6E6Z6xb+UvOF61cN1nKrgpSPgI3MHwGOnXr41HCiGCuXm2dVb/lRmDEuc71FTjEXFalcQ1rqbCQ1OtSMDfAQPreYJn8=
Message-ID: <9e473391041022214570eab48a@mail.gmail.com>
Date: Sat, 23 Oct 2004 00:45:42 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH} Trivial - fix drm_agp symbol export
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2636_23137178.1098506742318"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2636_23137178.1098506742318
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Exports the symbol for drm agp entry points. This allows the new drm
linux-core module to get the symbol with symbol_get() instead of
inter_module_get(). After the new drm code arrives inter_module_xx
code in AGP can be deleted.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_2636_23137178.1098506742318
Content-Type: application/octet-stream; name="agp_patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="agp_patch"

PT09PT0gZHJpdmVycy9jaGFyL2FncC9iYWNrZW5kLmMgMS45MSB2cyBlZGl0ZWQgPT09PT0KLS0t
IDEuOTEvZHJpdmVycy9jaGFyL2FncC9iYWNrZW5kLmMJMjAwNC0wNi0wMSAwNDowMDowNSAtMDQ6
MDAKKysrIGVkaXRlZC9kcml2ZXJzL2NoYXIvYWdwL2JhY2tlbmQuYwkyMDA0LTEwLTIzIDAwOjM5
OjAwIC0wNDowMApAQCAtMjE0LDcgKzIxNCw3IEBACiAJCQkJcGh5c190b192aXJ0KGJyaWRnZS0+
c2NyYXRjaF9wYWdlX3JlYWwpKTsKIH0KIAotc3RhdGljIGNvbnN0IGRybV9hZ3BfdCBkcm1fYWdw
ID0geworY29uc3QgZHJtX2FncF90IGRybV9hZ3BfZW50cnkgPSB7CiAJJmFncF9mcmVlX21lbW9y
eSwKIAkmYWdwX2FsbG9jYXRlX21lbW9yeSwKIAkmYWdwX2JpbmRfbWVtb3J5LApAQCAtMjI0LDYg
KzIyNCw3IEBACiAJJmFncF9iYWNrZW5kX3JlbGVhc2UsCiAJJmFncF9jb3B5X2luZm8KIH07CitF
WFBPUlRfU1lNQk9MKGRybV9hZ3BfZW50cnkpOwogCiAvKiBYWFggS2x1ZGdlIGFsZXJ0OiBhZ3Bn
YXJ0IGlzbid0IHJlYWR5IGZvciBtdWx0aXBsZSBicmlkZ2VzIHlldCAqLwogc3RydWN0IGFncF9i
cmlkZ2VfZGF0YSAqYWdwX2FsbG9jX2JyaWRnZSh2b2lkKQpAQCAtMjc4LDcgKzI3OSw3IEBACiAJ
fQogCiAJLyogRklYTUU6IFdoYXQgdG8gZG8gd2l0aCB0aGlzPyAqLwotCWludGVyX21vZHVsZV9y
ZWdpc3RlcigiZHJtX2FncCIsIFRISVNfTU9EVUxFLCAmZHJtX2FncCk7CisJaW50ZXJfbW9kdWxl
X3JlZ2lzdGVyKCJkcm1fYWdwIiwgVEhJU19NT0RVTEUsICZkcm1fYWdwX2VudHJ5KTsKIAogCWFn
cF9jb3VudCsrOwogCXJldHVybiAwOwo9PT09PSBpbmNsdWRlL2xpbnV4L2FncF9iYWNrZW5kLmgg
MS4zNyB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuMzcvaW5jbHVkZS9saW51eC9hZ3BfYmFja2VuZC5o
CTIwMDMtMDUtMjEgMDU6MTU6MjQgLTA0OjAwCisrKyBlZGl0ZWQvaW5jbHVkZS9saW51eC9hZ3Bf
YmFja2VuZC5oCTIwMDQtMTAtMjMgMDA6MzA6MjQgLTA0OjAwCkBAIC0xMTIsNyArMTEyLDcgQEAK
IAlpbnQJCQkoKmNvcHlfaW5mbykoc3RydWN0IGFncF9rZXJuX2luZm8gKik7CiB9IGRybV9hZ3Bf
dDsKIAotZXh0ZXJuIGNvbnN0IGRybV9hZ3BfdCAqZHJtX2FncF9wOworZXh0ZXJuIGNvbnN0IGRy
bV9hZ3BfdCBkcm1fYWdwX2VudHJ5OwogCiAjZW5kaWYJCQkJLyogX19LRVJORUxfXyAqLwogI2Vu
ZGlmCQkJCS8qIF9BR1BfQkFDS0VORF9IICovCg==
------=_Part_2636_23137178.1098506742318--
