Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUBCBkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbUBCBkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:40:39 -0500
Received: from [211.167.76.68] ([211.167.76.68]:9616 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265916AbUBCBk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:40:27 -0500
Date: Tue, 3 Feb 2004 09:37:54 +0800
From: Hugang <hugang@soulinfo.com>
To: Marco Giordani <marco@bononia.it>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp2 on ppc [Re: Software Suspend 2.0]
Message-Id: <20040203093754.194ecba1@localhost>
In-Reply-To: <20040202170125.GA5245@cs.unibo.it>
References: <20040201150827.2858bf9b@localhost>
	<20040202170125.GA5245@cs.unibo.it>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__3_Feb_2004_09_37_54_+0800_3AIcESH9J_0/9xgC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__3_Feb_2004_09_37_54_+0800_3AIcESH9J_0/9xgC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2004 18:01:25 +0100
Marco Giordani <marco@bononia.it> wrote:

> On Sun, Feb 01, 2004 at 03:08:27PM +0800, Hugang wrote:
> > Here is the ppc swsusp2 update patch for 2.6.1 + rc6 + 2.0, please
> > apply.
> 
> It doesn't work for me. During "write cache" phase, at 75% of the
> progress bar, my powerbook powers off the LCD backlight and it seems
> locked... at this point I can only power off the system...  Any idea?
Show us the detail.

> 
> BTW, I cannot compile your patch with highmem support. It will be very
> useful for me...
Attached file is fix highmem problem, I'm can't sure that not mistake,
can some ppc guys with double check.:) But you can try.

> 
> I've also tried the benh's pmdisk patch and it works fine but it lacks
> highmem support too.

I have some advice:
 1: Be sure before suspend have not unused device to used.
   I'm make all the possible device into module, before suspend rmmod
it as possible, after it reload it.
 2: You can enable swsusp2, that's useful debug.
   before suspend do  
     echo 6 > /proc/swsusp/default_console_level
 3: shared you kernel information.
    dmesg >> /tmp/bug.log
    cat /proc/swsusp/debug_info >> /tmp/bug.log
    send /tmp/bug.log to LKML.
-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

--Multipart=_Tue__3_Feb_2004_09_37_54_+0800_3AIcESH9J_0/9xgC
Content-Type: application/octet-stream;
 name="highmem.h.patch"
Content-Disposition: attachment;
 filename="highmem.h.patch"
Content-Transfer-Encoding: base64

LS0tIG9yaWcvaW5jbHVkZS9hc20tcHBjL2hpZ2htZW0uaAorKysgbW9kL2luY2x1ZGUvYXNtLXBw
Yy9oaWdobWVtLmgKQEAgLTMwLDYgKzMwLDcgQEAKIAogLyogdW5kZWYgZm9yIHByb2R1Y3Rpb24g
Ki8KICNkZWZpbmUgSElHSE1FTV9ERUJVRyAxCitleHRlcm4gdW5zaWduZWQgbG9uZyBoaWdoc3Rh
cnRfcGZuOwogCiBleHRlcm4gcHRlX3QgKmttYXBfcHRlOwogZXh0ZXJuIHBncHJvdF90IGttYXBf
cHJvdDsK

--Multipart=_Tue__3_Feb_2004_09_37_54_+0800_3AIcESH9J_0/9xgC
Content-Type: application/octet-stream;
 name="init.c.patch"
Content-Disposition: attachment;
 filename="init.c.patch"
Content-Transfer-Encoding: base64

LS0tIG9yaWcvYXJjaC9wcGMvbW0vaW5pdC5jCisrKyBtb2QvYXJjaC9wcGMvbW0vaW5pdC5jCkBA
IC0zODgsNiArMzg4LDEwIEBACiAJZnJlZV9hcmVhX2luaXQoem9uZXNfc2l6ZSk7CiB9CiAKKyNp
ZmRlZiBDT05GSUdfSElHSE1FTQordW5zaWduZWQgbG9uZyBoaWdoc3RhcnRfcGZuOworI2VuZGlm
CisKIHZvaWQgX19pbml0IG1lbV9pbml0KHZvaWQpCiB7CiAJdW5zaWduZWQgbG9uZyBhZGRyOwpA
QCAtMzk1LDEwICszOTksOSBAQAogCWludCBkYXRhcGFnZXMgPSAwOwogCWludCBpbml0cGFnZXMg
PSAwOwogI2lmZGVmIENPTkZJR19ISUdITUVNCi0JdW5zaWduZWQgbG9uZyBoaWdobWVtX21hcG5y
OwogCi0JaGlnaG1lbV9tYXBuciA9IHRvdGFsX2xvd21lbSA+PiBQQUdFX1NISUZUOwotCWhpZ2ht
ZW1fc3RhcnRfcGFnZSA9IG1lbV9tYXAgKyBoaWdobWVtX21hcG5yOworCWhpZ2hzdGFydF9wZm4g
PSB0b3RhbF9sb3dtZW0gPj4gUEFHRV9TSElGVDsKKwloaWdobWVtX3N0YXJ0X3BhZ2UgPSBtZW1f
bWFwICsgaGlnaHN0YXJ0X3BmbjsKICNlbmRpZiAvKiBDT05GSUdfSElHSE1FTSAqLwogCW1heF9t
YXBuciA9IHRvdGFsX21lbW9yeSA+PiBQQUdFX1NISUZUOwogCkBAIC00NTEsNyArNDU0LDcgQEAK
IAl7CiAJCXVuc2lnbmVkIGxvbmcgcGZuOwogCi0JCWZvciAocGZuID0gaGlnaG1lbV9tYXBucjsg
cGZuIDwgbWF4X21hcG5yOyArK3BmbikgeworCQlmb3IgKHBmbiA9IGhpZ2hzdGFydF9wZm47IHBm
biA8IG1heF9tYXBucjsgKytwZm4pIHsKIAkJCXN0cnVjdCBwYWdlICpwYWdlID0gbWVtX21hcCAr
IHBmbjsKIAogCQkJQ2xlYXJQYWdlUmVzZXJ2ZWQocGFnZSk7Cg==

--Multipart=_Tue__3_Feb_2004_09_37_54_+0800_3AIcESH9J_0/9xgC--
