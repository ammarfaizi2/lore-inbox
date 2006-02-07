Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWBGPFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWBGPFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWBGPFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:05:32 -0500
Received: from webapps.arcom.com ([194.200.159.168]:22801 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S965124AbWBGPFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:05:31 -0500
Message-ID: <43E8B738.8080602@arcom.com>
Date: Tue, 07 Feb 2006 15:05:28 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stephen@streetfiresound.com
CC: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [PATCH] spi: Add PXA2xx SSP SPI Driver
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com> <43E88970.2020107@arcom.com>
In-Reply-To: <43E88970.2020107@arcom.com>
Content-Type: multipart/mixed;
 boundary="------------020206000904030004050400"
X-OriginalArrivalTime: 07 Feb 2006 15:10:24.0421 (UTC) FILETIME=[9EE32D50:01C62BF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206000904030004050400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

David Vrabel wrote:
> stephen@streetfiresound.com wrote:
> 
>>From: Stephen Street <stephen@streetfiresound.com>
>>
>>The driver turns a PXA2xx synchronous serial port (SSP) into a SPI master 
>>controller (see Documentation/spi/spi_summary). The driver has the following
>>features:
> 
> 
> I've not tested this on my PXA27x platform yet (I'll try and get this
> done this tomorrow) but a few comments.

Found time to test it today.

I needed to use DMA for all transfers (not just ones >= dma_burst_size)
since at high clock rates (> ~5 MHz) PIO just can't keep up.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------020206000904030004050400
Content-Type: text/plain;
 name="drivers-spi-pxa2xx-ssp-fixes"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="drivers-spi-pxa2xx-ssp-fixes"

SW5kZXg6IGxpbnV4LTIuNi13b3JraW5nL2RyaXZlcnMvc3BpL3B4YTJ4eF9zcGkuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC0yLjYtd29ya2luZy5vcmlnL2RyaXZlcnMvc3BpL3B4YTJ4
eF9zcGkuYwkyMDA2LTAyLTA3IDEyOjQzOjMyLjAwMDAwMDAwMCArMDAwMAorKysgbGludXgt
Mi42LXdvcmtpbmcvZHJpdmVycy9zcGkvcHhhMnh4X3NwaS5jCTIwMDYtMDItMDcgMTQ6MTM6
NDcuMDAwMDAwMDAwICswMDAwCkBAIC00Myw3ICs0MywxMSBAQAogTU9EVUxFX0RFU0NSSVBU
SU9OKCJQWEEyeHggU1NQIFNQSSBDb250b2xsZXIiKTsKIE1PRFVMRV9MSUNFTlNFKCJHUEwi
KTsKIAotI2RlZmluZSBDTE9DS19TUEVFRF9IWiAzNjg2NDAwCisjaWYgZGVmaW5lZChDT05G
SUdfUFhBMjV4KQorIyAgZGVmaW5lIENMT0NLX1NQRUVEX0haIDM2ODY0MDAKKyNlbGlmIGRl
ZmluZWQoQ09ORklHX1BYQTI3eCkKKyMgIGRlZmluZSBDTE9DS19TUEVFRF9IWiAxMzAwMDAw
MAorI2VuZGlmCiAjZGVmaW5lIE1BWF9CVVNFUyAzCiAKICNkZWZpbmUgRE1BX0lOVF9NQVNL
IChEQ1NSX0VORElOVFIgfCBEQ1NSX1NUQVJUSU5UUiB8IERDU1JfQlVTRVJSKQpAQCAtNDI5
LDkgKzQzMyw2IEBACiAJaWYgKCFJU19ETUFfQUxJR05FRChkcnZfZGF0YS0+cngpIHx8ICFJ
U19ETUFfQUxJR05FRChkcnZfZGF0YS0+dHgpKQogCQlyZXR1cm4gMDsKIAotCWlmIChkcnZf
ZGF0YS0+bGVuIDwgZHJ2X2RhdGEtPmN1cl9jaGlwLT5kbWFfYnVyc3Rfc2l6ZSkKLQkJcmV0
dXJuIDA7Ci0KIAkvKiBNb2RpZnkgc2V0dXAgaWYgcnggYnVmZmVyIGlzIG51bGwgKi8KIAlp
ZiAoZHJ2X2RhdGEtPnJ4ID09IE5VTEwpIHsKIAkJKih1MzIgKikoZHJ2X2RhdGEtPm51bGxf
ZG1hX2J1ZikgPSAwOwpAQCAtMTAxNCw3ICsxMDE1LDcgQEAKIAkJCWNoaXAtPmNyMSA9IFNT
Q1IxX0xCTTsKIAl9CiAKLQljaGlwLT5jcjAgPSBTU0NSMF9TZXJDbGtEaXYoKENMT0NLX1NQ
RUVEX0haIC8gc3BpLT5tYXhfc3BlZWRfaHopICsgMikKKwljaGlwLT5jcjAgPSBTU0NSMF9T
ZXJDbGtEaXYoQ0xPQ0tfU1BFRURfSFogLyAoc3BpLT5tYXhfc3BlZWRfaHogKyAxKSArIDEp
CiAJCQl8IFNTQ1IwX01vdG9yb2xhCiAJCQl8IFNTQ1IwX0RhdGFTaXplKHNwaS0+Yml0c19w
ZXJfd29yZCAmIDB4MGYpCiAJCQl8IFNTQ1IwX1NTRQpAQCAtMTIxOCw3ICsxMjE5LDcgQEAK
IAogCS8qIEF0dGFjaCB0byBJUlEgKi8KIAlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYs
IDApOwotCWlmIChpcnEgPT0gMCkgeworCWlmIChpcnEgPCAwKSB7CiAJCWRldl9lcnIoJnBk
ZXYtPmRldiwgImlycSByZXNvdXJjZSBub3QgZGVmaW5lZFxuIik7CiAJCXN0YXR1cyA9IC1F
Tk9ERVY7CiAJCWdvdG8gb3V0X2Vycm9yX21hc3Rlcl9hbGxvYzsKQEAgLTEzNzgsNyArMTM3
OSw3IEBACiAKIAkvKiBSZWxlYXNlIElSUSAqLwogCWlycSA9IHBsYXRmb3JtX2dldF9pcnEo
cGRldiwgMCk7Ci0JaWYgKGlycSAhPSAwKQorCWlmIChpcnEgPj0gMCkKIAkJZnJlZV9pcnEo
aXJxLCBkcnZfZGF0YSk7CiAKIAkvKiBEaXNjb25uZWN0IGZyb20gdGhlIFNQSSBmcmFtZXdv
cmsgKi8K
--------------020206000904030004050400--
