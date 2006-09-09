Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWIIOSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWIIOSz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWIIOSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:18:55 -0400
Received: from stinky.trash.net ([213.144.137.162]:30674 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932196AbWIIOSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:18:54 -0400
Message-ID: <4502CD61.2050601@trash.net>
Date: Sat, 09 Sep 2006 16:19:13 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Orlov <bugfixer@list.ru>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <linux-netdev@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: netdevice name corruption is still present in 2.6.18-rc6-mm1
References: <20060909032939.GA3087@nickolas.homeunix.com>
In-Reply-To: <20060909032939.GA3087@nickolas.homeunix.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------040901060408070901020908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040901060408070901020908
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Nick Orlov wrote:
> I would like to confirm that issue with netdevice name corruption
> is still present in 2.6.18-rc6-mm1 and extremely easy to reproduce
> (at least on my system) with 100% hit rate.
> 
> All I have to do is 'sudo /etc/init.d/networking stop'. And here we go:
> 
> Sep  8 22:50:11 nickolas kernel: [events/1:7]: Changing netdevice name from [ath0] to [\200^C^Bб\206]


Can you test this patch please?

--------------040901060408070901020908
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="x"

W1JUTkVUTElOS106IEZpeCBuZXRkZXZpY2UgbmFtZSBjb3JydXB0aW9uCgpXaGVuIGNoYW5n
aW5nIGEgZGV2aWNlIGJ5IGlmaW5kZXggd2l0aG91dCBpbmNsdWRpbmcgYSBJRkxBX0lGTkFN
RQphdHRyaWJ1dGUsIHRoZSBpZm5hbWUgdmFyaWFibGUgY29udGFpbnMgcmFuZG9tIGdhcmJh
Z2UgYW5kIGlzIHVzZWQKdG8gY2hhbmdlIHRoZSBkZXZpY2UgbmFtZS4KClNpZ25lZC1vZmYt
Ynk6IFBhdHJpY2sgTWNIYXJkeSA8a2FiZXJAdHJhc2gubmV0PgoKLS0tCmNvbW1pdCBiYzM0
MTdmNjc5YzAzNWU0Mjk2Y2QzNGY2YTU1ZDZiOTIxNTc2NGZjCnRyZWUgZTQzZjUyNDAyZDc5
NTYwY2JlZDczYTc2OWY0ZGVmM2U3NjFlN2EwMwpwYXJlbnQgNmRkYmQwMmViNjE1MzJmOWFm
NGYyODkxMmEwOTcxN2FiOGM3MWQ4YQphdXRob3IgUGF0cmljayBNY0hhcmR5IDxrYWJlckB0
cmFzaC5uZXQ+IFNhdCwgMDkgU2VwIDIwMDYgMTY6MTg6MTIgKzAyMDAKY29tbWl0dGVyIFBh
dHJpY2sgTWNIYXJkeSA8a2FiZXJAdHJhc2gubmV0PiBTYXQsIDA5IFNlcCAyMDA2IDE2OjE4
OjEyICswMjAwCgogbmV0L2NvcmUvcnRuZXRsaW5rLmMgfCAgICAyICsrCiAxIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9u
ZXQvY29yZS9ydG5ldGxpbmsuYyBiL25ldC9jb3JlL3J0bmV0bGluay5jCmluZGV4IDYzYjg4
MmEuLmQ4ZTI1ZTAgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3J0bmV0bGluay5jCisrKyBiL25l
dC9jb3JlL3J0bmV0bGluay5jCkBAIC0zOTQsNiArMzk0LDggQEAgc3RhdGljIGludCBydG5s
X3NldGxpbmsoc3RydWN0IHNrX2J1ZmYgKgogCiAJaWYgKHRiW0lGTEFfSUZOQU1FXSkKIAkJ
bmxhX3N0cmxjcHkoaWZuYW1lLCB0YltJRkxBX0lGTkFNRV0sIElGTkFNU0laKTsKKwllbHNl
CisJCWlmbmFtZVswXSA9ICdcMCc7CiAKIAllcnIgPSAtRUlOVkFMOwogCWlmbSA9IG5sbXNn
X2RhdGEobmxoKTsK
--------------040901060408070901020908--
