Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVAXVyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVAXVyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVAXVwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:52:25 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15333 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261635AbVAXVvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:51:02 -0500
Date: Tue, 25 Jan 2005 01:13:30 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [1/1] superio: change scx200 module name to scx.
Message-ID: <20050125011330.3b4b8611@zanzibar.2ka.mipt.ru>
In-Reply-To: <29495f1d05012413415c66974b@mail.gmail.com>
References: <20050124233720.484c7ad0@zanzibar.2ka.mipt.ru>
	<29495f1d05012413415c66974b@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__25_Jan_2005_01_13_30_+0300_YmXOfa+brsJLmyMS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__25_Jan_2005_01_13_30_+0300_YmXOfa+brsJLmyMS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jan 2005 13:41:33 -0800
Nish Aravamudan <nish.aravamudan@gmail.com> wrote:

> > +               set_current_state(TASK_INTERRUPTIBLE);
> > +               schedule_timeout(HZ);
> > +
> > +               if (current->flags & PF_FREEZE)
> > +                       refrigerator(PF_FREEZE);
> > +
> > +               if (signal_pending(current))
> > +                       flush_signals(current);
> > +       }
> 
> <snip>
> 
> I believe this schedule_timeout() call can be an msleep_interruptible(1000).

Patch was already sent to Greg, it will be included in next release.
Attached one with fixed scx200/scx filename.
 
> Thanks,
> Nish


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

--Multipart=_Tue__25_Jan_2005_01_13_30_+0300_YmXOfa+brsJLmyMS
Content-Type: application/octet-stream;
 name="msleep_superio.patch"
Content-Disposition: attachment;
 filename="msleep_superio.patch"
Content-Transfer-Encoding: base64

VXNlIG1zbGVlcCogY2FsbHMgaW5zdGVhZCBvZiBkaXJlY3Qgc2NoZWR1bGUqIGNhbGxzLgoKU2ln
bmVkLW9mZi1ieTogRXZnZW5peSBQb2x5YWtvdiA8am9obnBvbEAya2EubWlwdC5ydT4KCi0tLSBs
aW51eC0yLjYvZHJpdmVycy9zdXBlcmlvL3BjODczNnguYy5vcmlnCTIwMDUtMDEtMjEgMjE6Mzc6
MDUuNTY1ODUwMzI4ICswMzAwCisrKyBsaW51eC0yLjYvZHJpdmVycy9zdXBlcmlvL3BjODczNngu
YwkyMDA1LTAxLTIxIDIxOjM3OjM3LjExMzA1NDQyNCArMDMwMApAQCAtMTkwLDE1ICsxOTAsMTUg
QEAKIAl3aGlsZSAoYXRvbWljX3JlYWQoJnBjODczNnhfZGV2LnJlZmNudCkpIHsKIAkJcHJpbnRr
KEtFUk5fSU5GTyAiV2FpdGluZyBmb3IgJXMgdG8gYmVjYW1lIGZyZWU6IHJlZmNudD0lZC5cbiIs
CiAJCQkJcGM4NzM2eF9kZXYubmFtZSwgYXRvbWljX3JlYWQoJnBjODczNnhfZGV2LnJlZmNudCkp
OwotCQkKLQkJc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19JTlRFUlJVUFRJQkxFKTsKLQkJc2NoZWR1
bGVfdGltZW91dChIWik7CisKKwkJbXNsZWVwX2ludGVycnVwdGlibGUoMTAwMCk7CisKKwkJaWYg
KHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKQorCQkJZmx1c2hfc2lnbmFscyhjdXJyZW50KTsKIAkJ
CQogCQlpZiAoY3VycmVudC0+ZmxhZ3MgJiBQRl9GUkVFWkUpCiAJCQlyZWZyaWdlcmF0b3IoUEZf
RlJFRVpFKTsKIAotCQlpZiAoc2lnbmFsX3BlbmRpbmcoY3VycmVudCkpCi0JCQlmbHVzaF9zaWdu
YWxzKGN1cnJlbnQpOwogCX0KIH0KIAotLS0gbGludXgtMi42L2RyaXZlcnMvc3VwZXJpby9zYy5j
Lm9yaWcJMjAwNS0wMS0yMSAyMTozNzoxMC44NjIwNDUxODQgKzAzMDAKKysrIGxpbnV4LTIuNi9k
cml2ZXJzL3N1cGVyaW8vc2MuYwkyMDA1LTAxLTIxIDIxOjM4OjM2LjEzNzA4MTQwOCArMDMwMApA
QCAtMzcwLDE0ICszNzAsMTQgQEAKIAkJICAgICAgIGxkZXYtPm5hbWUsIGxkZXYtPmluZGV4LAog
CQkgICAgICAgKHNjX2xkZXZfaXNfY2xvbmUobGRldikpID8gImNsb25lIiA6ICJub3QgY2xvbmUi
LAogCQkgICAgICAgYXRvbWljX3JlYWQoJmxkZXYtPnJlZmNudCkpOwotCQlzZXRfY3VycmVudF9z
dGF0ZShUQVNLX0lOVEVSUlVQVElCTEUpOwotCQlzY2hlZHVsZV90aW1lb3V0KEhaKTsKLQkJCQot
CQlpZiAoY3VycmVudC0+ZmxhZ3MgJiBQRl9GUkVFWkUpCi0JCQlyZWZyaWdlcmF0b3IoUEZfRlJF
RVpFKTsKKworCQltc2xlZXBfaW50ZXJydXB0aWJsZSgxMDAwKTsKIAogCQlpZiAoc2lnbmFsX3Bl
bmRpbmcoY3VycmVudCkpCiAJCQlmbHVzaF9zaWduYWxzKGN1cnJlbnQpOworCQkJCisJCWlmIChj
dXJyZW50LT5mbGFncyAmIFBGX0ZSRUVaRSkKKwkJCXJlZnJpZ2VyYXRvcihQRl9GUkVFWkUpOwog
CX0KIAogfQpAQCAtNDgyLDE0ICs0ODIsMTQgQEAKIAl3aGlsZSAoYXRvbWljX3JlYWQoJl9fc2Rl
di0+cmVmY250KSkgewogCQlwcmludGsoS0VSTl9JTkZPICJXYWl0aW5nIFN1cGVySU8gY2hpcCAl
cyB0byBiZWNvbWUgZnJlZTogcmVmY250PSVkLlxuIiwKIAkJICAgICAgIF9fc2Rldi0+bmFtZSwg
YXRvbWljX3JlYWQoJl9fc2Rldi0+cmVmY250KSk7Ci0JCXNldF9jdXJyZW50X3N0YXRlKFRBU0tf
VU5JTlRFUlJVUFRJQkxFKTsKLQkJc2NoZWR1bGVfdGltZW91dChIWik7Ci0JCQkKLQkJaWYgKGN1
cnJlbnQtPmZsYWdzICYgUEZfRlJFRVpFKQotCQkJcmVmcmlnZXJhdG9yKFBGX0ZSRUVaRSk7CisK
KwkJbXNsZWVwX2ludGVycnVwdGlibGUoMTAwMCk7CiAKIAkJaWYgKHNpZ25hbF9wZW5kaW5nKGN1
cnJlbnQpKQogCQkJZmx1c2hfc2lnbmFscyhjdXJyZW50KTsKKwkJCQorCQlpZiAoY3VycmVudC0+
ZmxhZ3MgJiBQRl9GUkVFWkUpCisJCQlyZWZyaWdlcmF0b3IoUEZfRlJFRVpFKTsKIAl9CiB9CiAK
LS0tIGxpbnV4LTIuNi9kcml2ZXJzL3N1cGVyaW8vc2N4LmMub3JpZwkyMDA1LTAxLTIxIDIxOjM3
OjE1Ljk0NDI3MjU2OCArMDMwMAorKysgbGludXgtMi42L2RyaXZlcnMvc3VwZXJpby9zY3guYwky
MDA1LTAxLTIxIDIxOjM5OjAyLjI4MDEwNzA2NCArMDMwMApAQCAtMzkxLDE0ICszOTEsMTQgQEAK
IAl7CiAJCXByaW50ayhLRVJOX0lORk8gIldhaXRpbmcgZm9yICVzIHRvIGJlY2FtZSBmcmVlOiBy
ZWZjbnQ9JWQuXG4iLAogCQkJCXNjeDIwMF9kZXYubmFtZSwgYXRvbWljX3JlYWQoJnNjeDIwMF9k
ZXYucmVmY250KSk7Ci0JCXNldF9jdXJyZW50X3N0YXRlKFRBU0tfSU5URVJSVVBUSUJMRSk7Ci0J
CXNjaGVkdWxlX3RpbWVvdXQoSFopOwotCQkJCi0JCWlmIChjdXJyZW50LT5mbGFncyAmIFBGX0ZS
RUVaRSkKLQkJCXJlZnJpZ2VyYXRvcihQRl9GUkVFWkUpOworCQkKKwkJbXNsZWVwX2ludGVycnVw
dGlibGUoMTAwMCk7CiAKIAkJaWYgKHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKQogCQkJZmx1c2hf
c2lnbmFscyhjdXJyZW50KTsKKwkJCisJCWlmIChjdXJyZW50LT5mbGFncyAmIFBGX0ZSRUVaRSkK
KwkJCXJlZnJpZ2VyYXRvcihQRl9GUkVFWkUpOwogCX0KIAogCXBjaV91bnJlZ2lzdGVyX2RyaXZl
cigmc2N4MjAwX3BjaV9kcml2ZXIpOwoK

--Multipart=_Tue__25_Jan_2005_01_13_30_+0300_YmXOfa+brsJLmyMS--
