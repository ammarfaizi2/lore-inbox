Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbTAOQby>; Wed, 15 Jan 2003 11:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbTAOQbx>; Wed, 15 Jan 2003 11:31:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266721AbTAOQbw>; Wed, 15 Jan 2003 11:31:52 -0500
Date: Wed, 15 Jan 2003 11:43:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <20030114212113.GF15412@mark.mielke.cc>
Message-ID: <Pine.LNX.3.95.1030115113606.18233A-200000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-450684888-1042648981=:18233"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-450684888-1042648981=:18233
Content-Type: TEXT/PLAIN; charset=US-ASCII


Well, I just can't give this up! Here is a procedure plus a test
program that reallocates and copies environment strings so the
process title can be altered. The procedure returns the amount
of space available for the new name so that strncpy() can be
used to prevent damage.

If you don't like me pretending that main() gets the environment
after args[], you can access environ directly anyway with the
same result. Have fun!


If you don't have enough string-space to make a large enough name,
just increase the size of your environment.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


--1678434306-450684888-1042648981=:18233
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="xxx.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1030115114301.18233B@chaos.analogic.com>
Content-Description: 

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQojaW5j
bHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8bWFsbG9jLmg+DQoNCmV4dGVy
biBjaGFyICoqZW52aXJvbjsNCg0Kc2l6ZV90IGluaXRfc2V0dGl0bGUoY2hh
ciAqYXJndltdLCBjaGFyICplbnZbXSkNCnsNCiAgIHNpemVfdCBpLCBsZW47
DQogICBjaGFyICpsaW1pdDsNCiAgIGNoYXIgKnZhcjsNCiAgIGkgPSAwOw0K
ICAgd2hpbGUoZW52W2ldICE9IE5VTEwpDQogICB7DQogICAgICAgbGVuID0g
IHN0cmxlbihlbnZbaV0pICsgMTsgICAgICAvKiBSb29tIGZvciB0aGUgJ1ww
JyAgICAqLw0KICAgICAgIHZhciA9ICAoY2hhciAqKSBtYWxsb2MobGVuKTsN
CiAgICAgICBtZW1jcHkodmFyLCBlbnZbaV0sIGxlbik7ICAgICAgIC8qIENv
cHkgdGhlICdcMCcgYWxzbyAgICovDQogICAgICAgbGltaXQgICAgPSBlbnZb
aV07ICAgICAgICAgICAgICAvKiBTdGFydCBvZiBsYXN0IHN0cmluZyAqLw0K
ICAgICAgIGVudltpKytdID0gdmFyOyAgICAgICAgICAgICAgICAgLyogTmV3
IGVudmlyb25tZW50IHB0ciAgKi8NCiAgIH0NCiAgIHdoaWxlKCpsaW1pdCkg
ICAgICAgICAgICAgICAgICAgICAgIC8qIEVuZCBvZiBsYXN0IHN0cmluZyAg
ICovDQogICAgICAgbGltaXQrKzsNCiAgIHJldHVybiAobGltaXQgLSBhcmd2
WzBdKTsgICAgICAgICAgIC8qIFNwYWNlIHdlIGNhbiB1c2UgICAgICovDQp9
DQoNCmludCBtYWluKGludCBjLCBjaGFyICphcmd2W10sIGNoYXIgKmVudltd
KQ0Kew0KICAgIHNpemVfdCBsZW4sIGk7DQogICAgbGVuID0gaW5pdF9zZXR0
aXRsZShhcmd2LCBlbnYpOw0KICAgIGkgPSAwOw0KICAgIHdoaWxlKGVudmly
b25baV0gIT0gTlVMTCkNCiAgICAgICAgcHV0cyhlbnZpcm9uW2krK10pOw0K
ICAgIHByaW50ZigiTGVuZ3RoIGFsbG93ZWQgPSAldVxuIiwgbGVuKTsNCiAg
ICBmZmx1c2goc3Rkb3V0KTsNCiAgICBzdHJuY3B5KGFyZ3ZbMF0sICJBbnRp
ZGVzZXN0YWJsaXNobWVudGFyaWFuaXNtIiwgbGVuKTsNCiAgICBpID0gMDsN
CiAgICB3aGlsZShlbnZpcm9uW2ldICE9IE5VTEwpDQogICAgICAgIHB1dHMo
ZW52aXJvbltpKytdKTsNCiAgICBmZmx1c2goc3Rkb3V0KTsNCiAgICBwYXVz
ZSgpOyANCiAgICByZXR1cm4gMDsNCn0NCg0K
--1678434306-450684888-1042648981=:18233--
