Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272073AbRHWBaj>; Wed, 22 Aug 2001 21:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272096AbRHWBa2>; Wed, 22 Aug 2001 21:30:28 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:15752 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S272073AbRHWBaS>;
	Wed, 22 Aug 2001 21:30:18 -0400
Message-Id: <200108230130.f7N1Uol14698@www.2ka.mipt.ru>
Date: Thu, 23 Aug 2001 05:32:10 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com (Linus Torvalds)
Subject: [PATCH] this patch add a possibility to add a random offset to the stack on exec.
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__23_Aug_2001_05:32:10_+0400_0818c038"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__23_Aug_2001_05:32:10_+0400_0818c038
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hello, linux-guru.

A couple of days ago Artur Grabovsky add this thing into the OpenBSD(
someone guess, this is the most secure OS) kernel.
This, as he suppose, not improve security of the system, but do OS more
strong to the script-kiddies attack.
Althought all admins and security analysist are loudly speaking, that
Linux is the greatest hole in security aspect, i think, that with straight
/dev/hands and not stupid /dav/brain the system can be unbreakable.
But there are situations, when even the best administrator cann't fight
against script-kiddies becouse of vendors, that cann't patch it's soft in
time.
And many systems lost it's defense.
In this cases many things can help, for example nonexecutable stack.
This patch also helps in manner of this kind.
If machine has random stack base in any exec, script kiddies will not
write _simple_ exploits, becouse of allmost such programs beleive, that
stack base remains the same.
And script kiddies should learn much more complex methods, like rewriting
dtors section and other.
In this case this patch cann't help, but i however belive, that this is
not bad.

At the and I want to cite OpenBSD developer, Artur Grabovsky:
"Add a possibility to add a random offset to the stack on exec. This makes
it slightly harder to write generic buffer overflows. This doesn't really
give any real security, but it raises the bar for script-kiddies and it's
really cheap."

Thank for your attention to this patch.

P.S. It also add one check to remove one XXX :)

P.P.S. And sorry for my english :)

P.P.P.S If i have sad trully delirium, then tell me it, becouse i am only
a beginner( or lamer).

---
WBR. //s0mbre

--Multipart_Thu__23_Aug_2001_05:32:10_+0400_0818c038
Content-Type: text/plain;
 name="random_stack_base.patch"
Content-Disposition: attachment;
 filename="random_stack_base.patch"
Content-Transfer-Encoding: base64

LS0tIC4uL2dvb2RfbGludXgvZnMvYmluZm10X2FvdXQuYwlTYXQgSnVsIDIxIDIzOjQyOjI1IDIw
MDEKKysrIC4vZnMvYmluZm10X2FvdXQuYwlUaHUgQXVnIDIzIDA1OjI0OjM0IDIwMDEKQEAgLTI0
LDYgKzI0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9iaW5mbXRzLmg+CiAjaW5jbHVkZSA8bGludXgv
cGVyc29uYWxpdHkuaD4KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CisjaW5jbHVkZSA8bGludXgv
cmFuZG9tLmg+CiAKICNpbmNsdWRlIDxhc20vc3lzdGVtLmg+CiAjaW5jbHVkZSA8YXNtL3VhY2Nl
c3MuaD4KQEAgLTE5NSw4ICsxOTYsMTUgQEAKIAl1bnNpZ25lZCBsb25nICogc3A7CiAJaW50IGFy
Z2MgPSBicHJtLT5hcmdjOwogCWludCBlbnZjID0gYnBybS0+ZW52YzsKLQotCXNwID0gKHVuc2ln
bmVkIGxvbmcgKikgKCgtKHVuc2lnbmVkIGxvbmcpc2l6ZW9mKGNoYXIgKikpICYgKHVuc2lnbmVk
IGxvbmcpIHApOworCXVuc2lnbmVkIGxvbmcgcmFuZDsKKwkKKwlzcCA9ICh1bnNpZ25lZCBsb25n
ICopCisJCQkoKC0odW5zaWduZWQgbG9uZylzaXplb2YoY2hhciAqKSkgJiAodW5zaWduZWQgbG9u
ZykgcCApOworCQorCWdldF9yYW5kb21fYnl0ZXMoJnJhbmQsIDQpOworCXJhbmQgJT0gTUFYX0FS
R19QQUdFUypQQUdFX1NJWkU7CisJc3AgPSAodW5zaWduZWQgbG9uZyAqKSgodW5zaWduZWQgbG9u
ZylzcCAtIHJhbmQpOworCQogI2lmZGVmIF9fc3BhcmNfXwogCS8qIFRoaXMgaW1wb3NlcyB0aGUg
cHJvcGVyIHN0YWNrIGFsaWdubWVudCBmb3IgYSBuZXcgcHJvY2Vzcy4gKi8KIAlzcCA9ICh1bnNp
Z25lZCBsb25nICopICgoKHVuc2lnbmVkIGxvbmcpIHNwKSAmIH43KTsKQEAgLTQxMSw5ICs0MTks
MTAgQEAKIAkJc2VuZF9zaWcoU0lHS0lMTCwgY3VycmVudCwgMCk7IAogCQlyZXR1cm4gcmV0dmFs
OwogCX0KLQorCQogCWN1cnJlbnQtPm1tLT5zdGFydF9zdGFjayA9CiAJCSh1bnNpZ25lZCBsb25n
KSBjcmVhdGVfYW91dF90YWJsZXMoKGNoYXIgKikgYnBybS0+cCwgYnBybSk7CisKICNpZmRlZiBf
X2FscGhhX18KIAlyZWdzLT5ncCA9IGV4LmFfZ3B2YWx1ZTsKICNlbmRpZgotLS0gLi4vZ29vZF9s
aW51eC9mcy9iaW5mbXRfZWxmLmMJU2F0IEp1bCAyMSAyMzo0MjoyNSAyMDAxCisrKyAuL2ZzL2Jp
bmZtdF9lbGYuYwlUaHUgQXVnIDIzIDA1OjI0OjIxIDIwMDEKQEAgLTMxLDYgKzMxLDcgQEAKICNp
bmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvaGlnaHVpZC5oPgogI2luY2x1
ZGUgPGxpbnV4L3NtcF9sb2NrLmg+CisjaW5jbHVkZSA8bGludXgvcmFuZG9tLmg+CiAKICNpbmNs
dWRlIDxhc20vdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9wYXJhbS5oPgpAQCAtMTE1LDcgKzEx
Niw4IEBACiAJY2hhciAqa19wbGF0Zm9ybSwgKnVfcGxhdGZvcm07CiAJbG9uZyBod2NhcDsKIAlz
aXplX3QgcGxhdGZvcm1fbGVuID0gMDsKLQorCXVuc2lnbmVkIGxvbmcgcmFuZDsKKwkKIAkvKgog
CSAqIEdldCBob2xkIG9mIHBsYXRmb3JtIGFuZCBoYXJkd2FyZSBjYXBhYmlsaXRpZXMgbWFza3Mg
Zm9yCiAJICogdGhlIG1hY2hpbmUgd2UgYXJlIHJ1bm5pbmcgb24uICBJbiBzb21lIGNhc2VzIChT
cGFyYyksIApAQCAtMTM3LDYgKzEzOSwxMSBAQAogCSAqIEZvcmNlIDE2IGJ5dGUgX2ZpbmFsXyBh
bGlnbm1lbnQgaGVyZSBmb3IgZ2VuZXJhbGl0eS4KIAkgKi8KIAlzcCA9IChlbGZfYWRkcl90ICop
KH4xNVVMICYgKHVuc2lnbmVkIGxvbmcpKHVfcGxhdGZvcm0pKTsKKwkKKwlnZXRfcmFuZG9tX2J5
dGVzKCZyYW5kLCA0KTsKKwlyYW5kICU9IE1BWF9BUkdfUEFHRVMqUEFHRV9TSVpFOworCXNwID0g
KHVuc2lnbmVkIGxvbmcgKikoKHVuc2lnbmVkIGxvbmcpc3AgLSByYW5kKTsKKwkJCQkJCiAJY3Nw
ID0gc3A7CiAJY3NwIC09ICgxK0RMSU5GT19JVEVNUykqMiArIChrX3BsYXRmb3JtID8gMiA6IDAp
OwogI2lmZGVmIERMSU5GT19BUkNIX0lURU1TCkBAIC00MTMsNyArNDIwLDcgQEAKIAlzdHJ1Y3Qg
ZWxmaGRyIGludGVycF9lbGZfZXg7CiAgIAlzdHJ1Y3QgZXhlYyBpbnRlcnBfZXg7CiAJY2hhciBw
YXNzZWRfZmlsZW5vWzZdOwotCisJCiAJLyogR2V0IHRoZSBleGVjLWhlYWRlciAqLwogCWVsZl9l
eCA9ICooKHN0cnVjdCBlbGZoZHIgKikgYnBybS0+YnVmKTsKIApAQCAtNTkyLDkgKzU5OSwxNCBA
QAogCS8qIERvIHRoaXMgc28gdGhhdCB3ZSBjYW4gbG9hZCB0aGUgaW50ZXJwcmV0ZXIsIGlmIG5l
ZWQgYmUuICBXZSB3aWxsCiAJICAgY2hhbmdlIHNvbWUgb2YgdGhlc2UgbGF0ZXIgKi8KIAljdXJy
ZW50LT5tbS0+cnNzID0gMDsKLQlzZXR1cF9hcmdfcGFnZXMoYnBybSk7IC8qIFhYWDogY2hlY2sg
ZXJyb3IgKi8KKwlyZXR2YWwgPSBzZXR1cF9hcmdfcGFnZXMoYnBybSk7CisgICAgaWYgKHJldHZh
bCA8IDApIHsKKwkJLyogU29tZW9uZSBjaGVjay1tZTogaXMgdGhpcyBlcnJvciBwYXRoIGVub3Vn
aD8gKi8KKwkJc2VuZF9zaWcoU0lHS0lMTCwgY3VycmVudCwgMCk7CisJCXJldHVybiByZXR2YWw7
CisJfQorCQogCWN1cnJlbnQtPm1tLT5zdGFydF9zdGFjayA9IGJwcm0tPnA7Ci0KIAkvKiBOb3cg
d2UgZG8gYSBsaXR0bGUgZ3J1bmd5IHdvcmsgYnkgbW1hcGluZyB0aGUgRUxGIGltYWdlIGludG8K
IAkgICB0aGUgY29ycmVjdCBsb2NhdGlvbiBpbiBtZW1vcnkuICBBdCB0aGlzIHBvaW50LCB3ZSBh
c3N1bWUgdGhhdAogCSAgIHRoZSBpbWFnZSBzaG91bGQgYmUgbG9hZGVkIGF0IGZpeGVkIGFkZHJl
c3MsIG5vdCBhdCBhIHZhcmlhYmxlCg==

--Multipart_Thu__23_Aug_2001_05:32:10_+0400_0818c038--
