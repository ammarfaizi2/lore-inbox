Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVERVda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVERVda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVERVdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:33:24 -0400
Received: from mail2.dolby.com ([204.156.147.24]:5899 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S262389AbVERVcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:32:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Illegal use of reserved word in system.h
Date: Wed, 18 May 2005 14:31:55 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA08B08670@bronze.dolby.net>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Illegal use of reserved word in system.h
Thread-Index: AcVb4HYOPIRgULXKSZ6TjAdnkjpQZwABPUIw
From: "Gilbert, John" <JGG@dolby.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C55BF1.0359A13E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.


------_=_NextPart_001_01C55BF1.0359A13E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=0D=0ARichard B=2E Johnson writes:=0D=0A=0D=0AThe subject line is invalid=
=2E We don't make law here=2E=0D=0AThe correct word is invalid, not illegal=
=2E There should not be any=0D=0A"illegal" strings in the kernel either alt=
hough they sometimes creep=0D=0Ain=2E=2E=2E=0D=0A=0D=0A#JG=0D=0ASorry, I wa=
s borrowing the term from the g++ error that this created=2E=0D=0AI'm not t=
rying to imply that someone should be arrested=2E ;^) Also, like=0D=0Aa few=
 people have already mentioned, it doesn't effect the kernel at all=0D=0Aas=
 it's strictly a C program=2E=0D=0A=0D=0ANow, if you want the names of stru=
cture members changed, you are going=0D=0Ato have to submit a patch=2E You =
will also have to patch anything that=0D=0Aaccesses those member names in u=
ser-mode=2E=0D=0ANobody is going to do it for you=2E=0D=0A	=0D=0A#JG=0D=0AT=
hey are very trivial patches, but I'll include them here=2E=0D=0A=0D=0AIt's=
 also quite presumptuous of you that you think that you can instruct=0D=0Aa=
ny of the kernel developers on how to write header files=2E In addition,=0D=
=0Aany user-mode code that uses kernel headers is broken by definition=2E=
=0D=0AThere is no other operating system except BSD that gives user mode co=
de=0D=0Aaccess to kernel-headers=2E Somehow, people have been able to write=
=0D=0Aworking code using those operating systems without using kernel heade=
rs=2E=0D=0A=0D=0A#JG=0D=0AIncluding header files might be bad practice, but=
 it's not uncommon, and=0D=0Aonly truly broken when the kernel changes=2E I=
 know many reasons for why=0D=0Ait's bad, but I also know that it's sometim=
es necessary (see below)=2E=0D=0AIt's also usually not my code that breaks,=
 but I often have to fix it if=0D=0AI want to get the program to work=2E=0D=
=0A=0D=0AThere are people who can instruct you in the proper methods of=0D=
=0Ainterfacing with the kernel=2E There are even many books that have been=
=0D=0Awritten=2E I suggest that if you have a driver that requires access t=
o=0D=0Akernel headers, when being accessed by user-mode code, the driver is=
=0D=0Abroken=2E Unix/linux provides standard methods of interface to driver=
s=2E=0D=0AThey include open(), close(), read(), write(), mmap() and ioctl()=
=2E In=0D=0Aaddition, there are various semaphores and signaling mechanisms=
 like=0D=0Apoll()=2E If you are accessing devices or kernel functions in ot=
her than=0D=0Athese standard interfaces, your code is broken beyond all rep=
air=2E=0D=0A=0D=0A#JG=0D=0AAs a counter-example, I'm including a program th=
at uses /dev/dri to=0D=0Aframelock to vsync=2E It's stupid in multiple ways=
 but it seems to be=0D=0Acurrently the only semi-portable way to do this un=
der X windows=2E It also=0D=0Auses two kernel headers, and if you read thro=
ugh the code, it's spin=0D=0Awaiting for the ioctl call to return the right=
 value, sometimes skipping=0D=0Aa frame=2E If you patch this into a C++ pro=
gram with the stock kernel=0D=0Aheaders, it breaks (the drm=2Eh and drm_buf=
s=2Ec patches fix this)=2E=0D=0AI'd really appreciate if some kernel develo=
per enabled the "Correct" way=0D=0Ato do this=2E If there was a way to wake=
 a thread (a blocking read on=0D=0A/dev/vsync?) on a video vsync interrupt,=
 a lot of media players, games,=0D=0Aand other real-time graphics dependant=
 programs could take less system=0D=0Aresources, and have better quality gr=
aphics=2E In the meantime however,=0D=0Athis mostly works today (with patch=
ed kernel headers)=2E=0D=0A=0D=0A=0D=0AAlso kernel headers don't show if th=
e system the SQL code is running on=0D=0Ais SMP aware and Ray was much bett=
er behaved=2E=0D=0A=0D=0A#JG=0D=0AAccording to Adrian Bunk, MySQL is using =
inlines from asm/atomic=2Eh (yes,=0D=0Avery bad)=2E The fact they set CONFI=
G_SMP manually to expose some=0D=0Aadditional code, but not setting the cpu=
 count variables breaks builds=0D=0Aunder later 2=2E6 kernels=2E See http:/=
/bugs=2Emysql=2Ecom/bug=2Ephp?id=3D10364=0D=0AAgain, it's not my code=2E Tw=
eaking a few kernel headers is easier than=0D=0Afixing everyone else's bad =
code practices=2E=0D=0A=0D=0AJohn Gilbert=0D=0A=0D=0A=0D=0A=0D=0A=0D=0A----=
-------------------------------------=0D=0AThis message (including any atta=
chments) may contain confidential=0D=0Ainformation intended for a specific =
individual and purpose=2E  If you are not=0D=0Athe intended recipient, dele=
te this message=2E  If you are not the intended=0D=0Arecipient, disclosing,=
 copying, distributing, or taking any action based on=0D=0Athis message is =
strictly prohibited=2E=0D=0A
------_=_NextPart_001_01C55BF1.0359A13E
Content-Type: application/octet-stream;
	name="patch.system.h"
Content-Transfer-Encoding: base64
Content-Description: patch.system.h
Content-Disposition: attachment;
	filename="patch.system.h"

LS0tIHN5c3RlbS5oLm9yaWcJMjAwNS0wNS0xNyAxNzo0Mjo1MC4wMDAwMDAwMDAgLTA3MDAKKysr
IHN5c3RlbS5oCTIwMDUtMDUtMTcgMTc6NDM6MTguMDAwMDAwMDAwIC0wNzAwCkBAIC0yNDQsMjYg
KzI0NCwyNiBAQAogI2VuZGlmCiAKIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBfX2NtcHhj
aGcodm9sYXRpbGUgdm9pZCAqcHRyLCB1bnNpZ25lZCBsb25nIG9sZCwKLQkJCQkgICAgICB1bnNp
Z25lZCBsb25nIG5ldywgaW50IHNpemUpCisJCQkJICAgICAgdW5zaWduZWQgbG9uZyBteW5ldywg
aW50IHNpemUpCiB7CiAJdW5zaWduZWQgbG9uZyBwcmV2OwogCXN3aXRjaCAoc2l6ZSkgewogCWNh
c2UgMToKIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9DS19QUkVGSVggImNtcHhjaGdiICViMSwl
MiIKIAkJCQkgICAgIDogIj1hIihwcmV2KQotCQkJCSAgICAgOiAicSIobmV3KSwgIm0iKCpfX3hn
KHB0cikpLCAiMCIob2xkKQorCQkJCSAgICAgOiAicSIobXluZXcpLCAibSIoKl9feGcocHRyKSks
ICIwIihvbGQpCiAJCQkJICAgICA6ICJtZW1vcnkiKTsKIAkJcmV0dXJuIHByZXY7CiAJY2FzZSAy
OgogCQlfX2FzbV9fIF9fdm9sYXRpbGVfXyhMT0NLX1BSRUZJWCAiY21weGNoZ3cgJXcxLCUyIgog
CQkJCSAgICAgOiAiPWEiKHByZXYpCi0JCQkJICAgICA6ICJxIihuZXcpLCAibSIoKl9feGcocHRy
KSksICIwIihvbGQpCisJCQkJICAgICA6ICJxIihteW5ldyksICJtIigqX194ZyhwdHIpKSwgIjAi
KG9sZCkKIAkJCQkgICAgIDogIm1lbW9yeSIpOwogCQlyZXR1cm4gcHJldjsKIAljYXNlIDQ6CiAJ
CV9fYXNtX18gX192b2xhdGlsZV9fKExPQ0tfUFJFRklYICJjbXB4Y2hnbCAlMSwlMiIKIAkJCQkg
ICAgIDogIj1hIihwcmV2KQotCQkJCSAgICAgOiAicSIobmV3KSwgIm0iKCpfX3hnKHB0cikpLCAi
MCIob2xkKQorCQkJCSAgICAgOiAicSIobXluZXcpLCAibSIoKl9feGcocHRyKSksICIwIihvbGQp
CiAJCQkJICAgICA6ICJtZW1vcnkiKTsKIAkJcmV0dXJuIHByZXY7CiAJfQo=

------_=_NextPart_001_01C55BF1.0359A13E
Content-Type: application/octet-stream;
	name="patch.drm_bufs.c"
Content-Transfer-Encoding: base64
Content-Description: patch.drm_bufs.c
Content-Disposition: attachment;
	filename="patch.drm_bufs.c"

LS0tIGRybV9idWZzLmMub3JpZwkyMDA1LTAzLTI5IDE0OjUxOjUxLjAwMDAwMDAwMCAtMDgwMAor
KysgZHJtX2J1ZnMuYwkyMDA1LTAzLTI5IDE0OjUzOjEyLjAwMDAwMDAwMCAtMDgwMApAQCAtMTE2
Myw3ICsxMTYzLDcgQEAKIAlkcm1fYnVmX21hcF90IF9fdXNlciAqYXJncCA9ICh2b2lkIF9fdXNl
ciAqKWFyZzsKIAlpbnQgcmV0Y29kZSA9IDA7CiAJY29uc3QgaW50IHplcm8gPSAwOwotCXVuc2ln
bmVkIGxvbmcgdmlydHVhbDsKKwl1bnNpZ25lZCBsb25nIHZpcnRfbWFwOwogCXVuc2lnbmVkIGxv
bmcgYWRkcmVzczsKIAlkcm1fYnVmX21hcF90IHJlcXVlc3Q7CiAJaW50IGk7CkBAIC0xMTk5LDcg
KzExOTksNyBAQAogI2Vsc2UKIAkJCWRvd25fd3JpdGUoICZjdXJyZW50LT5tbS0+bW1hcF9zZW0g
KTsKICNlbmRpZgotCQkJdmlydHVhbCA9IGRvX21tYXAoIGZpbHAsIDAsIG1hcC0+c2l6ZSwKKwkJ
CXZpcnRfbWFwID0gZG9fbW1hcCggZmlscCwgMCwgbWFwLT5zaXplLAogCQkJCQkgICBQUk9UX1JF
QUQgfCBQUk9UX1dSSVRFLAogCQkJCQkgICBNQVBfU0hBUkVELAogCQkJCQkgICAodW5zaWduZWQg
bG9uZyltYXAtPm9mZnNldCApOwpAQCAtMTIxNCw3ICsxMjE0LDcgQEAKICNlbHNlCiAJCQlkb3du
X3dyaXRlKCAmY3VycmVudC0+bW0tPm1tYXBfc2VtICk7CiAjZW5kaWYKLQkJCXZpcnR1YWwgPSBk
b19tbWFwKCBmaWxwLCAwLCBkbWEtPmJ5dGVfY291bnQsCisJCQl2aXJ0X21hcCA9IGRvX21tYXAo
IGZpbHAsIDAsIGRtYS0+Ynl0ZV9jb3VudCwKIAkJCQkJICAgUFJPVF9SRUFEIHwgUFJPVF9XUklU
RSwKIAkJCQkJICAgTUFQX1NIQVJFRCwgMCApOwogI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8PSAw
eDAyMDQwMgpAQCAtMTIyMywxMiArMTIyMywxMiBAQAogCQkJdXBfd3JpdGUoICZjdXJyZW50LT5t
bS0+bW1hcF9zZW0gKTsKICNlbmRpZgogCQl9Ci0JCWlmICggdmlydHVhbCA+IC0xMDI0VUwgKSB7
CisJCWlmICggdmlydF9tYXAgPiAtMTAyNFVMICkgewogCQkJLyogUmVhbCBlcnJvciAqLwotCQkJ
cmV0Y29kZSA9IChzaWduZWQgbG9uZyl2aXJ0dWFsOworCQkJcmV0Y29kZSA9IChzaWduZWQgbG9u
Zyl2aXJ0X21hcDsKIAkJCWdvdG8gZG9uZTsKIAkJfQotCQlyZXF1ZXN0LnZpcnR1YWwgPSAodm9p
ZCBfX3VzZXIgKil2aXJ0dWFsOworCQlyZXF1ZXN0LnZpcnRfbWFwID0gKHZvaWQgX191c2VyICop
dmlydF9tYXA7CiAKIAkJZm9yICggaSA9IDAgOyBpIDwgZG1hLT5idWZfY291bnQgOyBpKysgKSB7
CiAJCQlpZiAoIGNvcHlfdG9fdXNlciggJnJlcXVlc3QubGlzdFtpXS5pZHgsCkBAIC0xMjQ5LDcg
KzEyNDksNyBAQAogCQkJCXJldGNvZGUgPSAtRUZBVUxUOwogCQkJCWdvdG8gZG9uZTsKIAkJCX0K
LQkJCWFkZHJlc3MgPSB2aXJ0dWFsICsgZG1hLT5idWZsaXN0W2ldLT5vZmZzZXQ7IC8qICoqKiAq
LworCQkJYWRkcmVzcyA9IHZpcnRfbWFwICsgZG1hLT5idWZsaXN0W2ldLT5vZmZzZXQ7IC8qICoq
KiAqLwogCQkJaWYgKCBjb3B5X3RvX3VzZXIoICZyZXF1ZXN0Lmxpc3RbaV0uYWRkcmVzcywKIAkJ
CQkJICAgJmFkZHJlc3MsCiAJCQkJCSAgIHNpemVvZihhZGRyZXNzKSApICkgewo=

------_=_NextPart_001_01C55BF1.0359A13E
Content-Type: application/octet-stream;
	name="patch.drm.h"
Content-Transfer-Encoding: base64
Content-Description: patch.drm.h
Content-Disposition: attachment;
	filename="patch.drm.h"

LS0tIGRybS5oLm9yaWcJMjAwNS0wMy0yOSAxMjoyNDoxOS4wMDAwMDAwMDAgLTA4MDAKKysrIGRy
bS5oCTIwMDUtMDMtMjkgMTI6MjU6NDEuMDAwMDAwMDAwIC0wODAwCkBAIC00MTEsNyArNDExLDcg
QEAKICAqLwogdHlwZWRlZiBzdHJ1Y3QgZHJtX2J1Zl9tYXAgewogCWludAkgICAgICBjb3VudDsJ
LyoqPCBMZW5ndGggb2YgdGhlIGJ1ZmZlciBsaXN0ICovCi0Jdm9pZAkgICAgICBfX3VzZXIgKnZp
cnR1YWw7CS8qKjwgTW1hcCdkIGFyZWEgaW4gdXNlci12aXJ0dWFsICovCisJdm9pZAkgICAgICBf
X3VzZXIgKnZpcnRfbWFwOwkvKio8IE1tYXAnZCBhcmVhIGluIHVzZXItdmlydHVhbCAqLwogCWRy
bV9idWZfcHViX3QgX191c2VyICpsaXN0OwkvKio8IEJ1ZmZlciBpbmZvcm1hdGlvbiAqLwogfSBk
cm1fYnVmX21hcF90OwogCg==

------_=_NextPart_001_01C55BF1.0359A13E
Content-Type: application/octet-stream;
	name="vsync.h"
Content-Transfer-Encoding: base64
Content-Description: vsync.h
Content-Disposition: attachment;
	filename="vsync.h"

LyogQW5vdGhlciB3b3JrIGluIHByb2dyZXNzLCBob3BlIHRvIGJlIGFibGUgdG8gc3luYyB0byB2
ZXJ0aWNhbCByZWZyZXNoICovCgojaWZuZGVmIF9NWVZTWU5DX0gKI2RlZmluZSBfTVlWU1lOQ19I
CgppbnQgZHJpX2luaXQodm9pZCk7CnZvaWQgZHJpX2Nsb3NlKHZvaWQpOwp2b2lkIGRyaV92Ymxh
bmsodm9pZCk7CgojZW5kaWYgLypfTVlWU1lOQ19IKi8K

------_=_NextPart_001_01C55BF1.0359A13E
Content-Type: application/octet-stream;
	name="vsync.c"
Content-Transfer-Encoding: base64
Content-Description: vsync.c
Content-Disposition: attachment;
	filename="vsync.c"

LyogQSB3b3JrIGluIHByb2dyZXNzLCBob3BlIHRvIGhhdmUgYSBzbW9vdGhseSByb3RhdGluZyBj
dXJzZXIgYW5kIGNvdW50IGFzIGZpcnN0IHRlc3Qgb2YgdnN5bmMgKi8KLyogRG9uZS4gd29ya3Mg
cHJldHR5IGdvb2Qgbm93LCBhbmQgc2ltcGxpZmllZCBhIGZldyB0aGluZ3MgYXMgd2VsbCAqLwov
KiBjdXJzZXIgcm90YXRlcyA2MCB0aW1lcyBhIHNlY29uZCBhbG9uZyB3aXRoIHZzeW5jICovCgoj
aW5jbHVkZSA8ZmNudGwuaD4gLyogd2hlcmUgZG9lcyBPX1JEV1IgY29tZSBmcm9tPyAqLwojaW5j
bHVkZSA8c3RkaW8uaD4gLyogd2hlcmUgZG9lcyBzdGRlcnIgY29tZSBmcm9tPyAqLwojaW5jbHVk
ZSA8c3RkbGliLmg+IC8qIHdoZXJlIGRvZXMgc3RkZXJyIGNvbWUgZnJvbT8gKi8KI2luY2x1ZGUg
PHNpZ25hbC5oPiAvKiB3aGVyZSBTSUdJTlQgbGl2ZXMgKi8KI2luY2x1ZGUgPHVuaXN0ZC5oPiAv
KiB3aGVyZSBjbG9zZSBsaXZlcyAqLwojaW5jbHVkZSA8ZXJybm8uaD4gLyogd2hlcmUgZXJybm8g
bGl2ZXMgKi8KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPiAvKiB3aGVyZSBfSU9XUiBsaXZlcyAqLwoj
aW5jbHVkZSA8YXNtLWkzODYvbXNyLmg+IC8qIHdoZXJlIHJkdHNjbGwgbGl2ZXMgKi8KCiNkZWZp
bmUgIF9fdXNlcgoKI2luY2x1ZGUgIi91c3Ivc3JjL2xpbnV4L2RyaXZlcnMvY2hhci9kcm0vZHJt
LmgiIC8qIGFsbCB0aGUgZHJtIGlvY3RscyBhbmQgc3RydWN0dXJlcyAqLwojaW5jbHVkZSAidnN5
bmMuaCIgLyogd2hlcmUgdnN5bmMgc3R1ZmYgbGl2ZXMgKi8KCgoKaW50IGRyaV9mZCA9IC0xOwoK
I2lmZGVmIFJVTlZTWU5DCgppbnQKbWFpbigpCnsKCXVuc2lnbmVkIGxvbmcgbG9uZyBpbnQgbGFz
dHRpY2ssIHRoaXN0aWNrLCB0aWNrcywgbWF4dmFsID0gMCwgbWludmFsID0gfjAsIHRvdGFsID0g
MCwgbWVhbnZhbDsKCWludCBjb3VudCA9IDE7CgoJaWYgKGRyaV9pbml0KCkgPT0gLTEpIHsKCQlw
cmludGYoImNhbid0IG9wZW4gZHJpIGRldmljZVxuIik7CgkJZXhpdCgxKTsKCX0KCXNpZ25hbChT
SUdJTlQsIChfX3NpZ2hhbmRsZXJfdCkgZHJpX2Nsb3NlKTsKCQkKCWRyaV92YmxhbmsoKTsKCXJk
dHNjbGwobGFzdHRpY2spOwoKCWZvciAoOzspIHsKCS8qIG5vdGU6IG5lZWQgdG8gdXNlIGZwcmlu
dGYsIGFzIHByaW50ZiB3aWxsIGNhY2hlIGFuZCBvbmx5IHJlYWxseSBwcmludCBldmVyeSBvbmNl
IGluIGEgd2hpbGUgKi8KCQlkcmlfdmJsYW5rKCk7CgkJcmR0c2NsbCh0aGlzdGljayk7CgkJdGlj
a3MgPSB0aGlzdGljayAtIGxhc3R0aWNrOwoJCWxhc3R0aWNrID0gdGhpc3RpY2s7CgkJbWF4dmFs
ID0gKG1heHZhbCA+IHRpY2tzKSA/IG1heHZhbCA6IHRpY2tzOwoJCW1pbnZhbCA9IChtaW52YWwg
PCB0aWNrcykgPyBtaW52YWwgOiB0aWNrczsKCQl0b3RhbCArPSB0aWNrczsKCQltZWFudmFsID0g
dG90YWwgLyBjb3VudDsKCQlmcHJpbnRmKHN0ZGVyciwgIlxcOiVpXHQ6JWxsdVx0OiVsbHVcdDol
bGx1XHQ6JWxsdSAgIFxyIiwgY291bnQrKywgdGlja3MsIG1heHZhbCwgbWludmFsLCBtZWFudmFs
KTsKCQkKCQlkcmlfdmJsYW5rKCk7CgkJcmR0c2NsbCh0aGlzdGljayk7CgkJdGlja3MgPSB0aGlz
dGljayAtIGxhc3R0aWNrOwoJCWxhc3R0aWNrID0gdGhpc3RpY2s7CgkJbWF4dmFsID0gKG1heHZh
bCA+IHRpY2tzKSA/IG1heHZhbCA6IHRpY2tzOwoJCW1pbnZhbCA9IChtaW52YWwgPCB0aWNrcykg
PyBtaW52YWwgOiB0aWNrczsKCQl0b3RhbCArPSB0aWNrczsKCQltZWFudmFsID0gdG90YWwgLyBj
b3VudDsKCQlmcHJpbnRmKHN0ZGVyciwgInw6JWlcdDolbGx1XHQ6JWxsdVx0OiVsbHVcdDolbGx1
ICAgXHIiLCBjb3VudCsrLCB0aWNrcywgbWF4dmFsLCBtaW52YWwsIG1lYW52YWwpOwoKCQlkcmlf
dmJsYW5rKCk7CgkJcmR0c2NsbCh0aGlzdGljayk7CgkJdGlja3MgPSB0aGlzdGljayAtIGxhc3R0
aWNrOwoJCWxhc3R0aWNrID0gdGhpc3RpY2s7CgkJbWF4dmFsID0gKG1heHZhbCA+IHRpY2tzKSA/
IG1heHZhbCA6IHRpY2tzOwoJCW1pbnZhbCA9IChtaW52YWwgPCB0aWNrcykgPyBtaW52YWwgOiB0
aWNrczsKCQl0b3RhbCArPSB0aWNrczsKCQltZWFudmFsID0gdG90YWwgLyBjb3VudDsKCQlmcHJp
bnRmKHN0ZGVyciwgIi86JWlcdDolbGx1XHQ6JWxsdVx0OiVsbHVcdDolbGx1ICBcciIsIGNvdW50
KyssIHRpY2tzLCBtYXh2YWwsIG1pbnZhbCwgbWVhbnZhbCk7CgoJCWRyaV92YmxhbmsoKTsKCQly
ZHRzY2xsKHRoaXN0aWNrKTsKCQl0aWNrcyA9IHRoaXN0aWNrIC0gbGFzdHRpY2s7CgkJbGFzdHRp
Y2sgPSB0aGlzdGljazsKCQltYXh2YWwgPSAobWF4dmFsID4gdGlja3MpID8gbWF4dmFsIDogdGlj
a3M7CgkJbWludmFsID0gKG1pbnZhbCA8IHRpY2tzKSA/IG1pbnZhbCA6IHRpY2tzOwoJCXRvdGFs
ICs9IHRpY2tzOwoJCW1lYW52YWwgPSB0b3RhbCAvIGNvdW50OwoJCWZwcmludGYoc3RkZXJyLCAi
LTolaVx0OiVsbHVcdDolbGx1XHQ6JWxsdVx0OiVsbHUgICBcciIsIGNvdW50KyssIHRpY2tzLCBt
YXh2YWwsIG1pbnZhbCwgbWVhbnZhbCk7Cgl9Cn0KCiNlbmRpZiAvKiBSVU5WU1lOQyAqLwoKaW50
IGRyaV9pbml0KHZvaWQpCnsKCWRyaV9mZCA9IG9wZW4gKCIvZGV2L2RyaS9jYXJkMCIsIE9fUkRX
Uik7CglyZXR1cm4gKGRyaV9mZCk7Cn0KCnZvaWQgZHJpX2Nsb3NlKHZvaWQpCnsKCWZwcmludGYo
c3RkZXJyLCAiXG5TaHV0dGluZyBkb3duIVxuIik7CglpZiAoZHJpX2ZkICE9IC0xKQoJCWNsb3Nl
KGRyaV9mZCk7CglleGl0KDApOwp9Cgp2b2lkIGRyaV92Ymxhbmsodm9pZCkKewoJaW50IHJldDsK
CWRybV93YWl0X3ZibGFua190IHZibDsKCgl2YmwucmVxdWVzdC50eXBlID0gX0RSTV9WQkxBTktf
UkVMQVRJVkU7Cgl2YmwucmVxdWVzdC5zZXF1ZW5jZSA9IDE7CgoJZG8gewoJCXJldCA9IGlvY3Rs
KCBkcmlfZmQsIERSTV9JT0NUTF9XQUlUX1ZCTEFOSywgJnZibCApOwoJLyoJdmJsLnJlcXVlc3Qu
dHlwZSAmPSB+X0RSTV9WQkxBTktfUkVMQVRJVkU7ICovCgkJdmJsLnJlcXVlc3QudHlwZSA9IChk
cm1fdmJsYW5rX3NlcV90eXBlX3QpICh2YmwucmVxdWVzdC50eXBlICYgfl9EUk1fVkJMQU5LX1JF
TEFUSVZFKTsKCX0gd2hpbGUgKHJldCAmJiBlcnJubyA9PSBFSU5UUik7CglyZXR1cm47Cn0K

------_=_NextPart_001_01C55BF1.0359A13E--

