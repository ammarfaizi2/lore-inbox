Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTEAGJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbTEAGJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:09:29 -0400
Received: from pop.gmx.de ([213.165.65.60]:661 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262694AbTEAGJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:09:27 -0400
Message-Id: <5.2.0.9.2.20030501081758.00cd5d38@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 01 May 2003 08:26:15 +0200
To: Andrew Morton <akpm@digeo.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: must-fix list for 2.6.0
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.2.20030501035717.00ca26c8@pop.gmx.net>
References: <20030430121105.454daee1.akpm@digeo.com>
 <Pine.LNX.4.51.0304301212130.1728@dns.toxicfilms.tv>
 <20030429155731.07811707.akpm@digeo.com>
 <Pine.LNX.4.51.0304301212130.1728@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_10218484==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_10218484==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 05:21 AM 5/1/2003 +0200, Mike Galbraith wrote:
>At 12:11 PM 4/30/2003 -0700, Andrew Morton wrote:
>>Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
>> >
>> >
>> > Also there is one issue, i am not sure if this may be a kernel issue,
>> > but with setiathome running in a X desktop environment all apps work fine,
>> > but when i run openoffice, openoffice responds with 5 second delay.
>>
>>That'll be the changed sched_yield() semantics.
>>
>>The below patch should fix that up, but we need to decide whether the (rather
>>unclear) advantages of the sched_yield() change outweigh the breakage which
>>it caused linuxthreads applications.

<snip>

Anyway, attached is a patchlet that works for me if anyone wants to try 
it.  I removed printk's, and whatnot but it'll have some offsets because of 
other butchery in my X-para-mental tree ;-)

         -Mike   
--=====================_10218484==_
Content-Type: application/octet-stream; name="yield.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="yield.diff"

LS0tIGtlcm5lbC9zY2hlZC5jLm9yZwlGcmkgQXByIDI1IDA2OjI0OjM0IDIwMDMKKysrIGtlcm5l
bC9zY2hlZC5jCVRodSBNYXkgIDEgMDc6Mzg6MDAgMjAwMwpAQCAtMTI2NSw3ICsxMzIzLDcgQEAK
IAlydW5xdWV1ZV90ICpycTsKIAlwcmlvX2FycmF5X3QgKmFycmF5OwogCXN0cnVjdCBsaXN0X2hl
YWQgKnF1ZXVlOwotCWludCBpZHg7CisJaW50IGlkeCA9IDA7CiAKIAkvKgogCSAqIFRlc3QgaWYg
d2UgYXJlIGF0b21pYy4gIFNpbmNlIGRvX2V4aXQoKSBuZWVkcyB0byBjYWxsIGludG8KQEAgLTEz
MzAsNyArMTM4OCwxOSBAQAogCQlycS0+ZXhwaXJlZF90aW1lc3RhbXAgPSAwOwogCX0KIAotCWlk
eCA9IHNjaGVkX2ZpbmRfZmlyc3RfYml0KGFycmF5LT5iaXRtYXApOworCWlmICghaWR4IHx8IGlk
eCA+PSBNQVhfUFJJTykKKwkJaWR4ID0gc2NoZWRfZmluZF9maXJzdF9iaXQoYXJyYXktPmJpdG1h
cCk7CisJZWxzZSB7CisJCWlkeCA9IGZpbmRfbmV4dF9iaXQoYXJyYXktPmJpdG1hcCwgTUFYX1BS
SU8sIGlkeCArIDEpOworCQlpZiAoaWR4ID49IE1BWF9QUklPKSB7CisJCQlpZHggPSAwOworCQkJ
c3Bpbl91bmxvY2tfaXJxKCZycS0+bG9jayk7CisJCQlyZWFjcXVpcmVfa2VybmVsX2xvY2soY3Vy
cmVudCk7CisJCQlwcmVlbXB0X2VuYWJsZV9ub19yZXNjaGVkKCk7CisJCQlnb3RvIG5lZWRfcmVz
Y2hlZDsKKwkJfQorCX0KKwogCXF1ZXVlID0gYXJyYXktPnF1ZXVlICsgaWR4OwogCW5leHQgPSBs
aXN0X2VudHJ5KHF1ZXVlLT5uZXh0LCB0YXNrX3QsIHJ1bl9saXN0KTsKIApAQCAtMTk4NCwxOSAr
MjA1NCwxMiBAQAogCXByaW9fYXJyYXlfdCAqYXJyYXkgPSBjdXJyZW50LT5hcnJheTsKIAogCS8q
Ci0JICogV2UgaW1wbGVtZW50IHlpZWxkaW5nIGJ5IG1vdmluZyB0aGUgdGFzayBpbnRvIHRoZSBl
eHBpcmVkCi0JICogcXVldWUuCi0JICoKLQkgKiAoc3BlY2lhbCBydWxlOiBSVCB0YXNrcyB3aWxs
IGp1c3Qgcm91bmRyb2JpbiBpbiB0aGUgYWN0aXZlCi0JICogIGFycmF5LikKKwkgKiBXZSBpbXBs
ZW1lbnQgeWllbGRpbmcgYnkgbW92aW5nIHRoZSB0YXNrIHRvIHRoZSBiYWNrIG9mCisJICogdGhl
IHF1ZXVlLgogCSAqLwotCWlmIChsaWtlbHkoIXJ0X3Rhc2soY3VycmVudCkpKSB7Ci0JCWRlcXVl
dWVfdGFzayhjdXJyZW50LCBhcnJheSk7Ci0JCWVucXVldWVfdGFzayhjdXJyZW50LCBycS0+ZXhw
aXJlZCk7Ci0JfSBlbHNlIHsKLQkJbGlzdF9kZWwoJmN1cnJlbnQtPnJ1bl9saXN0KTsKLQkJbGlz
dF9hZGRfdGFpbCgmY3VycmVudC0+cnVuX2xpc3QsIGFycmF5LT5xdWV1ZSArIGN1cnJlbnQtPnBy
aW8pOwotCX0KKwlsaXN0X2RlbCgmY3VycmVudC0+cnVuX2xpc3QpOworCWxpc3RfYWRkX3RhaWwo
JmN1cnJlbnQtPnJ1bl9saXN0LCBhcnJheS0+cXVldWUgKyBjdXJyZW50LT5wcmlvKTsKKwlzZXRf
dHNrX25lZWRfcmVzY2hlZChjdXJyZW50KTsKIAkvKgogCSAqIFNpbmNlIHdlIGFyZSBnb2luZyB0
byBjYWxsIHNjaGVkdWxlKCkgYW55d2F5LCB0aGVyZSdzCiAJICogbm8gbmVlZCB0byBwcmVlbXB0
Ogo=
--=====================_10218484==_--

