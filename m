Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135724AbREBSdZ>; Wed, 2 May 2001 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135725AbREBSdS>; Wed, 2 May 2001 14:33:18 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:1552 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S135724AbREBSct>; Wed, 2 May 2001 14:32:49 -0400
Date: Wed, 2 May 2001 20:32:45 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alex Huang <alexjoy@sis.com.tw>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can do to disable the L1 cache in linux ?
In-Reply-To: <00d301c0d2b8$9206aba0$d9d113ac@sis.com.tw>
Message-ID: <Pine.LNX.3.96.1010502202821.20316A-500000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-505254814-988828365=:20316"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1908636959-505254814-988828365=:20316
Content-Type: TEXT/PLAIN; charset=US-ASCII

> Dear All,
>  How can do to disable the L1 cache in linux ?
> Are there some commands or directives to disable it ??

I wrote this some times ago when playing with caches. Compile cctlmod.c as
a module, insert it to kernel, and use con and coff to enable and disable
caches. 

Note that the code is quite old, maybe it doesn't work with 2.4 kernels,
and I don't want support it. If it doesn't work, fix it yourself. 

Mikulas

--1908636959-505254814-988828365=:20316
Content-Type: TEXT/x-chdr; name="cctl.h"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1010502203245.20316B@artax.karlin.mff.cuni.cz>
Content-Description: 

I2luY2x1ZGUgPGVycm5vLmg+DQojaW5jbHVkZSA8YXNtL3VuaXN0ZC5oPg0K
DQojZGVmaW5lIF9fTlJfZGlzYWJsZV9jYWNoZQkyNTANCiNkZWZpbmUgX19O
Ul9lbmFibGVfY2FjaGUJMjUxDQojZGVmaW5lIF9fTlJfZGlzYWJsZV9jYWNo
ZV93dAkyNTINCiNkZWZpbmUgX19OUl9kaXNhYmxlX3BhZ2VfY2FjaGUJMjUz
DQojZGVmaW5lIF9fTlJfZW5hYmxlX3BhZ2VfY2FjaGUJMjU0DQoNCl9zeXNj
YWxsMChpbnQsIGRpc2FibGVfY2FjaGUpDQpfc3lzY2FsbDAoaW50LCBlbmFi
bGVfY2FjaGUpDQpfc3lzY2FsbDAoaW50LCBkaXNhYmxlX2NhY2hlX3d0KQ0K
X3N5c2NhbGwxKGludCwgZGlzYWJsZV9wYWdlX2NhY2hlLCB2b2lkICosIHBh
Z2UpDQpfc3lzY2FsbDEoaW50LCBlbmFibGVfcGFnZV9jYWNoZSwgdm9pZCAq
LCBwYWdlKQ0K
--1908636959-505254814-988828365=:20316
Content-Type: TEXT/x-csrc; name="cctlmod.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1010502203245.20316C@artax.karlin.mff.cuni.cz>
Content-Description: 

I2RlZmluZSBNT0RVTEUNCiNkZWZpbmUgX19LRVJORUxfXw0KDQojaW5jbHVk
ZSA8bGludXgvYXV0b2NvbmYuaD4NCiNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCiNpbmNsdWRlIDxsaW51eC9tb2R2ZXJzaW9ucy5oPg0KDQojaW5jbHVk
ZSA8bGludXgvbW0uaD4NCiNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KI2lu
Y2x1ZGUgPGFzbS9wZ3RhYmxlLmg+DQoNCmV4dGVybiB2b2lkICpzeXNfY2Fs
bF90YWJsZVtdOw0KDQpmbHVzaF90KCkNCnsNCglfX2FzbV9fIF9fdm9sYXRp
bGVfXyAoDQoJCSJtb3ZsICUlY3IzLCAlJWVheFxuXHQiDQoJCSJtb3ZsICUl
ZWF4LCAlJWNyM1xuXHQiDQoJCTo6OiJheCIsICJjYyIpOw0KfQ0KDQpkaXNh
YmxlX2NhY2hlKCkNCnsNCglfX2FzbV9fIF9fdm9sYXRpbGVfXyAoDQoJCSJj
bGlcblx0Ig0KCQkibW92bCAlJWNyMCwgJSVlYXhcblx0Ig0KCQkib3JsICQw
eDYwMDAwMDAwLCAlJWVheFxuXHQiDQoJCSJtb3ZsICUlZWF4LCAlJWNyMFxu
XHQiDQoJCSJ3YmludmRcblx0Ig0KCQkic3RpXG5cdCINCgkJOjo6ImF4Iiwg
ImNjIik7DQoJcmV0dXJuIDA7DQp9DQoNCmVuYWJsZV9jYWNoZSgpDQp7DQoJ
X19hc21fXyBfX3ZvbGF0aWxlX18gKA0KCQkiY2xpXG5cdCINCgkJIm1vdmwg
JSVjcjAsICUlZWF4XG5cdCINCgkJImFuZGwgJDB4OWZmZmZmZmYsICUlZWF4
XG5cdCINCgkJIm1vdmwgJSVlYXgsICUlY3IwXG5cdCINCgkJIndiaW52ZFxu
XHQiDQoJCSJzdGlcblx0Ig0KCQk6OjoiYXgiLCAiY2MiKTsNCglyZXR1cm4g
MDsNCn0NCg0KZGlzYWJsZV9jYWNoZV93dCgpDQp7DQoJX19hc21fXyBfX3Zv
bGF0aWxlX18gKA0KCQkiY2xpXG5cdCINCgkJIm1vdmwgJSVjcjAsICUlZWF4
XG5cdCINCgkJImFuZGwgJDB4ZGZmZmZmZmYsICUlZWF4XG5cdCINCgkJIm9y
bCAkMHg0MDAwMDAwMCwgJSVlYXhcblx0Ig0KCQkibW92bCAlJWVheCwgJSVj
cjBcblx0Ig0KCQkid2JpbnZkXG5cdCINCgkJInN0aVxuXHQiDQoJCTo6OiJh
eCIsICJjYyIpOw0KCXJldHVybiAwOw0KfQ0KDQpkaXNhYmxlX3BhZ2VfY2Fj
aGUodW5zaWduZWQgbG9uZyBwZykNCnsNCglwdGVfdCAqcHRlID0gcHRlX29m
ZnNldChwbWRfb2Zmc2V0KHBnZF9vZmZzZXQoY3VycmVudC0+bW0sIHBnKSwg
cGcpLCBwZyk7DQoJKih1bnNpZ25lZCAqKXB0ZSB8PSAweDE4Ow0KCWZsdXNo
X3QoKTsNCglyZXR1cm4gMDsNCn0NCg0KZW5hYmxlX3BhZ2VfY2FjaGUodW5z
aWduZWQgbG9uZyBwZykNCnsNCglwdGVfdCAqcHRlID0gcHRlX29mZnNldChw
bWRfb2Zmc2V0KHBnZF9vZmZzZXQoY3VycmVudC0+bW0sIHBnKSwgcGcpLCBw
Zyk7DQoJKih1bnNpZ25lZCAqKXB0ZSAmPSB+MHgxODsNCglmbHVzaF90KCk7
DQoJcmV0dXJuIDA7DQp9DQoNCmluaXRfbW9kdWxlKCkNCnsNCglzeXNfY2Fs
bF90YWJsZVsyNTBdID0gZGlzYWJsZV9jYWNoZTsNCglzeXNfY2FsbF90YWJs
ZVsyNTFdID0gZW5hYmxlX2NhY2hlOw0KCXN5c19jYWxsX3RhYmxlWzI1Ml0g
PSBkaXNhYmxlX2NhY2hlX3d0Ow0KCXN5c19jYWxsX3RhYmxlWzI1M10gPSBk
aXNhYmxlX3BhZ2VfY2FjaGU7DQoJc3lzX2NhbGxfdGFibGVbMjU0XSA9IGVu
YWJsZV9wYWdlX2NhY2hlOw0KCXJldHVybiAwOw0KfQ0KDQpjbGVhbnVwX21v
ZHVsZSgpDQp7DQoJc3lzX2NhbGxfdGFibGVbMjUwXSA9IHN5c19jYWxsX3Rh
YmxlWzI1MV0gPSBzeXNfY2FsbF90YWJsZVsyNTJdID0gMDsNCglzeXNfY2Fs
bF90YWJsZVsyNTNdID0gc3lzX2NhbGxfdGFibGVbMjU0XSA9IDA7DQp9DQo=
--1908636959-505254814-988828365=:20316
Content-Type: TEXT/x-csrc; name="con.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1010502203245.20316D@artax.karlin.mff.cuni.cz>
Content-Description: 

I2luY2x1ZGUgImNjdGwuaCINCg0KbWFpbigpDQp7DQoJaWYgKGVuYWJsZV9j
YWNoZSgpKSBwZXJyb3IoImVuYWJsZV9jYWNoZSIpLCBleGl0KDEpOw0KCXJl
dHVybiAwOw0KfQ0K
--1908636959-505254814-988828365=:20316
Content-Type: TEXT/x-csrc; name="coff.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1010502203245.20316E@artax.karlin.mff.cuni.cz>
Content-Description: 

I2luY2x1ZGUgImNjdGwuaCINCg0KbWFpbigpDQp7DQoJaWYgKGRpc2FibGVf
Y2FjaGUoKSkgcGVycm9yKCJkaXNhYmxlX2NhY2hlIiksIGV4aXQoMSk7DQoJ
cmV0dXJuIDA7DQp9DQo=
--1908636959-505254814-988828365=:20316--
