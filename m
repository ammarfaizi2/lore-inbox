Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVI1XFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVI1XFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVI1XFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:05:19 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:19475 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751161AbVI1XFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:05:16 -0400
Message-ID: <433B217C.2050407@vmware.com>
Date: Wed, 28 Sep 2005 16:04:28 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Jeffrey Sheldon <jeffshel@vmware.com>, Ole Agesen <agesen@vmware.com>,
       Shai Fultheim <shai@scalex86.org>, Andrew Morton <akpm@odsl.org>,
       Jack Lo <jlo@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 3/3] Gdt hotplug
References: <200509282144.j8SLi53a032237@zach-dev.vmware.com> <200509290015.02973.ak@suse.de>
In-Reply-To: <200509290015.02973.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------000309020106030106000404"
X-OriginalArrivalTime: 28 Sep 2005 23:04:28.0626 (UTC) FILETIME=[FA6D6B20:01C5C480]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000309020106030106000404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

>On Wednesday 28 September 2005 23:44, Zachary Amsden wrote:
>  
>
>>As suggested by Andi Kleen, don't allocate a GDT page if there is already
>>one present.  Needed for CPU hotplug.
>>    
>>
>
>Did I really suggest that? I think I suggested checking the return
>value of gfp. Also get_zeroed_page() is slightly cleaner than GFP_ZERO.
>  
>

Then I think this looks better all around.


--------------000309020106030106000404
Content-Type: text/plain;
 name="gdt-hotplug"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="gdt-hotplug"

QXMgc3VnZ2VzdGVkIGJ5IEFuZGkgS2xlZW4sIGRvbid0IGFsbG9jYXRlIGEgR0RUIHBhZ2Ug
aWYgdGhlcmUgaXMgYWxyZWFkeSBvbmUKcHJlc2VudC4gIE5lZWRlZCBmb3IgQ1BVIGhvdHBs
dWcuCgpTaWduZWQtb2ZmLWJ5OiBaYWNoYXJ5IEFtc2RlbiA8emFjaEB2bXdhcmUuY29tPgpJ
bmRleDogbGludXgtMi42LjE0LXJjMi9hcmNoL2kzODYva2VybmVsL3NtcGJvb3QuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMTQtcmMyLm9yaWcvYXJjaC9pMzg2L2tlcm5lbC9z
bXBib290LmMJMjAwNS0wOS0yOCAxNTo0OToyNi4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4
LTIuNi4xNC1yYzIvYXJjaC9pMzg2L2tlcm5lbC9zbXBib290LmMJMjAwNS0wOS0yOCAxNjow
MDo1NS4wMDAwMDAwMDAgLTA3MDAKQEAgLTg3NCw2ICs4NzQsMTIgQEAgc3RhdGljIGludCBf
X2RldmluaXQgZG9fYm9vdF9jcHUoaW50IGFwaQogCXVuc2lnbmVkIGxvbmcgc3RhcnRfZWlw
OwogCXVuc2lnbmVkIHNob3J0IG5taV9oaWdoID0gMCwgbm1pX2xvdyA9IDA7CiAKKwlpZiAo
IWNwdV9nZHRfZGVzY3JbY3B1XS5hZGRyZXNzICYmCisJICAgICEoY3B1X2dkdF9kZXNjcltj
cHVdLmFkZHJlc3MgPSBnZXRfemVyb2VkX3BhZ2UoR0ZQX0tFUk5FTCkpKSB7CisJCXByaW50
aygiRmFpbGVkIHRvIGFsbG9jYXRlIEdEVCBmb3IgQ1BVICVkXG4iLCBjcHUpOworCQlyZXR1
cm4gMTsKKwl9CisKIAkrK2NwdWNvdW50OwogCiAJLyoKQEAgLTg5OCw4ICs5MDQsNiBAQCBz
dGF0aWMgaW50IF9fZGV2aW5pdCBkb19ib290X2NwdShpbnQgYXBpCiAJICogVGhpcyBncnVu
Z2UgcnVucyB0aGUgc3RhcnR1cCBwcm9jZXNzIGZvcgogCSAqIHRoZSB0YXJnZXRlZCBwcm9j
ZXNzb3IuCiAJICovCi0JY3B1X2dkdF9kZXNjcltjcHVdLmFkZHJlc3MgPSBfX2dldF9mcmVl
X3BhZ2UoR0ZQX0tFUk5FTHxfX0dGUF9aRVJPKTsKLQogCWF0b21pY19zZXQoJmluaXRfZGVh
c3NlcnRlZCwgMCk7CiAKIAlEcHJpbnRrKCJTZXR0aW5nIHdhcm0gcmVzZXQgY29kZSBhbmQg
dmVjdG9yLlxuIik7Cg==
--------------000309020106030106000404--
