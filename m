Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285055AbRLLCon>; Tue, 11 Dec 2001 21:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285056AbRLLCod>; Tue, 11 Dec 2001 21:44:33 -0500
Received: from nat.transgeek.com ([66.92.79.28]:62446 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S285055AbRLLCoV>;
	Tue, 11 Dec 2001 21:44:21 -0500
From: Craig Christophel <merlin@transgeek.com>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.5.1-pre8 -- fix to compile nfs as module
Date: Tue, 11 Dec 2001 21:45:58 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Olaf Kirch <okir@monad.swb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <10961.1008114502@kao2.melbourne.sgi.com>
In-Reply-To: <10961.1008114502@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_MCM7FAKCHKH8JPBKI11H"
Message-Id: <20011211224246.CB260C7382@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_MCM7FAKCHKH8JPBKI11H
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Thanks for the tip.....   I thought that could be incorrect.


well here is an updated patch without the modversions stuff.    


Craig.

On Tuesday 11 December 2001 18:48, Keith Owens wrote:
> On Tue, 11 Dec 2001 08:19:35 -0500,
>
> Craig Christophel <merlin@transgeek.com> wrote:
> >added an ifdef for modversions in fs/nfs/inode.c.
>
> Don't!  The Makefile automatically adds modversions.h when required,
> any code that explicitly includes modversions.h is broken.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------Boundary-00=_MCM7FAKCHKH8JPBKI11H
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nfs-module-2.5-unresolved-symbols.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nfs-module-2.5-unresolved-symbols.diff"

ZGlmZiAtdXJOIGxpbnV4L2ZzL01ha2VmaWxlIGxpbnV4Lm10L2ZzL01ha2VmaWxlCi0tLSBsaW51
eC9mcy9NYWtlZmlsZQlTdW4gRGVjICA5IDIzOjU3OjI0IDIwMDEKKysrIGxpbnV4Lm10L2ZzL01h
a2VmaWxlCU1vbiBEZWMgMTAgMjI6MTg6MzEgMjAwMQpAQCAtNyw3ICs3LDcgQEAKIAogT19UQVJH
RVQgOj0gZnMubwogCi1leHBvcnQtb2JqcyA6PQlmaWxlc3lzdGVtcy5vIG9wZW4ubyBkY2FjaGUu
byBidWZmZXIubyBiaW8ubworZXhwb3J0LW9ianMgOj0JZmlsZXN5c3RlbXMubyBvcGVuLm8gZGNh
Y2hlLm8gYnVmZmVyLm8gYmlvLm8gc2VxX2ZpbGUubwogbW9kLXN1YmRpcnMgOj0JbmxzCiAKIG9i
ai15IDo9CW9wZW4ubyByZWFkX3dyaXRlLm8gZGV2aWNlcy5vIGZpbGVfdGFibGUubyBidWZmZXIu
byBcCmRpZmYgLXVyTiBsaW51eC9mcy9zZXFfZmlsZS5jIGxpbnV4Lm10L2ZzL3NlcV9maWxlLmMK
LS0tIGxpbnV4L2ZzL3NlcV9maWxlLmMJU2F0IE5vdiAxNyAyMToxNjoyMiAyMDAxCisrKyBsaW51
eC5tdC9mcy9zZXFfZmlsZS5jCVR1ZSBEZWMgMTEgMDA6Mzk6MDkgMjAwMQpAQCAtOCw2ICs4LDcg
QEAKICNpbmNsdWRlIDxsaW51eC9mcy5oPgogI2luY2x1ZGUgPGxpbnV4L3NlcV9maWxlLmg+CiAj
aW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogCiAjaW5j
bHVkZSA8YXNtL3VhY2Nlc3MuaD4KIApAQCAtMjkzLDMgKzI5NCw5IEBACiAJbS0+Y291bnQgPSBt
LT5zaXplOwogCXJldHVybiAtMTsKIH0KK0VYUE9SVF9TWU1CT0woc2VxX3ByaW50Zik7CitFWFBP
UlRfU1lNQk9MKHNlcV9lc2NhcGUpOworRVhQT1JUX1NZTUJPTChzZXFfcmVsZWFzZSk7CitFWFBP
UlRfU1lNQk9MKHNlcV9sc2Vlayk7CitFWFBPUlRfU1lNQk9MKHNlcV9vcGVuKTsKK0VYUE9SVF9T
WU1CT0woc2VxX3JlYWQpOwpkaWZmIC11ck4gbGludXgvaW5jbHVkZS9saW51eC9zZXFfZmlsZS5o
IGxpbnV4Lm10L2luY2x1ZGUvbGludXgvc2VxX2ZpbGUuaAotLS0gbGludXgvaW5jbHVkZS9saW51
eC9zZXFfZmlsZS5oCVN1biBEZWMgIDkgMjM6NTc6MjQgMjAwMQorKysgbGludXgubXQvaW5jbHVk
ZS9saW51eC9zZXFfZmlsZS5oCU1vbiBEZWMgMTAgMjM6NDc6MTUgMjAwMQpAQCAtMjYsMTEgKzI2
LDExIEBACiAJaW50ICgqc2hvdykgKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdik7CiB9Owog
Ci1pbnQgc2VxX29wZW4oc3RydWN0IGZpbGUgKiwgc3RydWN0IHNlcV9vcGVyYXRpb25zICopOwot
c3NpemVfdCBzZXFfcmVhZChzdHJ1Y3QgZmlsZSAqLCBjaGFyICosIHNpemVfdCwgbG9mZl90ICop
OwotbG9mZl90IHNlcV9sc2VlayhzdHJ1Y3QgZmlsZSAqLCBsb2ZmX3QsIGludCk7Ci1pbnQgc2Vx
X3JlbGVhc2Uoc3RydWN0IGlub2RlICosIHN0cnVjdCBmaWxlICopOwotaW50IHNlcV9lc2NhcGUo
c3RydWN0IHNlcV9maWxlICosIGNvbnN0IGNoYXIgKiwgY29uc3QgY2hhciAqKTsKK2V4dGVybiBp
bnQgc2VxX29wZW4oc3RydWN0IGZpbGUgKiwgc3RydWN0IHNlcV9vcGVyYXRpb25zICopOworZXh0
ZXJuIHNzaXplX3Qgc2VxX3JlYWQoc3RydWN0IGZpbGUgKiwgY2hhciAqLCBzaXplX3QsIGxvZmZf
dCAqKTsKK2V4dGVybiBsb2ZmX3Qgc2VxX2xzZWVrKHN0cnVjdCBmaWxlICosIGxvZmZfdCwgaW50
KTsKK2V4dGVybiBpbnQgc2VxX3JlbGVhc2Uoc3RydWN0IGlub2RlICosIHN0cnVjdCBmaWxlICop
OworZXh0ZXJuIGludCBzZXFfZXNjYXBlKHN0cnVjdCBzZXFfZmlsZSAqLCBjb25zdCBjaGFyICos
IGNvbnN0IGNoYXIgKik7CiAKIHN0YXRpYyBpbmxpbmUgaW50IHNlcV9wdXRjKHN0cnVjdCBzZXFf
ZmlsZSAqbSwgY2hhciBjKQogewpAQCAtNTMsNyArNTMsNyBAQAogCXJldHVybiAtMTsKIH0KIAot
aW50IHNlcV9wcmludGYoc3RydWN0IHNlcV9maWxlICosIGNvbnN0IGNoYXIgKiwgLi4uKQorZXh0
ZXJuIGludCBzZXFfcHJpbnRmKHN0cnVjdCBzZXFfZmlsZSAqLCBjb25zdCBjaGFyICosIC4uLikK
IAlfX2F0dHJpYnV0ZV9fICgoZm9ybWF0IChwcmludGYsMiwzKSkpOwogCiAjZW5kaWYK

--------------Boundary-00=_MCM7FAKCHKH8JPBKI11H--
