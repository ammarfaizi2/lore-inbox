Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVGJS3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVGJS3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVGJS11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:27:27 -0400
Received: from web52201.mail.yahoo.com ([206.190.48.124]:35411 "HELO
	web52201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262010AbVGJSZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:25:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fchYw8eBp9CdkFdQrnjwkU15ipSyK7XnSUWBvQxNSuCK43gK0uMJOZT22nnIPPAcs8YpYEA1gRgPAELtSVQ4Hd8sEkLuj8S/AGYRkfZ2WlK/DFXI9JrPmguAiZU0bDi9a3e7K3pWmhpsKwca3hVFindmK4S6E8ZxXhqeU7JYy0s=  ;
Message-ID: <20050710182548.38389.qmail@web52201.mail.yahoo.com>
Date: Sun, 10 Jul 2005 11:25:48 -0700 (PDT)
From: Shiow-wen Cheng <cheng_27513@yahoo.com>
Subject: [PATCH] Add ENOSYS into sys_io_cancel
To: bcrl@kvack.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1907975829-1121019948=:37290"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1907975829-1121019948=:37290
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Other than few exceptions (e.g. usb/gadget), none of
the current filesystems and/or drivers that has
io_cancel implemented (kiocb->ki_cancel left with
NULL). However, the io_cancel() system call
(sys_io_cancel) somehow universally sets return code
to -EAGAIN. This gives us a false impression that
io_cancel() is supported (implemented) but just never
works - would appreciate if this patch is taken.

-- s.w.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1907975829-1121019948=:37290
Content-Type: application/octet-stream; name="cancel.patch"
Content-Transfer-Encoding: base64
Content-Description: 3748003194-cancel.patch
Content-Disposition: attachment; filename="cancel.patch"

LS0tIGxpbnV4LTIuNi4xMi9mcy9haW8uYwkyMDA1LTA2LTE3IDE1OjQ4OjI5
LjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgvZnMvYWlvLmMJMjAwNS0wNy0x
MCAxMjo0ODoxNC4wMDAwMDAwMDAgLTA0MDAKQEAgLTE2NDEsOCArMTY0MSw5
IEBAIGFzbWxpbmthZ2UgbG9uZyBzeXNfaW9fY2FuY2VsKGFpb19jb250ZXgK
IAkJY2FuY2VsID0ga2lvY2ItPmtpX2NhbmNlbDsKIAkJa2lvY2ItPmtpX3Vz
ZXJzICsrOwogCQlraW9jYlNldENhbmNlbGxlZChraW9jYik7Ci0JfSBlbHNl
CisJfSBlbHNlIAogCQljYW5jZWwgPSBOVUxMOworCSAKIAlzcGluX3VubG9j
a19pcnEoJmN0eC0+Y3R4X2xvY2spOwogCiAJaWYgKE5VTEwgIT0gY2FuY2Vs
KSB7CkBAIC0xNjU5LDggKzE2NjAsMTAgQEAgYXNtbGlua2FnZSBsb25nIHN5
c19pb19jYW5jZWwoYWlvX2NvbnRleAogCQkJaWYgKGNvcHlfdG9fdXNlcihy
ZXN1bHQsICZ0bXAsIHNpemVvZih0bXApKSkKIAkJCQlyZXQgPSAtRUZBVUxU
OwogCQl9Ci0JfSBlbHNlCisJfSBlbHNlIHsKKwkJcmV0ID0gLUVOT1NZUzsK
IAkJcHJpbnRrKEtFUk5fREVCVUcgImlvY2IgaGFzIG5vIGNhbmNlbCBvcGVy
YXRpb25cbiIpOworCX0gCiAKIAlwdXRfaW9jdHgoY3R4KTsKIAo=

--0-1907975829-1121019948=:37290--
