Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSEPXiu>; Thu, 16 May 2002 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSEPXiu>; Thu, 16 May 2002 19:38:50 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:55330 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S315202AbSEPXit>; Thu, 16 May 2002 19:38:49 -0400
Message-Id: <200205162338.AWF04364@netmail.netcologne.de>
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre8 #4 Don Mai 9 23:37:47 CEST 2002 i686 unknown
To: quintela@mandrakesoft.com
Subject: [PATCH] fixing supermount for > 2.4.19pre4
Date: Fri, 17 May 2002 01:36:22 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E178TUb-0005Bh-00@the-village.bc.nu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_MK981SXI439JQ2I14B9A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_MK981SXI439JQ2I14B9A
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Hi,

in 2.4.19pre4, the dentry revalidation has been patched, and the VFS behavior 
has changed due to an NFS bugfix. All non-standard remote file systems (like 
supermount, ftpfs, etc.) are in conflict with the patch and may not operate 
correctly.

Alan Cox pointed out that non-standard remote file systems should get fixed 
for 2.4.19. So, here is my quick hack for supermount 0.7 that changes the 
return policy in the d_revalidate operation. Supermount should work now in 
2.4.19pre4 kernels and higher.

Other file systems with similar revalidate policy can get fixed accordingly.

Cheers,

Jörg

--------------Boundary-00=_MK981SXI439JQ2I14B9A
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="supermount-2.4.19pre8-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="supermount-2.4.19pre8-fix.patch"

LS0tIGxpbnV4L2ZzL3N1cGVybW91bnQvZGVudHJ5X29wZXJhdGlvbnMuYy5vcmlnCUZyaSBNYXkg
MTcgMDA6MzY6MjEgMjAwMgorKysgbGludXgvZnMvc3VwZXJtb3VudC9kZW50cnlfb3BlcmF0aW9u
cy5jCUZyaSBNYXkgMTcgMDE6MTY6MDYgMjAwMgpAQCAtMjUsOCArMjUsOSBAQAogCiAJZHVtcF9k
ZW50cnkoZGVudHJ5KTsKIAotCWlmICghc3ViZnNfZ29fb25saW5lKGRlbnRyeS0+ZF9zYikpCi0J
CWdvdG8gYmFkX2RlbnRyeTsKKwlpZiAoIXN1YmZzX2dvX29ubGluZShkZW50cnktPmRfc2IpKSB7
CisJCWdvdG8gb3V0OworICAgIH0KIAlzcGluX2xvY2soJmRjYWNoZV9sb2NrKTsKIAlpZiAoZGVu
dHJ5LT5kX2lub2RlICYmIGlzX2lub2RlX29ic29sZXRlKGRlbnRyeS0+ZF9pbm9kZSkpIHsKIAkJ
c3VwZXJtb3VudF9kZWJ1ZygiZm91bmQgb2xkIGRlbnRyeTogKiolcyoqIiwKQEAgLTM2LDIwICsz
NywyMSBAQAogCX0KIAlzcGluX3VubG9jaygmZGNhY2hlX2xvY2spOwogCXN1YmQgPSBnZXRfc3Vi
ZnNfZGVudHJ5KGRlbnRyeSk7Ci0JaWYgKElTX0VSUihzdWJkKSkKKwlpZiAoSVNfRVJSKHN1YmQp
KSB7CiAJCWdvdG8gYmFkX2RlbnRyeTsKKwl9CiAKIAlpZiAoc3ViZC0+ZF9vcCAmJiBzdWJkLT5k
X29wLT5kX3JldmFsaWRhdGUpIHsKIAkJc3VwZXJtb3VudF9kZWJ1ZygibG93bGV2ZWwgcmV2YWxp
ZGF0ZSIpOwogCQlyYyA9IHN1YmQtPmRfb3AtPmRfcmV2YWxpZGF0ZShzdWJkLCBmbGFncyk7CiAJ
fQogCWRwdXQoc3ViZCk7CisJZ290byBvdXQ7CitiYWRfZGVudHJ5OgorCXJjID0gMDsKIG91dDoK
IAlzdWJmc19nb19pbmFjdGl2ZShkZW50cnktPmRfc2IpOwogCXJldHVybiByYzsKLWJhZF9kZW50
cnk6Ci0JcmMgPSAwOwotCWdvdG8gb3V0OwogfQogCiBzdHJ1Y3QgZGVudHJ5X29wZXJhdGlvbnMg
c3VwZXJtb3VudF9kaXJfZG9wcyA9IHsK

--------------Boundary-00=_MK981SXI439JQ2I14B9A--
