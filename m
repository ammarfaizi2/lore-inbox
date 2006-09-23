Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWIWK33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWIWK33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 06:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWIWK33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 06:29:29 -0400
Received: from mail.aknet.ru ([82.179.72.26]:37897 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751218AbWIWK32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 06:29:28 -0400
Message-ID: <45150CD7.4010708@aknet.ru>
Date: Sat, 23 Sep 2006 14:30:47 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Content-Type: multipart/mixed;
 boundary="------------020409000404040800080705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020409000404040800080705
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

I am not sure at all whether this patch is appreciated
or not. The on-list query yielded no results, but I have
to try. :)

This patch removes the MNT_NOEXEC check for the PROT_EXEC
mappings. That allows to mount tmpfs with "noexec" option
without breaking the existing apps, which is what debian
wants to do for sequrity reasons:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386945
More details here:
http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0609.2/1537.html

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------020409000404040800080705
Content-Type: text/plain;
 name="mapx.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mapx.diff"

LS0tIGEvbW0vbW1hcC5jCTIwMDYtMDEtMjUgMTU6MDI6MjQuMDAwMDAwMDAwICswMzAwCisr
KyBiL21tL21tYXAuYwkyMDA2LTA5LTIxIDEzOjE5OjE1LjAwMDAwMDAwMCArMDQwMApAQCAt
ODk5LDEwICs4OTksNiBAQAogCiAJCWlmICghZmlsZS0+Zl9vcCB8fCAhZmlsZS0+Zl9vcC0+
bW1hcCkKIAkJCXJldHVybiAtRU5PREVWOwotCi0JCWlmICgocHJvdCAmIFBST1RfRVhFQykg
JiYKLQkJICAgIChmaWxlLT5mX3Zmc21udC0+bW50X2ZsYWdzICYgTU5UX05PRVhFQykpCi0J
CQlyZXR1cm4gLUVQRVJNOwogCX0KIAkvKgogCSAqIERvZXMgdGhlIGFwcGxpY2F0aW9uIGV4
cGVjdCBQUk9UX1JFQUQgdG8gaW1wbHkgUFJPVF9FWEVDPwpAQCAtOTExLDggKzkwNyw3IEBA
CiAJICogIG1vdW50ZWQsIGluIHdoaWNoIGNhc2Ugd2UgZG9udCBhZGQgUFJPVF9FWEVDLikK
IAkgKi8KIAlpZiAoKHByb3QgJiBQUk9UX1JFQUQpICYmIChjdXJyZW50LT5wZXJzb25hbGl0
eSAmIFJFQURfSU1QTElFU19FWEVDKSkKLQkJaWYgKCEoZmlsZSAmJiAoZmlsZS0+Zl92ZnNt
bnQtPm1udF9mbGFncyAmIE1OVF9OT0VYRUMpKSkKLQkJCXByb3QgfD0gUFJPVF9FWEVDOwor
CQlwcm90IHw9IFBST1RfRVhFQzsKIAogCWlmICghbGVuKQogCQlyZXR1cm4gLUVJTlZBTDsK
LS0tIGEvbW0vbm9tbXUuYwkyMDA2LTA0LTEyIDA5OjM3OjM0LjAwMDAwMDAwMCArMDQwMAor
KysgYi9tbS9ub21tdS5jCTIwMDYtMDktMjEgMTM6MjE6MzIuMDAwMDAwMDAwICswNDAwCkBA
IC00OTMsMTMgKzQ5Myw3IEBACiAJCQkJY2FwYWJpbGl0aWVzICY9IH5CRElfQ0FQX01BUF9E
SVJFQ1Q7CiAJCX0KIAotCQkvKiBoYW5kbGUgZXhlY3V0YWJsZSBtYXBwaW5ncyBhbmQgaW1w
bGllZCBleGVjdXRhYmxlCi0JCSAqIG1hcHBpbmdzICovCi0JCWlmIChmaWxlLT5mX3Zmc21u
dC0+bW50X2ZsYWdzICYgTU5UX05PRVhFQykgewotCQkJaWYgKHByb3QgJiBQUk9UX0VYRUMp
Ci0JCQkJcmV0dXJuIC1FUEVSTTsKLQkJfQotCQllbHNlIGlmICgocHJvdCAmIFBST1RfUkVB
RCkgJiYgIShwcm90ICYgUFJPVF9FWEVDKSkgeworCQlpZiAoKHByb3QgJiBQUk9UX1JFQUQp
ICYmICEocHJvdCAmIFBST1RfRVhFQykpIHsKIAkJCS8qIGhhbmRsZSBpbXBsaWNhdGlvbiBv
ZiBQUk9UX0VYRUMgYnkgUFJPVF9SRUFEICovCiAJCQlpZiAoY3VycmVudC0+cGVyc29uYWxp
dHkgJiBSRUFEX0lNUExJRVNfRVhFQykgewogCQkJCWlmIChjYXBhYmlsaXRpZXMgJiBCRElf
Q0FQX0VYRUNfTUFQKQo=
--------------020409000404040800080705--
