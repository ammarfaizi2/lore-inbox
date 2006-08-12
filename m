Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWHLO3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWHLO3l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWHLO3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:29:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:52445 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932536AbWHLO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:29:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=YyGbxTmcdTXkMqAjNzcgU14AkKicEwMFzZwqjd4nKBP2MbIzze+O+xKhK5drOscAVgBNqpuDBYbyOJCXK4heJlLJfRBV4CXn5Cq12tpOew+Y5qf+4S4rItFOwrtVswR4r3xlBpmxjtF7lR7yYe4TR4EinSs5A6PbUldvTG/e1pk=
Message-ID: <81b0412b0608120729m42b0c5b5n9f0a06b27796452c@mail.gmail.com>
Date: Sat, 12 Aug 2006 16:29:38 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>, "Paul Mackerras" <paulus@samba.org>
Subject: powerpc: "make install" broken
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_115349_27677529.1155392978789"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_115349_27677529.1155392978789
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I don't know if ever worked before, just tried today on v2.6.17.
Maybe it works, but then it is very different to i386
where it is plain "make install".

I copied the implementation attached from i386 (modified a bit), which
fixed it for me. Maybe the patch will motivate someone to fix it properly...

------=_Part_115349_27677529.1155392978789
Content-Type: text/x-patch; name=ppc-fix-make-install.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqs34t3b
Content-Disposition: attachment; filename="ppc-fix-make-install.patch"

RnJvbSBkM2Q0YmU1NTYzYzY4Yjk2Nzg0MWIxN2NmNTU1N2RmNWQ3YmZjNGRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBTYXQsIDEyIEF1ZyAyMDA2IDE1OjM4OjQyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZml4IG1h
a2UgaW5zdGFsbCBvbiBwcGMKCi0tLQogYXJjaC9wb3dlcnBjL01ha2VmaWxlICAgICAgfCAgICAz
ICsrKwogYXJjaC9wb3dlcnBjL2Jvb3QvTWFrZWZpbGUgfCAgICA0ICsrLS0KIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
cG93ZXJwYy9NYWtlZmlsZSBiL2FyY2gvcG93ZXJwYy9NYWtlZmlsZQppbmRleCBlZDViMjZhLi5k
MmM1MzBkIDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvTWFrZWZpbGUKKysrIGIvYXJjaC9wb3dl
cnBjL01ha2VmaWxlCkBAIC0xNTYsNiArMTU2LDkgQEAgYm9vdCA6PSBhcmNoLyQoQVJDSCkvYm9v
dAogJChCT09UX1RBUkdFVFMpOiB2bWxpbnV4CiAJJChRKSQoTUFLRSkgQVJDSD1wcGM2NCAkKGJ1
aWxkKT0kKGJvb3QpICQocGF0c3Vic3QgJSwkKGJvb3QpLyUsJEApCiAKK2luc3RhbGw6IHZtbGlu
dXgKKwkkKFEpJChNQUtFKSBBUkNIPXBwYzY0ICQoYnVpbGQpPSQoYm9vdCkgQk9PVElNQUdFPSQo
S0JVSUxEX0lNQUdFKSBpbnN0YWxsCisKIGRlZmluZSBhcmNoaGVscAogICBAZWNobyAnKiB6SW1h
Z2UgICAgICAgICAgLSBDb21wcmVzc2VkIGtlcm5lbCBpbWFnZSAoYXJjaC8kKEFSQ0gpL2Jvb3Qv
ekltYWdlLiopJwogICBAZWNobyAnICBpbnN0YWxsICAgICAgICAgLSBJbnN0YWxsIGtlcm5lbCB1
c2luZycKZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9ib290L01ha2VmaWxlIGIvYXJjaC9wb3dl
cnBjL2Jvb3QvTWFrZWZpbGUKaW5kZXggODQwYWU1OS4uNmJmYzNlYyAxMDA2NDQKLS0tIGEvYXJj
aC9wb3dlcnBjL2Jvb3QvTWFrZWZpbGUKKysrIGIvYXJjaC9wb3dlcnBjL2Jvb3QvTWFrZWZpbGUK
QEAgLTIwOSw3ICsyMDksNyBAQCBleHRyYS15CQkrPSB2bWxpbnV4LmJpbiB2bWxpbnV4Lmd6CiAJ
QGVjaG8gLW4gJyAgSW1hZ2U6ICRAICcKIAlAaWYgWyAtZiAkQCBdOyB0aGVuIGVjaG8gJ2lzIHJl
YWR5JyA7IGVsc2UgZWNobyAnbm90IG1hZGUnOyBmaQogCi1pbnN0YWxsOiAkKENPTkZJR1VSRSkg
JChCT09USU1BR0UpCi0Jc2ggLXggJChzcmN0cmVlKS8kKHNyYykvaW5zdGFsbC5zaCAiJChLRVJO
RUxSRUxFQVNFKSIgdm1saW51eCBTeXN0ZW0ubWFwICIkKElOU1RBTExfUEFUSCkiICIkKEJPT1RJ
TUFHRSkiCitpbnN0YWxsOgorCXNoICQoc3JjdHJlZSkvJChzcmMpL2luc3RhbGwuc2ggIiQoS0VS
TkVMUkVMRUFTRSkiIHZtbGludXggU3lzdGVtLm1hcCAiJChJTlNUQUxMX1BBVEgpIgogCiBjbGVh
bi1maWxlcyArPSAkKGFkZHByZWZpeCAkKG9ianRyZWUpLywgJChvYmotYm9vdCkgdm1saW51eC5z
dHJpcCkKLS0gCjEuNC4xLmdiYWQ0Cgo=
------=_Part_115349_27677529.1155392978789--
