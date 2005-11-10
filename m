Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVKJVpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVKJVpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVKJVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:45:24 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:16257 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932172AbVKJVpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:45:23 -0500
Message-ID: <4373BF82.40003@free.fr>
Date: Thu, 10 Nov 2005 22:45:38 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix leakes in request_firmware_nowait
Content-Type: multipart/mixed;
 boundary="------------030204050608060507050104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030204050608060507050104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


request_firmware_nowait wasn't checking return error and forgot to free 
memory in some case.

This patch should fix it.

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------030204050608060507050104
Content-Type: text/plain;
 name="firmware_nowait_leak"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="firmware_nowait_leak"

SW5kZXg6IGxpbnV4LTIuNi4xNC9kcml2ZXJzL2Jhc2UvZmlybXdhcmVfY2xhc3MuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMTQub3JpZy9kcml2ZXJzL2Jhc2UvZmlybXdhcmVf
Y2xhc3MuYwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgt
Mi42LjE0L2RyaXZlcnMvYmFzZS9maXJtd2FyZV9jbGFzcy5jCTIwMDUtMTEtMTAgMjI6NDI6
NTYuMDAwMDAwMDAwICswMTAwCkBAIC01MTEsMTMgKzUxMSwxOCBAQAogewogCXN0cnVjdCBm
aXJtd2FyZV93b3JrICpmd193b3JrID0gYXJnOwogCWNvbnN0IHN0cnVjdCBmaXJtd2FyZSAq
Znc7CisJaW50IHJldDsKIAlpZiAoIWFyZykgewogCQlXQVJOX09OKDEpOwogCQlyZXR1cm4g
MDsKIAl9CiAJZGFlbW9uaXplKCIlcy8lcyIsICJmaXJtd2FyZSIsIGZ3X3dvcmstPm5hbWUp
OwotCV9yZXF1ZXN0X2Zpcm13YXJlKCZmdywgZndfd29yay0+bmFtZSwgZndfd29yay0+ZGV2
aWNlLAorCXJldCA9IF9yZXF1ZXN0X2Zpcm13YXJlKCZmdywgZndfd29yay0+bmFtZSwgZndf
d29yay0+ZGV2aWNlLAogCQlmd193b3JrLT5ob3RwbHVnKTsKKwlpZiAocmV0IDwgMCkgewor
CQlmd193b3JrLT5jb250KE5VTEwsIGZ3X3dvcmstPmNvbnRleHQpOworCQlyZXR1cm4gcmV0
OworCX0KIAlmd193b3JrLT5jb250KGZ3LCBmd193b3JrLT5jb250ZXh0KTsKIAlyZWxlYXNl
X2Zpcm13YXJlKGZ3KTsKIAltb2R1bGVfcHV0KGZ3X3dvcmstPm1vZHVsZSk7CkBAIC01NzMs
NiArNTc4LDggQEAKIAogCWlmIChyZXQgPCAwKSB7CiAJCWZ3X3dvcmstPmNvbnQoTlVMTCwg
Zndfd29yay0+Y29udGV4dCk7CisJCW1vZHVsZV9wdXQoZndfd29yay0+bW9kdWxlKTsKKwkJ
a2ZyZWUoZndfd29yayk7CiAJCXJldHVybiByZXQ7CiAJfQogCXJldHVybiAwOwo=
--------------030204050608060507050104--
