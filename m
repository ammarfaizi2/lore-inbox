Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUJWK5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUJWK5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJWK5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:57:14 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:1789 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S267170AbUJWK5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:57:07 -0400
Date: Sat, 23 Oct 2004 12:48:14 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub4.ifh.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org
Subject: Re: [patch] 2.6.9-mm1: dvb-dibusb.c: remove unused code
In-Reply-To: <20041023004416.GE22558@stusta.de>
Message-ID: <Pine.LNX.4.58.0410231243320.15741@pub4.ifh.de>
References: <20041022032039.730eb226.akpm@osdl.org> <20041023004416.GE22558@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="579715599-1839001960-1098528494=:15741"
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--579715599-1839001960-1098528494=:15741
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 23 Oct 2004, Adrian Bunk wrote:

> It seems the following warnings come from Linus' tree:
>
> <--  snip  -->
>
> ...
>   CC      drivers/media/dvb/dibusb/dvb-dibusb.o
> drivers/media/dvb/dibusb/dvb-dibusb.c:308: warning: 'dibusb_interrupt_read_loop' defined but not used
> drivers/media/dvb/dibusb/dvb-dibusb.c:318: warning: 'dibusb_read_remote_control' defined but not used
> drivers/media/dvb/dibusb/dvb-dibusb.c:345: warning: 'dibusb_hw_sleep' defined but not used
> drivers/media/dvb/dibusb/dvb-dibusb.c:351: warning: 'dibusb_hw_wakeup' defined but not used
> ...
>
> <--  snip  -->

Hi,

Sorry for the trouble. I'd prefer to comment out the code instead of
throwing it away, because it will be used in future version.
The attached patch is doing this.

It should apply cleanly to 2.6.9-mm1 as well.

Thanks,
Patrick.

--
  Mail: patrick.boettcher@desy.de
  WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
--579715599-1839001960-1098528494=:15741
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch-linux-2.6.10-rc1-dvb-dibusb-commenting-out-unused-code.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="patch-linux-2.6.10-rc1-dvb-dibusb-commenting-out-unused-code.patch"

LS0tIGR2Yi1kaWJ1c2IuYy5vcmlnCTIwMDQtMTAtMjMgMTI6Mzk6MjAuMDAw
MDAwMDAwICswMjAwDQorKysgZHZiLWRpYnVzYi5jCTIwMDQtMTAtMjMgMTI6
NDA6MDkuMDAwMDAwMDAwICswMjAwDQpAQCAtMTMyLDExICsxMzIsNiBAQA0K
IAlyZXR1cm4gcmV0Ow0KIH0NCiANCi1zdGF0aWMgaW50IGRpYnVzYl93cml0
ZV91c2Ioc3RydWN0IHVzYl9kaWJ1c2IgKmRpYiwgdTggKmJ1ZiwgdTE2IGxl
bikNCi17DQotCXJldHVybiBkaWJ1c2JfcmVhZHdyaXRlX3VzYihkaWIsYnVm
LGxlbixOVUxMLDApOw0KLX0NCi0NCiBzdGF0aWMgaW50IGRpYnVzYl9pMmNf
bXNnKHN0cnVjdCB1c2JfZGlidXNiICpkaWIsIHU4IGFkZHIsDQogCQl1OCAq
d2J1ZiwgdTE2IHdsZW4sIHU4ICpyYnVmLCB1MTYgcmxlbikNCiB7DQpAQCAt
Mjk3LDkgKzI5MiwyMCBAQA0KIH0NCiANCiAvKg0KLSAqIEZpcm13YXJlIHRy
YW5zZmVycw0KKyAqIGN5cHJlc3MgdHJhbnNmZXJzDQorICovDQorDQorI2lm
IDANCisNCisvKg0KKyAqIFRoaXMgY29kZSBpcyBjdXJyZW50bHkgdW51c2Vk
LCBidXQgd2lsbCBiZSBpbiB1c2VkIGluIGZ1dHVyZSB2ZXJzaW9ucy4gDQog
ICovDQogDQorc3RhdGljIGludCBkaWJ1c2Jfd3JpdGVfdXNiKHN0cnVjdCB1
c2JfZGlidXNiICpkaWIsIHU4ICpidWYsIHUxNiBsZW4pDQorew0KKwlyZXR1
cm4gZGlidXNiX3JlYWR3cml0ZV91c2IoZGliLGJ1ZixsZW4sTlVMTCwwKTsN
Cit9DQorDQogLyoNCiAgKiBkbyBub3QgdXNlIHRoaXMsIGp1c3QgYSB3b3Jr
YXJvdW5kIGZvciBhIGJ1ZywNCiAgKiB3aGljaCB3aWxsIG5ldmVyIG9jY3Vy
IDopLg0KQEAgLTM1Myw2ICszNTksOCBAQA0KIAlyZXR1cm4gZGlidXNiX2lv
Y3RsX2NtZChkaWIsRElCVVNCX0lPQ1RMX0NNRF9QT1dFUl9NT0RFLCBiLDEp
Ow0KIH0NCiANCisjZW5kaWYNCisNCiAvKg0KICAqIEkyQw0KICAqLw0K

--579715599-1839001960-1098528494=:15741--
