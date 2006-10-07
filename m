Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWJGMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWJGMMt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWJGMMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 08:12:49 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:7471 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751007AbWJGMMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 08:12:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=exWY12NaM25HlWnC8yzMPyRbfF7461y0M2jlkMuK972SyzwmlscuoIuvs2e4+8aGZhKdF+yKSRBS7co9HIM9XFxwCFX78Q5dMNE979BJeio7mgq381HfySWmW1Ja6wZI7QyQpT05NL1sZTW3klqhr/12VO5nXW4aPk6juKu7+PU=
Message-ID: <309a667c0610070512y47718898i4a664ef6cce7c312@mail.gmail.com>
Date: Sat, 7 Oct 2006 17:42:47 +0530
From: "Devesh Sharma" <devesh28@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Compiling dependent module
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18407_12249361.1160223167735"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18407_12249361.1160223167735
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I have a situation where, I have one parent module in ../hello/
directory which exports one symbol (g_my_export). I have a dependent
module in ../hello1/ directory. Both have it's own makefiles.
Compiling of parent module (hello.ko) is fine, but during compilation
of dependent module (hello1.ko) I see a warning that g_my_export is
undefined.

On the other hand when I do depmod -a and modprobe, dependent module
inserts successfully in kernel.

I want to remove compile time warning. What should I do?

The source and makefile of both parent and dependent module is
attached with this mail.

Thanks
Devesh.

------=_Part_18407_12249361.1160223167735
Content-Type: text/x-csrc; name=hello.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eszyyno7
Content-Disposition: attachment; filename="hello.c"

I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgpNT0RVTEVf
TElDRU5TRSgiRHVhbCBCU0QvR1BMIik7CgppbnQgZ19teV9leHBvcnQgPSAweEEgOwoKc3RhdGlj
IGludCBoZWxsb19pbml0KHZvaWQpCnsKcHJpbnRrKEtFUk5fQUxFUlQgIkhlbGxvLCB3b3JsZFxu
Iik7CnJldHVybiAwOwp9CnN0YXRpYyB2b2lkIGhlbGxvX2V4aXQodm9pZCkKewpwcmludGsoS0VS
Tl9BTEVSVCAiR29vZGJ5ZSwgY3J1ZWwgd29ybGRcbiIpOwp9CgpFWFBPUlRfU1lNQk9MKGdfbXlf
ZXhwb3J0KSA7Cgptb2R1bGVfaW5pdChoZWxsb19pbml0KTsKbW9kdWxlX2V4aXQoaGVsbG9fZXhp
dCk7Cg==
------=_Part_18407_12249361.1160223167735
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eszz2xjb
Content-Disposition: attachment; filename="Makefile"

IyBJZiBLRVJORUxSRUxFQVNFIGlzIGRlZmluZWQsIHdlJ3ZlIGJlZW4gaW52b2tlZCBmcm9tIHRo
ZQojIGtlcm5lbCBidWlsZCBzeXN0ZW0gYW5kIGNhbiB1c2UgaXRzIGxhbmd1YWdlLgppZm5lcSAo
JChLRVJORUxSRUxFQVNFKSwpCm9iai1tIDo9IGhlbGxvLm8KIyBPdGhlcndpc2Ugd2Ugd2VyZSBj
YWxsZWQgZGlyZWN0bHkgZnJvbSB0aGUgY29tbWFuZAojIGxpbmU7IGludm9rZSB0aGUga2VybmVs
IGJ1aWxkIHN5c3RlbS4KZWxzZQpLRVJORUxESVIgPz0gL2xpYi9tb2R1bGVzLyQoc2hlbGwgdW5h
bWUgLXIpL2J1aWxkCgpQV0QgOj0gJChzaGVsbCBwd2QpCgpkZWZhdWx0OgoJJChNQUtFKSAtQyAk
KEtFUk5FTERJUikgTT0kKFBXRCkgbW9kdWxlcwoKaW5zdGFsbDoKCSQoTUFLRSkgLUMgJChLRVJO
RUxESVIpIE09JChQV0QpIG1vZHVsZXNfaW5zdGFsbAoKY2xlYW46CgkkKE1BS0UpIC1DICQoS0VS
TkVMRElSKSBNPSQoUFdEKSBjbGVhbgoKZW5kaWYK
------=_Part_18407_12249361.1160223167735
Content-Type: text/x-csrc; name=hello1.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eszz32zb
Content-Disposition: attachment; filename="hello1.c"

I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgpNT0RVTEVf
TElDRU5TRSgiRHVhbCBCU0QvR1BMIik7CgpleHRlcm4gaW50IGdfbXlfZXhwb3J0IDsKCnN0YXRp
YyBpbnQgaGVsbG9faW5pdCh2b2lkKQp7CiAgICBwcmludGsoS0VSTl9BTEVSVCAiSGVsbG8sIHdv
cmxkMVxuIik7CiAgICAKICAgIHByaW50aygiVmFsdWUgaW4gZ19teV9leHBvcnQ9JWRcbiIsZ19t
eV9leHBvcnQpIDsKcmV0dXJuIDA7Cn0Kc3RhdGljIHZvaWQgaGVsbG9fZXhpdCh2b2lkKQp7CnBy
aW50ayhLRVJOX0FMRVJUICJHb29kYnllLCBjcnVlbCB3b3JsZDFcbiIpOwp9Cgptb2R1bGVfaW5p
dChoZWxsb19pbml0KTsKbW9kdWxlX2V4aXQoaGVsbG9fZXhpdCk7Cg==
------=_Part_18407_12249361.1160223167735
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eszz38k8
Content-Disposition: attachment; filename="Makefile"

IyBJZiBLRVJORUxSRUxFQVNFIGlzIGRlZmluZWQsIHdlJ3ZlIGJlZW4gaW52b2tlZCBmcm9tIHRo
ZQojIGtlcm5lbCBidWlsZCBzeXN0ZW0gYW5kIGNhbiB1c2UgaXRzIGxhbmd1YWdlLgppZm5lcSAo
JChLRVJORUxSRUxFQVNFKSwpCm9iai1tIDo9IGhlbGxvMS5vCiMgT3RoZXJ3aXNlIHdlIHdlcmUg
Y2FsbGVkIGRpcmVjdGx5IGZyb20gdGhlIGNvbW1hbmQKIyBsaW5lOyBpbnZva2UgdGhlIGtlcm5l
bCBidWlsZCBzeXN0ZW0uCmVsc2UKS0VSTkVMRElSID89IC9saWIvbW9kdWxlcy8kKHNoZWxsIHVu
YW1lIC1yKS9idWlsZAoKUFdEIDo9ICQoc2hlbGwgcHdkKQoKZGVmYXVsdDoKCSQoTUFLRSkgLUMg
JChLRVJORUxESVIpIE09JChQV0QpIG1vZHVsZXMKCmluc3RhbGw6CgkkKE1BS0UpIC1DICQoS0VS
TkVMRElSKSBNPSQoUFdEKSBtb2R1bGVzX2luc3RhbGwKCmNsZWFuOgoJJChNQUtFKSAtQyAkKEtF
Uk5FTERJUikgTT0kKFBXRCkgY2xlYW4KCmVuZGlmCg==
------=_Part_18407_12249361.1160223167735--
