Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277393AbRJVBFG>; Sun, 21 Oct 2001 21:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277395AbRJVBE4>; Sun, 21 Oct 2001 21:04:56 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:2967 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S277393AbRJVBEu>; Sun, 21 Oct 2001 21:04:50 -0400
Date: Sun, 21 Oct 2001 21:05:22 -0400 (EDT)
From: Sam Varshavchik <mrsam@courier-mta.com>
X-X-Sender: <geo@ny.email-scan.com>
Reply-To: linux-kernel@vger.kernel.org
To: PinkFreud <pf-kernel@mirkwood.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SMP lockup with 2.4.12 on VIA chipset (still does it)
In-Reply-To: <fa.md0b7rv.1c5ob3p@ifi.uio.no>
Message-ID: <Pine.LNX.4.33.0110212100120.32144-200000@ny.email-scan.com>
X-No-Archive: Yes
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_ny.email-scan.com-32514-1003712723-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_ny.email-scan.com-32514-1003712723-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 20 Oct 2001, PinkFreud wrote:

> Please note that this lockup does *NOT* happen with 2.2.19 with SMP, nor
> does it happen with 2.4.x WITHOUT SMP.  Therefore, I would think
> whatever's causing this has to do with something that changed in SMP
> between 2.2.x and 2.4.x.  Please feel free to yell at me if I should post
> this elsewhere.

Try the following patch, and see if it works.  It fixes one potential 
source of SMP hard lockups for 2.4.7+.  I'm not sure if its fixed yet in 
2.4.12.  

-- 
Sam

--=_ny.email-scan.com-32514-1003712723-0001-2
Content-Type: text/plain; charset=us-ascii; name="linux-2.4.7-ioapicdebugfix.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.33.0110212105220.32144@ny.email-scan.com>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.7-ioapicdebugfix.patch"

KioqIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5jLm9yaWcJVHVl
IE9jdCAgOSAyMToxMToxMCAyMDAxDQotLS0gbGludXgvYXJjaC9pMzg2L2tl
cm5lbC9pb19hcGljLmMJVHVlIE9jdCAgOSAyMToxMzowMyAyMDAxDQoqKioq
KioqKioqKioqKioNCioqKiAxMjQ4LDEyNjEgKioqKg0KICAJYWNrX0FQSUNf
aXJxKCk7DQogIA0KICAJaWYgKCEodiAmICgxIDw8IChpICYgMHgxZikpKSkg
ew0KICAjaWZkZWYgQVBJQ19NSVNNQVRDSF9ERUJVRw0KICAJCWF0b21pY19p
bmMoJmlycV9taXNfY291bnQpOw0KICAjZW5kaWYNCiAgCQlzcGluX2xvY2so
JmlvYXBpY19sb2NrKTsNCiAgCQlfX21hc2tfYW5kX2VkZ2VfSU9fQVBJQ19p
cnEoaXJxKTsNCiAgI2lmZGVmIEFQSUNfTE9DS1VQX0RFQlVHDQohIAkJZm9y
ICg7Oykgew0KISAJCQlzdHJ1Y3QgaXJxX3Bpbl9saXN0ICplbnRyeSA9IGly
cV8yX3BpbiArIGlycTsNCiAgCQkJdW5zaWduZWQgaW50IHJlZzsNCiAgDQog
IAkJCWlmIChlbnRyeS0+cGluID09IC0xKQ0KLS0tIDEyNDgsMTI2NCAtLS0t
DQogIAlhY2tfQVBJQ19pcnEoKTsNCiAgDQogIAlpZiAoISh2ICYgKDEgPDwg
KGkgJiAweDFmKSkpKSB7DQorICNpZmRlZiBBUElDX0xPQ0tVUF9ERUJVRw0K
KyAJCXN0cnVjdCBpcnFfcGluX2xpc3QgKmVudHJ5Ow0KKyAjZW5kaWYNCisg
DQogICNpZmRlZiBBUElDX01JU01BVENIX0RFQlVHDQogIAkJYXRvbWljX2lu
YygmaXJxX21pc19jb3VudCk7DQogICNlbmRpZg0KICAJCXNwaW5fbG9jaygm
aW9hcGljX2xvY2spOw0KICAJCV9fbWFza19hbmRfZWRnZV9JT19BUElDX2ly
cShpcnEpOw0KICAjaWZkZWYgQVBJQ19MT0NLVVBfREVCVUcNCiEgCQlmb3Ig
KGVudHJ5ID0gaXJxXzJfcGluICsgaXJxOzspIHsNCiAgCQkJdW5zaWduZWQg
aW50IHJlZzsNCiAgDQogIAkJCWlmIChlbnRyeS0+cGluID09IC0xKQ0K
--=_ny.email-scan.com-32514-1003712723-0001-2--
