Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290623AbSAYJlL>; Fri, 25 Jan 2002 04:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290624AbSAYJlG>; Fri, 25 Jan 2002 04:41:06 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:3200 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S290623AbSAYJkv>; Fri, 25 Jan 2002 04:40:51 -0500
Date: Fri, 25 Jan 2002 12:40:31 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre5 -- video1394.c:868: too few arguments to function `remap_page_range'
Message-Id: <20020125124031.3434a20e.johnpol@2ka.mipt.ru>
In-Reply-To: <1011932503.10907.169.camel@stomata.megapathdsl.net>
In-Reply-To: <1011932503.10907.169.camel@stomata.megapathdsl.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__25_Jan_2002_12:40:31_+0300_08393380"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__25_Jan_2002_12:40:31_+0300_08393380
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 24 Jan 2002 20:21:42 -0800
Miles Lane <miles@megapathdsl.net> wrote:

> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
> video1394.o video1394.c
> video1394.c: In function `do_iso_mmap':
> video1394.c:868: warning: passing arg 1 of `remap_page_range' makes
> pointer from integer without a cast
> video1394.c:868: incompatible type for argument 4 of `remap_page_range'
> video1394.c:868: too few arguments to function `remap_page_range'
> make[2]: *** [video1394.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'

It is very hard to Linus to look and apply all patches, so pre5 has the
same errors that others pre. Please, apply this patch or get it from Dave
Jones tree. I hope it will help you.

	Evgeniy Polyakov ( s0mbre ).

--Multipart_Fri__25_Jan_2002_12:40:31_+0300_08393380
Content-Type: application/octet-stream;
 name="ieee1394_video1394.patch"
Content-Disposition: attachment;
 filename="ieee1394_video1394.patch"
Content-Transfer-Encoding: base64

LS0tIC4vZHJpdmVycy9pZWVlMTM5NC92aWRlbzEzOTQuY34JVHVlIEphbiAyMiAwNToxMTowOCAy
MDAyCisrKyAuL2RyaXZlcnMvaWVlZTEzOTQvdmlkZW8xMzk0LmMJV2VkIEphbiAyMyAwNzowNDo1
OCAyMDAyCkBAIC04NDQsOCArODQ0LDkgQEAKIAlyZWdfd3JpdGUob2hjaSwgT0hDSTEzOTRfSXNv
WG1pdEludE1hc2tTZXQsIDE8PGQtPmN0eCk7CiB9CiAKLXN0YXRpYyBpbnQgZG9faXNvX21tYXAo
c3RydWN0IHRpX29oY2kgKm9oY2ksIHN0cnVjdCBkbWFfaXNvX2N0eCAqZCwgCi0JCSAgICAgICBj
b25zdCBjaGFyICphZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKK3N0YXRpYyBpbnQgZG9faXNvX21t
YXAoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHN0cnVjdCB0aV9vaGNpICpvaGNpLCAKKwkJ
CXN0cnVjdCBkbWFfaXNvX2N0eCAqZCwgCisJCSAJY29uc3QgY2hhciAqYWRyLCB1bnNpZ25lZCBs
b25nIHNpemUpCiB7CiAgICAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQ9KHVuc2lnbmVkIGxvbmcp
IGFkcjsKICAgICAgICAgdW5zaWduZWQgbG9uZyBwYWdlLHBvczsKQEAgLTg2NSw3ICs4NjYsNyBA
QAogICAgICAgICBwb3M9KHVuc2lnbmVkIGxvbmcpIGQtPmJ1ZjsKICAgICAgICAgd2hpbGUgKHNp
emUgPiAwKSB7CiAgICAgICAgICAgICAgICAgcGFnZSA9IGt2aXJ0X3RvX3BhKHBvcyk7Ci0gICAg
ICAgICAgICAgICAgaWYgKHJlbWFwX3BhZ2VfcmFuZ2Uoc3RhcnQsIHBhZ2UsIFBBR0VfU0laRSwg
UEFHRV9TSEFSRUQpKQorICAgICAgICAgICAgICAgIGlmIChyZW1hcF9wYWdlX3JhbmdlKHZtYSwg
c3RhcnQsIHBhZ2UsIFBBR0VfU0laRSwgUEFHRV9TSEFSRUQpKQogICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FQUdBSU47CiAgICAgICAgICAgICAgICAgc3RhcnQrPVBBR0VfU0laRTsK
ICAgICAgICAgICAgICAgICBwb3MrPVBBR0VfU0laRTsKQEAgLTE0MDYsNyArMTQwNyw3IEBACiAJ
aWYgKHZpZGVvLT5jdXJyZW50X2N0eCA9PSBOVUxMKSB7CiAJCVBSSU5UKEtFUk5fRVJSLCBvaGNp
LT5pZCwgIkN1cnJlbnQgaXNvIGNvbnRleHQgbm90IHNldCIpOwogCX0gZWxzZQotCQlyZXMgPSBk
b19pc29fbW1hcChvaGNpLCB2aWRlby0+Y3VycmVudF9jdHgsIAorCQlyZXMgPSBkb19pc29fbW1h
cCh2bWEsIG9oY2ksIHZpZGVvLT5jdXJyZW50X2N0eCwgCiAJCQkgICAoY2hhciAqKXZtYS0+dm1f
c3RhcnQsIAogCQkJICAgKHVuc2lnbmVkIGxvbmcpKHZtYS0+dm1fZW5kLXZtYS0+dm1fc3RhcnQp
KTsKIAl1bmxvY2tfa2VybmVsKCk7Cg==

--Multipart_Fri__25_Jan_2002_12:40:31_+0300_08393380--
