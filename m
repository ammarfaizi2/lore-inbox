Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVAZXPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVAZXPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVAZXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:14:34 -0500
Received: from web88012.mail.re2.yahoo.com ([206.190.37.231]:7870 "HELO
	web88012.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262446AbVAZRba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:31:30 -0500
Message-ID: <20050126173130.38170.qmail@web88012.mail.re2.yahoo.com>
Date: Wed, 26 Jan 2005 12:31:30 -0500 (EST)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement (From Aurelien) - Resubmit #2
To: Greg KH <greg@kroah.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050126164212.GA3366@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2038931049-1106760690=:38054"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2038931049-1106760690=:38054
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Here is the corrected fix, yeah that didn't make
sense.   
3AM isn't a good time to send patches I guess :-)

 --- Greg KH <greg@kroah.com> wrote: 
> On Wed, Jan 26, 2005 at 02:57:35AM -0500, Shawn
> Starr wrote:
> >  static inline unsigned char FAN_TO_REG(unsigned
> rpm, unsigned div)
> >  {
> > -	if (rpm == 0)
> > +	if (rpm <= 0)
> 
> As was pointed out, this doesn't make any sense.
> 
> Care to redo the patch?
> 
> thanks,
> 
> greg k-h
>  
--0-2038931049-1106760690=:38054
Content-Type: application/octet-stream; name="lm80-fixup-2.diff"
Content-Transfer-Encoding: base64
Content-Description: lm80-fixup-2.diff
Content-Disposition: attachment; filename="lm80-fixup-2.diff"

LS0tIGxpbnV4LTIuNi4xMS1yYzIvZHJpdmVycy9pMmMvY2hpcHMvbG04MC5j
CTIwMDUtMDEtMjYgMDI6MDQ6MzguMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51
eC0yLjYuMTEtcmMyLWZpeGVzL2RyaXZlcnMvaTJjL2NoaXBzL2xtODAuYwky
MDA1LTAxLTI2IDEyOjMxOjI2LjAwMDAwMDAwMCAtMDUwMApAQCAtOTksMTAg
Kzk5LDcgQEAgc3RhdGljIGlubGluZSBsb25nIFRFTVBfRlJPTV9SRUcodTE2
IHRlbQogI2RlZmluZSBURU1QX0xJTUlUX1RPX1JFRyh2YWwpCQlTRU5TT1JT
X0xJTUlUKCh2YWwpPDA/XAogCQkJCQkoKHZhbCktNTAwKS8xMDAwOigodmFs
KSs1MDApLzEwMDAsMCwyNTUpCiAKLSNkZWZpbmUgQUxBUk1TX0ZST01fUkVH
KHZhbCkJCSh2YWwpCi0KICNkZWZpbmUgRElWX0ZST01fUkVHKHZhbCkJCSgx
IDw8ICh2YWwpKQotI2RlZmluZSBESVZfVE9fUkVHKHZhbCkJCQkoKHZhbCk9
PTg/MzoodmFsKT09ND8yOih2YWwpPT0xPzA6MSkKIAogLyoKICAqIENsaWVu
dCBkYXRhIChlYWNoIGNsaWVudCBnZXRzIGl0cyBvd24pCkBAIC0yNjksNyAr
MjY2LDE3IEBAIHN0YXRpYyBzc2l6ZV90IHNldF9mYW5fZGl2KHN0cnVjdCBk
ZXZpY2UKIAkJCSAgIERJVl9GUk9NX1JFRyhkYXRhLT5mYW5fZGl2W25yXSkp
OwogCiAJdmFsID0gc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7Ci0J
ZGF0YS0+ZmFuX2Rpdltucl0gPSBESVZfVE9fUkVHKHZhbCk7CisKKwlzd2l0
Y2ggKHZhbCkgeworCWNhc2UgMTogZGF0YS0+ZmFuX2Rpdltucl0gPSAwOyBi
cmVhazsKKwljYXNlIDI6IGRhdGEtPmZhbl9kaXZbbnJdID0gMTsgYnJlYWs7
CisJY2FzZSA0OiBkYXRhLT5mYW5fZGl2W25yXSA9IDI7IGJyZWFrOworCWNh
c2UgODogZGF0YS0+ZmFuX2Rpdltucl0gPSAzOyBicmVhazsKKwlkZWZhdWx0
OgorCQlkZXZfZXJyKCZjbGllbnQtPmRldiwgImZhbl9kaXYgdmFsdWUgJWxk
IG5vdCAiCisJCQkic3VwcG9ydGVkLiBDaG9vc2Ugb25lIG9mIDEsIDIsIDQg
b3IgOCFcbiIsIHZhbCk7CisJCXJldHVybiAtRUlOVkFMOworCX0KIAogCXJl
ZyA9IChsbTgwX3JlYWRfdmFsdWUoY2xpZW50LCBMTTgwX1JFR19GQU5ESVYp
ICYgfigzIDw8ICgyICogKG5yICsgMSkpKSkKIAkgICAgfCAoZGF0YS0+ZmFu
X2Rpdltucl0gPDwgKDIgKiAobnIgKyAxKSkpOwpAQCAtMzI3LDcgKzMzNCw3
IEBAIHNldF90ZW1wKG9zX2h5c3QsIHRlbXBfb3NfaHlzdCwgTE04MF9SRUcK
IHN0YXRpYyBzc2l6ZV90IHNob3dfYWxhcm1zKHN0cnVjdCBkZXZpY2UgKmRl
diwgY2hhciAqYnVmKQogewogCXN0cnVjdCBsbTgwX2RhdGEgKmRhdGEgPSBs
bTgwX3VwZGF0ZV9kZXZpY2UoZGV2KTsKLQlyZXR1cm4gc3ByaW50ZihidWYs
ICIlZFxuIiwgQUxBUk1TX0ZST01fUkVHKGRhdGEtPmFsYXJtcykpOworCXJl
dHVybiBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCBkYXRhLT5hbGFybXMpOwogfQog
CiBzdGF0aWMgREVWSUNFX0FUVFIoaW4wX21pbiwgU19JV1VTUiB8IFNfSVJV
R08sIHNob3dfaW5fbWluMCwgc2V0X2luX21pbjApOwo=

--0-2038931049-1106760690=:38054--
