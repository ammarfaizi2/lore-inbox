Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289544AbSAOOUB>; Tue, 15 Jan 2002 09:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289642AbSAOOTv>; Tue, 15 Jan 2002 09:19:51 -0500
Received: from [213.171.51.190] ([213.171.51.190]:3215 "EHLO ns.yauza.ru")
	by vger.kernel.org with ESMTP id <S289544AbSAOOTh>;
	Tue, 15 Jan 2002 09:19:37 -0500
Date: Tue, 15 Jan 2002 17:19:35 +0300
From: Nikita Gergel <fc@yauza.ru>
To: Frank Jacobberger <f1j@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emu10k1_audio_open?? 2.5.2 problem
Message-Id: <20020115171935.6dd1eaa2.fc@yauza.ru>
In-Reply-To: <3C443940.8070000@xmission.com>
In-Reply-To: <3C443940.8070000@xmission.com>
Organization: YAUZA-Telecom
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-alt-linux)
X-Face: /kH/`k:.@|9\`-o$p/YBn<xFr)I]mglEQW0$I${i4Q;J|JXWbc}de_p8c1;:W~5{WV,.l%B S|A4'A1hnId[
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__15_Jan_2002_17:19:35_+0300_08352ac0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__15_Jan_2002_17:19:35_+0300_08352ac0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jan 2002 07:14:24 -0700
Frank Jacobberger <f1j@xmission.com> wrote:

> gcc -D__KERNEL__ -I/usr/src/linux-2.5.2/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686 -DMODULE -DMODVERSIONS -include 
> /usr/src/linux-2.5.2/include/linux/modversions.h   -c -o audio.o audio.c
> audio.c: In function `emu10k1_audio_open':
> audio.c:1101: invalid operands to binary &
> make[3]: *** [audio.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.2/drivers/sound/emu10k1'
> make[2]: *** [_modsubdir_emu10k1] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.2/drivers/sound'
> make[1]: *** [_modsubdir_sound] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.2/drivers'
> make: *** [_mod_drivers] Error 2
> 
> What to do?

I've already contributed patch for 2.5 kernels to fix this. There are problems with 'MINOR' function.
Look in attach for the patch.

-- 
Nikita Gergel					System Administrator
Moscow, Russia					YAUZA-Telecom

--Multipart_Tue__15_Jan_2002_17:19:35_+0300_08352ac0
Content-Type: application/octet-stream;
 name="emu10k1.diff"
Content-Disposition: attachment;
 filename="emu10k1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYyLjUuMS9saW51eC9kcml2ZXJzL3NvdW5k
L2VtdTEwazEvYXVkaW8uYyBsaW51eC9kcml2ZXJzL3NvdW5kL2VtdTEwazEvYXVkaW8uYwotLS0g
djIuNS4xL2xpbnV4L2RyaXZlcnMvc291bmQvZW11MTBrMS9hdWRpby5jICAgICAgIFR1ZSBPY3Qg
OSAyMTo1MzowMCAyMDAxCisrKyBsaW51eC9kcml2ZXJzL3NvdW5kL2VtdTEwazEvYXVkaW8uYyAg
ICAgIFdlZCBKYW4gIDkgMTA6MDA6MDAgMjAwMgpAQCAtMTA5OCw3ICsxMDk4LDcgQEAKIAogc3Rh
dGljIGludCBlbXUxMGsxX2F1ZGlvX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZp
bGUgKmZpbGUpCiB7Ci0JaW50IG1pbm9yID0gTUlOT1IoaW5vZGUtPmlfcmRldik7CisJaW50IGVt
dV9taW5vciA9IG1pbm9yKGlub2RlLT5pX3JkZXYpOwogCXN0cnVjdCBlbXUxMGsxX2NhcmQgKmNh
cmQgPSBOVUxMOwogCXN0cnVjdCBsaXN0X2hlYWQgKmVudHJ5OwogCXN0cnVjdCBlbXUxMGsxX3dh
dmVkZXZpY2UgKndhdmVfZGV2OwpAQCAtMTExMCw3ICsxMTEwLDcgQEAKIAlsaXN0X2Zvcl9lYWNo
KGVudHJ5LCAmZW11MTBrMV9kZXZzKSB7CiAJCWNhcmQgPSBsaXN0X2VudHJ5KGVudHJ5LCBzdHJ1
Y3QgZW11MTBrMV9jYXJkLCBsaXN0KTsKIAotCQlpZiAoISgoY2FyZC0+YXVkaW9fZGV2IF4gbWlu
b3IpICYgfjB4ZikgfHwgISgoY2FyZC0+YXVkaW9fZGV2MSBeIG1pbm9yKSAmIH4weGYpKQorCQlp
ZiAoISgoY2FyZC0+YXVkaW9fZGV2IF4gZW11X21pbm9yKSAmIH4weGYpIHx8ICEoKGNhcmQtPmF1
ZGlvX2RldjEgXiBlbXVfbWlub3IpICYgfjB4ZikpCgkJCWdvdG8gbWF0Y2g7CiAJfQogCkBAIC0x
MjA2LDcgKzEyMDYsNyBAQAogCQl3b2luc3QtPmJ1ZmZlci5mcmFnbWVudF9zaXplID0gMDsKIAkJ
d29pbnN0LT5idWZmZXIub3NzZnJhZ3NoaWZ0ID0gMDsKIAkJd29pbnN0LT5idWZmZXIubnVtZnJh
Z3MgPSAwOwotCQl3b2luc3QtPmRldmljZSA9IChjYXJkLT5hdWRpb19kZXYxID09IG1pbm9yKTsK
KwkJd29pbnN0LT5kZXZpY2UgPSAoY2FyZC0+YXVkaW9fZGV2MSA9PSBlbXVfbWlub3IpOwogCQl3
b2luc3QtPnRpbWVyLnN0YXRlID0gVElNRVJfU1RBVEVfVU5JTlNUQUxMRUQ7CiAJCXdvaW5zdC0+
bnVtX3ZvaWNlcyA9IDE7CiAJCWZvciAoaSA9IDA7IGkgPCBXQVZFT1VUX01BWFZPSUNFUzsgaSsr
KSB7CmRpZmYgLXUgLS1yZWN1cnNpdmUgLS1uZXctZmlsZSB2Mi41LjEvbGludXgvZHJpdmVycy9z
b3VuZC9lbXUxMGsxL21pZGkuYyBsaW51eC9kcml2ZXJzL3NvdW5kL2VtdTEwazEvbWlkaS5jCi0t
LSB2Mi41LjEvbGludXgvZHJpdmVycy9zb3VuZC9lbXUxMGsxL21pZGkuYyAgICAgICBUdWUgT2N0
IDkgMjE6NTM6MDAgMjAwMQorKysgbGludXgvZHJpdmVycy9zb3VuZC9lbXUxMGsxL21pZGkuYyAg
ICAgIFdlZCBKYW4gIDkgMTA6MDA6MDAgMjAwMgpAQCAtODcsNyArODcsNyBAQAogCiBzdGF0aWMg
aW50IGVtdTEwazFfbWlkaV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpm
aWxlKQogewotCWludCBtaW5vciA9IE1JTk9SKGlub2RlLT5pX3JkZXYpOworCWludCBlbXVfbWlu
b3IgPSBtaW5vcihpbm9kZS0+aV9yZGV2KTsKIAlzdHJ1Y3QgZW11MTBrMV9jYXJkICpjYXJkID0g
TlVMTDsKIAlzdHJ1Y3QgZW11MTBrMV9taWRpZGV2aWNlICptaWRpX2RldjsKIAlzdHJ1Y3QgbGlz
dF9oZWFkICplbnRyeTsKQEAgLTk4LDcgKzk4LDcgQEAKIAlsaXN0X2Zvcl9lYWNoKGVudHJ5LCAm
ZW11MTBrMV9kZXZzKSB7CiAJCWNhcmQgPSBsaXN0X2VudHJ5KGVudHJ5LCBzdHJ1Y3QgZW11MTBr
MV9jYXJkLCBsaXN0KTsKIAotCQlpZiAoY2FyZC0+bWlkaV9kZXYgPT0gbWlub3IpCisJCWlmIChj
YXJkLT5taWRpX2RldiA9PSBlbXVfbWlub3IpCiAJCQlnb3RvIG1hdGNoOwogCX0KIApkaWZmIC11
IC0tcmVjdXJzaXZlIC0tbmV3LWZpbGUgdjIuNS4xL2xpbnV4L2RyaXZlcnMvc291bmQvZW11MTBr
MS9taXhlci5jIGxpbnV4L2RyaXZlcnMvc291bmQvZW11MTBrMS9taXhlci5jCi0tLSB2Mi41LjEv
bGludXgvZHJpdmVycy9zb3VuZC9lbXUxMGsxL21peGVyLmMgICAgICAgVHVlIE9jdCA5IDIxOjUz
OjAwIDIwMDEKKysrIGxpbnV4L2RyaXZlcnMvc291bmQvZW11MTBrMS9taXhlci5jICAgICAgV2Vk
IEphbiAgOSAxMDowMDowMCAyMDAyCkBAIC02NDAsNyArNjQwLDcgQEAKIAogc3RhdGljIGludCBl
bXUxMGsxX21peGVyX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUp
CiB7Ci0JaW50IG1pbm9yID0gTUlOT1IoaW5vZGUtPmlfcmRldik7CisJaW50IGVtdV9taW5vciA9
IG1pbm9yKGlub2RlLT5pX3JkZXYpOwogCXN0cnVjdCBlbXUxMGsxX2NhcmQgKmNhcmQgPSBOVUxM
OwogCXN0cnVjdCBsaXN0X2hlYWQgKmVudHJ5OwogCkBAIC02NDksNyArNjQ5LDcgQEAKIAlsaXN0
X2Zvcl9lYWNoKGVudHJ5LCAmZW11MTBrMV9kZXZzKSB7CiAJCWNhcmQgPSBsaXN0X2VudHJ5KGVu
dHJ5LCBzdHJ1Y3QgZW11MTBrMV9jYXJkLCBsaXN0KTsKIAotCQlpZiAoY2FyZC0+YWM5Ny5kZXZf
bWl4ZXIgPT0gbWlub3IpCisJCWlmIChjYXJkLT5hYzk3LmRldl9taXhlciA9PSBlbXVfbWlub3Ip
CiAJCQlnb3RvIG1hdGNoOwogCX0KIAo=

--Multipart_Tue__15_Jan_2002_17:19:35_+0300_08352ac0--
