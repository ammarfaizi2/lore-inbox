Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSE2KBm>; Wed, 29 May 2002 06:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSE2KBm>; Wed, 29 May 2002 06:01:42 -0400
Received: from web10401.mail.yahoo.com ([216.136.130.93]:47634 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314690AbSE2KBl>; Wed, 29 May 2002 06:01:41 -0400
Message-ID: <20020529100141.98844.qmail@web10401.mail.yahoo.com>
Date: Wed, 29 May 2002 03:01:41 -0700 (PDT)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: softirq.c improvments
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter-devel@lists.samba.org>,
        Ralf Baechle <ralf@uni-koblenz.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1365657282-1022666501=:98652"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1365657282-1022666501=:98652
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here is a new version of the softirq patch I posted on 14 May,
I found a bug in intel where softirqs were being started when cpu_idle
was the only process on the machine really early in bootup.

My old patch didn't like this & could get caught in an infinite softirq loop.



=====
D.J. Barrow Linux kernel developer
eMail: dj_barrow@ariasoft.ie 
Home: +353-22-47196.
Work: +353-91-758353

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
--0-1365657282-1022666501=:98652
Content-Type: application/x-unknown; name="softirq_fix.v2.diff"
Content-Transfer-Encoding: base64
Content-Description: softirq_fix.v2.diff
Content-Disposition: attachment; filename="softirq_fix.v2.diff"

ZGlmZiAtdSAtciBsaW51eC5vcmlnL2luY2x1ZGUvbGludXgvc2NoZWQuaCBs
aW51eC5uZXcvaW5jbHVkZS9saW51eC9zY2hlZC5oCi0tLSBsaW51eC5vcmln
L2luY2x1ZGUvbGludXgvc2NoZWQuaAlUaHUgQXByIDE4IDE3OjQ0OjE3IDIw
MDIKKysrIGxpbnV4Lm5ldy9pbmNsdWRlL2xpbnV4L3NjaGVkLmgJV2VkIE1h
eSAyOSAxMDo1NjoyOSAyMDAyCkBAIC05MjcsNiArOTI3LDE5IEBACiAJcmV0
dXJuIHJlczsKIH0KIAorI2lmZGVmIENPTkZJR19TTVAKKworI2RlZmluZSBp
ZGxlX3Rhc2soY3B1KSAoaW5pdF90YXNrc1tjcHVfbnVtYmVyX21hcChjcHUp
XSkKKyNkZWZpbmUgY2FuX3NjaGVkdWxlKHAsY3B1KSBcCisJKChwKS0+Y3B1
c19ydW5uYWJsZSAmIChwKS0+Y3B1c19hbGxvd2VkICYgKDEgPDwgY3B1KSkK
KworI2Vsc2UKKworI2RlZmluZSBpZGxlX3Rhc2soY3B1KSAoJmluaXRfdGFz
aykKKyNkZWZpbmUgY2FuX3NjaGVkdWxlKHAsY3B1KSAoMSkKKworI2VuZGlm
CisKICNlbmRpZiAvKiBfX0tFUk5FTF9fICovCiAKICNlbmRpZgpPbmx5IGlu
IGxpbnV4Lm5ldy9pbmNsdWRlL2xpbnV4OiBzY2hlZC5oLm9yaWcKZGlmZiAt
dSAtciBsaW51eC5vcmlnL2tlcm5lbC9zY2hlZC5jIGxpbnV4Lm5ldy9rZXJu
ZWwvc2NoZWQuYwotLS0gbGludXgub3JpZy9rZXJuZWwvc2NoZWQuYwlUdWUg
QXByIDMwIDEyOjIyOjAyIDIwMDIKKysrIGxpbnV4Lm5ldy9rZXJuZWwvc2No
ZWQuYwlXZWQgTWF5IDI5IDEwOjU2OjI5IDIwMDIKQEAgLTExMiwxOCArMTEy
LDcgQEAKIHN0cnVjdCBrZXJuZWxfc3RhdCBrc3RhdDsKIGV4dGVybiBzdHJ1
Y3QgdGFza19zdHJ1Y3QgKmNoaWxkX3JlYXBlcjsKIAotI2lmZGVmIENPTkZJ
R19TTVAKIAotI2RlZmluZSBpZGxlX3Rhc2soY3B1KSAoaW5pdF90YXNrc1tj
cHVfbnVtYmVyX21hcChjcHUpXSkKLSNkZWZpbmUgY2FuX3NjaGVkdWxlKHAs
Y3B1KSBcCi0JKChwKS0+Y3B1c19ydW5uYWJsZSAmIChwKS0+Y3B1c19hbGxv
d2VkICYgKDEgPDwgY3B1KSkKLQotI2Vsc2UKLQotI2RlZmluZSBpZGxlX3Rh
c2soY3B1KSAoJmluaXRfdGFzaykKLSNkZWZpbmUgY2FuX3NjaGVkdWxlKHAs
Y3B1KSAoMSkKLQotI2VuZGlmCiAKIHZvaWQgc2NoZWR1bGluZ19mdW5jdGlv
bnNfc3RhcnRfaGVyZSh2b2lkKSB7IH0KIApkaWZmIC11IC1yIGxpbnV4Lm9y
aWcva2VybmVsL3NvZnRpcnEuYyBsaW51eC5uZXcva2VybmVsL3NvZnRpcnEu
YwotLS0gbGludXgub3JpZy9rZXJuZWwvc29mdGlycS5jCVdlZCBPY3QgMzEg
MTg6MjY6MDIgMjAwMQorKysgbGludXgubmV3L2tlcm5lbC9zb2Z0aXJxLmMJ
V2VkIE1heSAyOSAxMDo1Njo1OSAyMDAyCkBAIC02MCwxMSArNjAsMTEgQEAK
IAogYXNtbGlua2FnZSB2b2lkIGRvX3NvZnRpcnEoKQogeworICAgICAgICBl
eHRlcm4gc3RydWN0IHRhc2tfc3RydWN0ICpjaGlsZF9yZWFwZXI7CiAJaW50
IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKIAlfX3UzMiBwZW5kaW5nOwog
CWxvbmcgZmxhZ3M7CiAJX191MzIgbWFzazsKLQogCWlmIChpbl9pbnRlcnJ1
cHQoKSkKIAkJcmV0dXJuOwogCkBAIC05NSw3ICs5NSwxMCBAQAogCQlsb2Nh
bF9pcnFfZGlzYWJsZSgpOwogCiAJCXBlbmRpbmcgPSBzb2Z0aXJxX3BlbmRp
bmcoY3B1KTsKLQkJaWYgKHBlbmRpbmcgJiBtYXNrKSB7CisgICAgICAgICAg
ICAgICAgLyogSWYgY2hpbGQgcmVhcGVyIT1pbml0X3Rhc2sgd2UgaGF2ZSBm
aW5pc2hlZCB0aGUgaW5pdGlhbCBib290c3RyYXAgJiBoYXZlbid0IHJlY2Vp
dmVkIGFuIGVhcmx5IHNvZnRpcnEgKi8KKyAgICAgICAgICAgICAgICAvKiB3
aGVuIHRoZSBpZGxlX3Rhc2sgaXMgdGhlIG9ubHkgdGFzayBydW5uaW5nICov
CisJCWlmICgocGVuZGluZyAmJiBjdXJyZW50PT1pZGxlX3Rhc2soY3B1KSAm
JiAhY3VycmVudC0+bmVlZF9yZXNjaGVkICYmIGNoaWxkX3JlYXBlciAhPSAm
aW5pdF90YXNrICkKKwkJICAgIHx8IChwZW5kaW5nICYgbWFzaykgKSB7CiAJ
CQltYXNrICY9IH5wZW5kaW5nOwogCQkJZ290byByZXN0YXJ0OwogCQl9Cg==


--0-1365657282-1022666501=:98652--
