Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275511AbRJFTFw>; Sat, 6 Oct 2001 15:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275520AbRJFTFm>; Sat, 6 Oct 2001 15:05:42 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:8969 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275511AbRJFTFe>; Sat, 6 Oct 2001 15:05:34 -0400
Date: Sat, 6 Oct 2001 21:05:55 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.3.96.1011006173010.32345A-200000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1011006210335.7808B-200000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-2044777418-1002395155=:7808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1908636959-2044777418-1002395155=:7808
Content-Type: TEXT/PLAIN; charset=US-ASCII

> This is enhanced version of a patch that fixes select and poll as well.
> Again - not compiled, not tried. 

There is a bug that it does not align allocation - so things like
(%esp & ~8191) won't work. This should be applied on the top of it.

Mikulas

--1908636959-2044777418-1002395155=:7808
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="vmalloc.patch.3"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1011006210555.7808C@artax.karlin.mff.cuni.cz>
Content-Description: 

LS0tIGxpbnV4LW9yaWcvbW0vdm1hbGxvYy5jCVNhdCBPY3QgIDYgMTY6MjE6
NDcgMjAwMQ0KKysrIGxpbnV4L21tL3ZtYWxsb2MuYwlTYXQgT2N0ICA2IDIx
OjAxOjAwIDIwMDENCkBAIC0xNzAsNiArMTcwLDkgQEANCiB7DQogCXVuc2ln
bmVkIGxvbmcgYWRkcjsNCiAJc3RydWN0IHZtX3N0cnVjdCAqKnAsICp0bXAs
ICphcmVhOw0KKwlpbnQgYWxpZ24gPSAwOw0KKw0KKwlpZiAoc2l6ZSA+IFBB
R0VfU0laRSAmJiAhKHNpemUgJiAoc2l6ZSAtIDEpKSkgYWxpZ24gPSBzaXpl
IC0gMTsNCiANCiAJYXJlYSA9IChzdHJ1Y3Qgdm1fc3RydWN0ICopIGttYWxs
b2Moc2l6ZW9mKCphcmVhKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghYXJlYSkN
CkBAIC0xODMsNiArMTg2LDcgQEANCiAJCWlmIChzaXplICsgYWRkciA8PSAo
dW5zaWduZWQgbG9uZykgdG1wLT5hZGRyKQ0KIAkJCWJyZWFrOw0KIAkJYWRk
ciA9IHRtcC0+c2l6ZSArICh1bnNpZ25lZCBsb25nKSB0bXAtPmFkZHI7DQor
CQlhZGRyID0gKGFkZHIgKyBhbGlnbikgJiB+YWxpZ247DQogCQlpZiAoYWRk
ciA+IFZNQUxMT0NfRU5ELXNpemUpDQogCQkJZ290byBvdXQ7DQogCX0NCg==
--1908636959-2044777418-1002395155=:7808--
