Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278406AbRJSNcC>; Fri, 19 Oct 2001 09:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278408AbRJSNbn>; Fri, 19 Oct 2001 09:31:43 -0400
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:59659 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S278406AbRJSNbj>; Fri, 19 Oct 2001 09:31:39 -0400
Date: Fri, 19 Oct 2001 15:32:07 +0200 (CEST)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Albert Bartoszko <albertb@nt.kegel.com.pl>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <Pine.GSO.4.21.0110190845580.22889-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110191527430.2675-200000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="42365354-839537978-1003498327=:2675"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--42365354-839537978-1003498327=:2675
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Linus,

As Al pissed me off again with complaining about binfmt_misc, please
apply the attached patch which corrects the 'not C code' line and
fixes the problem Albert noticed. This doesnt fix various assumptions
about the /proc code that were either valid at the time of writing
binfmt_misc or badly/not documented.

Feel free to use binfmt_misc version from -ac, I'm sure Al will take
responsibility of maintaining that crappy version then.

Thanx, Richard.

On Fri, 19 Oct 2001, Alexander Viro wrote:
> On Fri, 19 Oct 2001, Albert Bartoszko wrote:
> > Hello
> >
> > I find bug in  binfmt_misc.c from kernel 2.4.12 source. The read() syscal
>
> 	only one?
>
> > return bad value, causes some application SIGSEGV.
>
> Hardly a surprise.  Not everything that passes compiler is valid C.
> Stuff in fs/binfmt_misc.c from Linus' tree isn't.  Pick one from -ac
> + corresponding change in fs/proc/root.c (again, see -ac).  Variant
> in Linus' tree is complete crap.
>
> <goes back to sleep>

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

--42365354-839537978-1003498327=:2675
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=binfmt_misc-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0110191532070.2675@bellatrix.tat.physik.uni-tuebingen.de>
Content-Description: 
Content-Disposition: attachment; filename=binfmt_misc-patch

LS0tIC9ob21lL2tvYnJhcy90YXRhZG0va2VybmVsL2xpbnV4LTIuNC4zLVVQ
L2ZzL2JpbmZtdF9taXNjLmMJRnJpIEZlYiAgOSAyMDoyOTo0NCAyMDAxDQor
KysgYmluZm10X21pc2MuYwlGcmkgT2N0IDE5IDE1OjI2OjMyIDIwMDENCkBA
IC0xMyw2ICsxMyw4IEBADQogICogIDE5OTctMDYtMjYgaHBhOiBwYXNzIHRo
ZSByZWFsIGZpbGVuYW1lIHJhdGhlciB0aGFuIGFyZ3ZbMF0NCiAgKiAgMTk5
Ny0wNi0zMCBtaW5vciBjbGVhbnVwDQogICogIDE5OTctMDgtMDkgcmVtb3Zl
ZCBleHRlbnNpb24gc3RyaXBwaW5nLCBsb2NraW5nIGNsZWFudXANCisgKiAg
MjAwMS0xMC0xNSBBbGJlcnQgQmFydG9zemtvOiBjbGVhbnVwLCANCisgKgkJ
Y29ycmVjdCByZXR1cm4gdmFsdWUgb2YgcHJvY19yZWFkX3N0YXR1cygpDQog
ICovDQogDQogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPg0KQEAgLTMwMCw5
ICszMDIsNyBAQA0KIA0KIAllLT5wcm9jX25hbWUgPSBjb3B5YXJnKCZkcCwg
JnNwLCAmY250LCBkZWwsIDAsICZlcnIpOw0KIA0KLQkvKiB3ZSBjYW4gdXNl
IGJpdCAzIG9mIHR5cGUgZm9yIGV4dC9tYWdpYw0KLQkgICBmbGFnIGR1ZSB0
byB0aGUgbmljZSBlbmNvZGluZyBvZiBFIGFuZCBNICovDQotCWlmICgoKnNw
ICYgfignRScgfCAnTScpKSB8fCAoc3BbMV0gIT0gZGVsKSkNCisJaWYgKCgq
c3AgIT0gJ0UnICYmICpzcCAhPSAnTScpIHx8IChzcFsxXSAhPSBkZWwpKQ0K
IAkJZXJyID0gLUVJTlZBTDsNCiAJZWxzZQ0KIAkJZS0+ZmxhZ3MgPSAoKnNw
KysgJiAoRU5UUllfTUFHSUMgfCBFTlRSWV9FTkFCTEVEKSk7DQpAQCAtMzU0
LDI4ICszNTQsMTkgQEANCiAJY2hhciAqZHA7DQogCWludCBlbGVuLCBpLCBl
cnI7DQogDQotI2lmbmRlZiBWRVJCT1NFX1NUQVRVUw0KLQlpZiAoZGF0YSkg
ew0KKwlpZiAoIWRhdGEpIA0KKwkgICAgc3ByaW50ZihwYWdlLCAiJXNcbiIs
ICJlbmFibGVkIik7DQorCWVsc2Ugew0KIAkJaWYgKCEoZSA9IGdldF9lbnRy
eSgoaW50KSBkYXRhKSkpIHsNCiAJCQllcnIgPSAtRU5PRU5UOw0KIAkJCWdv
dG8gX2VycjsNCi0JCX0NCi0JCWkgPSBlLT5mbGFncyAmIEVOVFJZX0VOQUJM
RUQ7DQotCQlwdXRfZW50cnkoZSk7DQotCX0gZWxzZSB7DQotCQlpID0gZW5h
YmxlZDsNCi0JfSANCi0Jc3ByaW50ZihwYWdlLCAiJXNcbiIsIChpID8gImVu
YWJsZWQiIDogImRpc2FibGVkIikpOw0KKwkJfSANCisjaWZuZGVmIFZFUkJP
U0VfU1RBVFVTCQkNCisgICAgCQlzcHJpbnRmKHBhZ2UsICIlc1xuIiwgDQor
CQkJKGUtPmZsYWdzICYgRU5UUllfRU5BQkxFRCkgPyAiZW5hYmxlZCIgOiAi
ZGlzYWJsZWQiKTsNCiAjZWxzZQ0KLQlpZiAoIWRhdGEpDQotCQlzcHJpbnRm
KHBhZ2UsICIlc1xuIiwgKGVuYWJsZWQgPyAiZW5hYmxlZCIgOiAiZGlzYWJs
ZWQiKSk7DQotCWVsc2Ugew0KLQkJaWYgKCEoZSA9IGdldF9lbnRyeSgobG9u
ZykgZGF0YSkpKSB7DQotCQkJZXJyID0gLUVOT0VOVDsNCi0JCQlnb3RvIF9l
cnI7DQotCQl9DQotCQlzcHJpbnRmKHBhZ2UsICIlc1xuaW50ZXJwcmV0ZXIg
JXNcbiIsDQotCQkgICAgICAgIChlLT5mbGFncyAmIEVOVFJZX0VOQUJMRUQg
PyAiZW5hYmxlZCIgOiAiZGlzYWJsZWQiKSwNCisJCXNwcmludGYocGFnZSwg
IiVzXG5pbnRlcnByZXRlciAlc1xuIiwgDQorCQkJKGUtPmZsYWdzICYgRU5U
UllfRU5BQkxFRCkgPyAiZW5hYmxlZCIgOiAiZGlzYWJsZWQiLAkNCiAJCQll
LT5pbnRlcnByZXRlcik7DQogCQlkcCA9IHBhZ2UgKyBzdHJsZW4ocGFnZSk7
DQogCQlpZiAoIShlLT5mbGFncyAmIEVOVFJZX01BR0lDKSkgew0KQEAgLTM5
OSwxMyArMzkwLDE0IEBADQogCQkJKmRwKysgPSAnXG4nOw0KIAkJCSpkcCA9
ICdcMCc7DQogCQl9DQotCQlwdXRfZW50cnkoZSk7DQotCX0NCiAjZW5kaWYN
Ci0NCisJCXB1dF9lbnRyeShlKTsJDQorCX0NCiAJZWxlbiA9IHN0cmxlbihw
YWdlKSAtIG9mZjsNCiAJaWYgKGVsZW4gPCAwKQ0KIAkJZWxlbiA9IDA7DQor
CWlmIChlbGVuID4gY291bnQpDQorCQllbGVuID0gY291bnQ7DQogCSplb2Yg
PSAoZWxlbiA8PSBjb3VudCkgPyAxIDogMDsNCiAJKnN0YXJ0ID0gcGFnZSAr
IG9mZjsNCiAJZXJyID0gZWxlbjsNCg==
--42365354-839537978-1003498327=:2675--
