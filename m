Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbUKVQgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUKVQgB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbUKVQeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:34:23 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15588 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262139AbUKVQDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:03:06 -0500
Message-ID: <41A20DB5.2050302@in.ibm.com>
Date: Mon, 22 Nov 2004 21:33:01 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
References: <419CACE2.7060408@in.ibm.com> <20041119153052.21b387ca.akpm@osdl.org> <1100912759.4987.207.camel@dyn318077bld.beaverton.ibm.com> <200411201204.37750.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200411201204.37750.amgta@yacht.ocn.ne.jp>
Content-Type: multipart/mixed;
 boundary="------------000006040206090300070401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006040206090300070401
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Akinobu Mita wrote:
> I've forgotten CC-ing.
> 
> On Saturday 20 November 2004 10:05, Badari Pulavarty wrote:
> 
> 
>>4) Load the second kernel to be booted using
>>
>>   kexec -p <second-kernel> --args-linux --append="root=<root-dev> dump
>>   init 1 memmap=exactmap memmap=640k@0 memmap=32M@16M"
>>
>>But kexec doesn't seem to like option "-p".
>>Even when I removed "-p", its complaining about "--args-linux"


There is a kexec-tools patch that is required to get the "-p" option
working. I had sent it out only to the fastboot mailing list without
updating kdump documentation. I will send out an updated documentation
patch indicating this requirement (I will host the patch on some site
and point to it in the document).

Meanwhile, I am attaching the patch with this note. Kindly try kdump
with this. Thanks!

Regards, Hari


--------------000006040206090300070401
Content-Type: text/plain;
 name="kexec-tools-panic.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kexec-tools-panic.patch"

ClNpZ25lZC1vZmYtYnk6IEhhcmlwcmFzYWQgTmVsbGl0aGVlcnRoYSA8aGFyaUBpbi5pYm0u
Y29tPgoKCi0tLQoKIGtleGVjLXRvb2xzLTEuOTUtaGFyaS9rZXhlYy9rZXhlYy5jIHwgICAx
MCArKysrKysrKystCiBrZXhlYy10b29scy0xLjk1LWhhcmkva2V4ZWMva2V4ZWMuaCB8ICAg
IDYgKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC1wdU4ga2V4ZWMva2V4ZWMuY35rZXhlYy10b29scy1wYW5pYyBrZXhl
Yy9rZXhlYy5jCi0tLSBrZXhlYy10b29scy0xLjk1L2tleGVjL2tleGVjLmN+a2V4ZWMtdG9v
bHMtcGFuaWMJMjAwNC0xMC0xOCAxNDoyNzoyNy4wMDAwMDAwMDAgKzA1MzAKKysrIGtleGVj
LXRvb2xzLTEuOTUtaGFyaS9rZXhlYy9rZXhlYy5jCTIwMDQtMTAtMTkgMjE6MDA6MjMuMDAw
MDAwMDAwICswNTMwCkBAIC0zMCw2ICszMCw3IEBACiAvKiBsb2NhbCB2YXJpYWJsZXMgKi8K
IHN0YXRpYyBzdHJ1Y3QgbWVtb3J5X3JhbmdlICptZW1vcnlfcmFuZ2U7CiBzdGF0aWMgaW50
IG1lbW9yeV9yYW5nZXM7CitzdGF0aWMgdW5zaWduZWQgbG9uZyBsb2FkX2ZsYWdzOwogCiBp
bnQgdmFsaWRfbWVtb3J5X3JhbmdlKHN0cnVjdCBrZXhlY19zZWdtZW50ICpzZWdtZW50KQog
ewpAQCAtMjQzLDcgKzI0NCw3IEBAIHN0YXRpYyBpbnQgbXlfbG9hZChjb25zdCBjaGFyICp0
eXBlLCBpbnQKIAlpZiAoc29ydF9zZWdtZW50cyhzZWdtZW50cywgbnJfc2VnbWVudHMpIDwg
MCkgewogCQlyZXR1cm4gLTE7CiAJfQotCXJlc3VsdCA9IGtleGVjX2xvYWQoZW50cnksIG5y
X3NlZ21lbnRzLCBzZWdtZW50cywgMCk7CisJcmVzdWx0ID0ga2V4ZWNfbG9hZChlbnRyeSwg
bnJfc2VnbWVudHMsIHNlZ21lbnRzLCBsb2FkX2ZsYWdzKTsKIAlpZiAocmVzdWx0ICE9IDAp
IHsKIAkJLyogVGhlIGxvYWQgZmFpbGVkLCBwcmludCBzb21lIGRlYnVnZ2luZyBpbmZvcm1h
dGlvbiAqLwogCQlmcHJpbnRmKHN0ZGVyciwgImtleGVjX2xvYWQgZmFpbGVkOiAlc1xuIiwK
QEAgLTMyNSw2ICszMjYsNyBAQCB2b2lkIHVzYWdlKHZvaWQpCiAJCSIgLXUsIC0tdW5sb2Fk
ICAgICAgVW5sb2FkIHRoZSBjdXJyZW50IGtleGVjIHRhcmdldCBrZXJuZWwuXG4iCiAJCSIg
LWUsIC0tZXhlYyAgICAgICAgRXhlY3V0ZSBhIGN1cnJlbnRseSBsb2FkZWQga2VybmVsLlxu
IgogCQkiIC10LCAtLXR5cGU9VFlQRSAgIFNwZWNpZnkgdGhlIG5ldyBrZXJuZWwgaXMgb2Yg
dGhpcyB0eXBlLlxuIgorCQkiIC1wLCAtLWxvYWQtcGFuaWMgIExvYWQga2VybmVsIGZvciB0
aGUgcmVib290IG9uIHBhbmljIGNhc2UuXG4iCiAJCSJcbiIKIAkJIlN1cHBvcnRlZCBrZXJu
ZWwgZmlsZSB0eXBlcyBhbmQgb3B0aW9uczogXG4iCiAJCSk7CkBAIC0zOTMsNiArMzk1LDEy
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJCWNhc2UgT1BUX1RZUEU6
CiAJCQl0eXBlID0gb3B0YXJnOwogCQkJYnJlYWs7CisJCWNhc2UgT1BUX1BBTklDOgorCQkJ
ZG9fbG9hZCA9IDE7CisJCQlkb19leGVjID0gMDsKKwkJCWRvX3NodXRkb3duID0gMDsKKwkJ
CWxvYWRfZmxhZ3MgPSAxOworCQkJYnJlYWs7CiAJCWRlZmF1bHQ6CiAJCQlicmVhazsKIAkJ
fQpkaWZmIC1wdU4ga2V4ZWMva2V4ZWMuaH5rZXhlYy10b29scy1wYW5pYyBrZXhlYy9rZXhl
Yy5oCi0tLSBrZXhlYy10b29scy0xLjk1L2tleGVjL2tleGVjLmh+a2V4ZWMtdG9vbHMtcGFu
aWMJMjAwNC0xMC0xOCAxNDozNjoyMy4wMDAwMDAwMDAgKzA1MzAKKysrIGtleGVjLXRvb2xz
LTEuOTUtaGFyaS9rZXhlYy9rZXhlYy5oCTIwMDQtMTAtMjAgMTQ6MDk6NDYuMDAwMDAwMDAw
ICswNTMwCkBAIC00NSw2ICs0NSw3IEBAIGV4dGVybiBpbnQgZmlsZV90eXBlczsKICNkZWZp
bmUgT1BUX0xPQUQJCSdsJwogI2RlZmluZSBPUFRfVU5MT0FECQkndScKICNkZWZpbmUgT1BU
X1RZUEUJCSd0JworI2RlZmluZSBPUFRfUEFOSUMJCSdwJwogI2RlZmluZSBPUFRfTUFYCQkJ
MjU2CiAjZGVmaW5lIEtFWEVDX09QVElPTlMgXAogCXsgImhlbHAiLAkJMCwgMCwgT1BUX0hF
TFAgfSwgXApAQCAtNTQsNyArNTUsOCBAQCBleHRlcm4gaW50IGZpbGVfdHlwZXM7CiAJeyAi
bG9hZCIsCQkwLCAwLCBPUFRfTE9BRCB9LCBcCiAJeyAidW5sb2FkIiwJCTAsIDAsIE9QVF9V
TkxPQUQgfSwgXAogCXsgImV4ZWMiLAkJMCwgMCwgT1BUX0VYRUMgfSwgXAotCXsgInR5cGUi
LAkJMSwgMCwgT1BUX1RZUEUgfSwgCi0jZGVmaW5lIEtFWEVDX09QVF9TVFIgImh2ZGZ4bHVl
dDoiCisJeyAidHlwZSIsCQkxLCAwLCBPUFRfVFlQRSB9LCBcCisJeyAicGFuaWMiLAkJMCwg
MCwgT1BUX1BBTklDIH0sCisjZGVmaW5lIEtFWEVDX09QVF9TVFIgImh2ZGZ4bHVldDpwIgog
CiAjZW5kaWYgLyogS0VYRUNfSCAqLwoKXwo=
--------------000006040206090300070401--
