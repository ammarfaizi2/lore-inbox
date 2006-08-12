Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWHLO70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWHLO70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHLO70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:59:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1369 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932544AbWHLO70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:59:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=nxOPlTUldHaoZo41hCh6Xr8/vjg0T0aAabczh0Nef51ZW3nh8aGLz8pHEib5AOIbTC2hM6bccVy3Wt6IHxAjdwiLOShrsTmcrvEALH14Wf1gaTi/l8PkwfYnBEqIzNRvaG5lEbJ4/tEhbYcej7xSRTNCk+LpaZH1HB9z2dZoOFc=
Message-ID: <81b0412b0608120759h313bbdc9hfd6e3b3acd8a3d3d@mail.gmail.com>
Date: Sat, 12 Aug 2006 16:59:24 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: powerpc: "make install" broken
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Paul Mackerras" <paulus@samba.org>
In-Reply-To: <20060812143451.GA18642@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_115557_11892255.1155394764127"
References: <81b0412b0608120729m42b0c5b5n9f0a06b27796452c@mail.gmail.com>
	 <20060812143451.GA18642@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_115557_11892255.1155394764127
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/12/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> > I don't know if ever worked before, just tried today on v2.6.17.
> > Maybe it works, but then it is very different to i386
> > where it is plain "make install".
> >
> > I copied the implementation attached from i386 (modified a bit), which
> > fixed it for me. Maybe the patch will motivate someone to fix it properly...
> NACK - the install target shall not try to build the kernel - the
> vmlinux dependency is long gone from i386.

Agreed, updated, rediffed, attached
(sorry for attach, that's gmail).

------=_Part_115557_11892255.1155394764127
Content-Type: text/x-patch; name=ppc-fix-make-install.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqs463gh
Content-Disposition: attachment; filename="ppc-fix-make-install.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9NYWtlZmlsZSBiL2FyY2gvcG93ZXJwYy9NYWtlZmls
ZQppbmRleCBlZDViMjZhLi44NWIwYzRiIDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvTWFrZWZp
bGUKKysrIGIvYXJjaC9wb3dlcnBjL01ha2VmaWxlCkBAIC0xNTYsNiArMTU2LDkgQEAgYm9vdCA6
PSBhcmNoLyQoQVJDSCkvYm9vdAogJChCT09UX1RBUkdFVFMpOiB2bWxpbnV4CiAJJChRKSQoTUFL
RSkgQVJDSD1wcGM2NCAkKGJ1aWxkKT0kKGJvb3QpICQocGF0c3Vic3QgJSwkKGJvb3QpLyUsJEAp
CiAKK2luc3RhbGw6CisJJChRKSQoTUFLRSkgQVJDSD1wcGM2NCAkKGJ1aWxkKT0kKGJvb3QpIEJP
T1RJTUFHRT0kKEtCVUlMRF9JTUFHRSkgaW5zdGFsbAorCiBkZWZpbmUgYXJjaGhlbHAKICAgQGVj
aG8gJyogekltYWdlICAgICAgICAgIC0gQ29tcHJlc3NlZCBrZXJuZWwgaW1hZ2UgKGFyY2gvJChB
UkNIKS9ib290L3pJbWFnZS4qKScKICAgQGVjaG8gJyAgaW5zdGFsbCAgICAgICAgIC0gSW5zdGFs
bCBrZXJuZWwgdXNpbmcnCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvYm9vdC9NYWtlZmlsZSBi
L2FyY2gvcG93ZXJwYy9ib290L01ha2VmaWxlCmluZGV4IDg0MGFlNTkuLjZiZmMzZWMgMTAwNjQ0
Ci0tLSBhL2FyY2gvcG93ZXJwYy9ib290L01ha2VmaWxlCisrKyBiL2FyY2gvcG93ZXJwYy9ib290
L01ha2VmaWxlCkBAIC0yMDksNyArMjA5LDcgQEAgZXh0cmEteQkJKz0gdm1saW51eC5iaW4gdm1s
aW51eC5negogCUBlY2hvIC1uICcgIEltYWdlOiAkQCAnCiAJQGlmIFsgLWYgJEAgXTsgdGhlbiBl
Y2hvICdpcyByZWFkeScgOyBlbHNlIGVjaG8gJ25vdCBtYWRlJzsgZmkKIAotaW5zdGFsbDogJChD
T05GSUdVUkUpICQoQk9PVElNQUdFKQotCXNoIC14ICQoc3JjdHJlZSkvJChzcmMpL2luc3RhbGwu
c2ggIiQoS0VSTkVMUkVMRUFTRSkiIHZtbGludXggU3lzdGVtLm1hcCAiJChJTlNUQUxMX1BBVEgp
IiAiJChCT09USU1BR0UpIgoraW5zdGFsbDoKKwlzaCAkKHNyY3RyZWUpLyQoc3JjKS9pbnN0YWxs
LnNoICIkKEtFUk5FTFJFTEVBU0UpIiB2bWxpbnV4IFN5c3RlbS5tYXAgIiQoSU5TVEFMTF9QQVRI
KSIKIAogY2xlYW4tZmlsZXMgKz0gJChhZGRwcmVmaXggJChvYmp0cmVlKS8sICQob2JqLWJvb3Qp
IHZtbGludXguc3RyaXApCg==
------=_Part_115557_11892255.1155394764127--
