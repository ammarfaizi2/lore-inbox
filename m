Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290614AbSAYJhv>; Fri, 25 Jan 2002 04:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290617AbSAYJhl>; Fri, 25 Jan 2002 04:37:41 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:1920 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S290614AbSAYJhb>; Fri, 25 Jan 2002 04:37:31 -0500
Date: Fri, 25 Jan 2002 12:37:11 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre5 -- "pcilynx.c:638: invalid operands to binary &"  and  "pcilynx.c:650: `cards' undeclared"
Message-Id: <20020125123711.0f0ebc61.johnpol@2ka.mipt.ru>
In-Reply-To: <1011932306.18088.162.camel@stomata.megapathdsl.net>
In-Reply-To: <1011932306.18088.162.camel@stomata.megapathdsl.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__25_Jan_2002_12:37:11_+0300_082a1e60"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__25_Jan_2002_12:37:11_+0300_082a1e60
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 24 Jan 2002 20:18:26 -0800
Miles Lane <miles@megapathdsl.net> wrote:

> 
> ld -m elf_i386 -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o
> hosts.o highlevel.o csr.o nodemgr.o
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
> pcilynx.o pcilynx.c
> pcilynx.c: In function `mem_open':
> pcilynx.c:638: invalid operands to binary &
> pcilynx.c:650: `num_of_cards' undeclared (first use in this function)
> pcilynx.c:650: (Each undeclared identifier is reported only once
> pcilynx.c:650: for each function it appears in.)
> pcilynx.c:650: `cards' undeclared (first use in this function)
> pcilynx.c: In function `aux_poll':
> pcilynx.c:721: `cards' undeclared (first use in this function)

Have you tried this patch?
Please apply and check if errors occure again.
And of course tell us about process.
Thanks.

btw, Dave Jones has fixed it in his tree, try to look into it.


	Evgeniy Polyakov ( s0mbre ).

--Multipart_Fri__25_Jan_2002_12:37:11_+0300_082a1e60
Content-Type: application/octet-stream;
 name="ieee1394_pcilynx.patch"
Content-Disposition: attachment;
 filename="ieee1394_pcilynx.patch"
Content-Transfer-Encoding: base64

LS0tIC90bXAvcGNpbHlueC5jCVdlZCBKYW4gMjMgMDU6NTQ6MzggMjAwMgorKysgLi9wY2lseW54
LmMJV2VkIEphbiAyMyAwNjo0OTo1MCAyMDAyCkBAIC01NSw5ICs1NSwxNSBAQAogI2RlZmluZSBQ
UklOVEQobGV2ZWwsIGNhcmQsIGZtdCwgYXJncy4uLikgZG8ge30gd2hpbGUgKDApCiAjZW5kaWYK
IAorI2RlZmluZSBNQVhfTlVNX09GX0NBUkRTCTEwIC8qIAorCQkJCSAgICAqICBIb3cgZG8geW91
IHRoaW5rLCAKKwkJCQkgICAgKiBjYW4gYW55b25lIGhhcyBzdWNoIGFtb3VudCBvZiBjYXJkcyAK
KwkJCQkgICAgKiBpbiBvbmUgY29tcHV0ZXI/IAorCQkJCSAgICAqLwogCiBzdGF0aWMgc3RydWN0
IGhwc2JfaG9zdF9kcml2ZXIgKmx5bnhfZHJpdmVyOwotc3RhdGljIHVuc2lnbmVkIGludCBjYXJk
X2lkOworc3RhdGljIHVuc2lnbmVkIGludCBjYXJkX2lkLCBudW1fb2ZfY2FyZHM7CitzdHJ1Y3Qg
dGlfbHlueCBjYXJkc1tNQVhfTlVNX09GX0NBUkRTXTsKIAogLyoKICAqIFBDTCBoYW5kbGluZyBm
dW5jdGlvbnMuCkBAIC0xNTA5LDYgKzE1MTUsMTEgQEAKIAogICAgICAgICBocHNiX2FkZF9ob3N0
KGhvc3QpOwogICAgICAgICBseW54LT5zdGF0ZSA9IGlzX2hvc3Q7CisJCisJaWYgKG51bV9vZl9j
YXJkcyA8IE1BWF9OVU1fT0ZfQ0FSRFMpCisJCWNhcmRzW251bV9vZl9jYXJkcysrXSA9IGhvc3Qt
Pmhvc3RkYXRhOworCWVsc2UKKwkJRkFJTCgiVG9vIG1hbnkgY2FyZHNbICVkIF0uLi4gSW1wb3Nz
aWJsZS4uLlxuIiwgbnVtX29mX2NhcmRzKTsKIAogICAgICAgICByZXR1cm4gMDsKICN1bmRlZiBG
QUlMCg==

--Multipart_Fri__25_Jan_2002_12:37:11_+0300_082a1e60--
