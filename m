Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVDMSgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDMSgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVDMSgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:36:37 -0400
Received: from mail.aknet.ru ([217.67.122.194]:8455 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261185AbVDMSgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:36:22 -0400
Message-ID: <425D66B0.7030601@aknet.ru>
Date: Wed, 13 Apr 2005 22:36:32 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm3
Content-Type: multipart/mixed;
 boundary="------------010607050905010808060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607050905010808060308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ingo.

I have some programs that crash
in 2.6.12-rc2-mm3. After seeing this:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0504.1/1091.html
I tried to revert the
sched-unlocked-context-switches.patch
and indeed the problem goes away.
Attached is the (crappy) test-case.
If you can make it to say "All OK"
then the problem is solved.
Apparently the %fs gets trashed
somewhere, any ideas?


--------------010607050905010808060308
Content-Type: text/plain;
 name="fs.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fs.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxsaW51eC91bmlzdGQuaD4KI2lu
Y2x1ZGUgPGFzbS9sZHQuaD4KI2luY2x1ZGUgPGFzbS91Y29udGV4dC5oPgoKX3N5c2NhbGwz
KGludCwgbW9kaWZ5X2xkdCwgaW50LCBmdW5jLCB2b2lkICosIHB0ciwgdW5zaWduZWQgbG9u
ZywgYnl0ZWNvdW50KQoKc3RhdGljIGludCBzZXRfbGR0X2VudHJ5KGludCBlbnRyeSwgdW5z
aWduZWQgbG9uZyBiYXNlLCB1bnNpZ25lZCBpbnQgbGltaXQsCgkgICAgICBpbnQgc2VnXzMy
Yml0X2ZsYWcsIGludCBjb250ZW50cywgaW50IHJlYWRfb25seV9mbGFnLAoJICAgICAgaW50
IGxpbWl0X2luX3BhZ2VzX2ZsYWcsIGludCBzZWdfbm90X3ByZXNlbnQsIGludCB1c2VhYmxl
KQp7CiAgc3RydWN0IG1vZGlmeV9sZHRfbGR0X3MgbGR0X2luZm87CiAgbGR0X2luZm8uZW50
cnlfbnVtYmVyID0gZW50cnk7CiAgbGR0X2luZm8uYmFzZV9hZGRyID0gYmFzZTsKICBsZHRf
aW5mby5saW1pdCA9IGxpbWl0OwogIGxkdF9pbmZvLnNlZ18zMmJpdCA9IHNlZ18zMmJpdF9m
bGFnOwogIGxkdF9pbmZvLmNvbnRlbnRzID0gY29udGVudHM7CiAgbGR0X2luZm8ucmVhZF9l
eGVjX29ubHkgPSByZWFkX29ubHlfZmxhZzsKICBsZHRfaW5mby5saW1pdF9pbl9wYWdlcyA9
IGxpbWl0X2luX3BhZ2VzX2ZsYWc7CiAgbGR0X2luZm8uc2VnX25vdF9wcmVzZW50ID0gc2Vn
X25vdF9wcmVzZW50OwogIGxkdF9pbmZvLnVzZWFibGUgPSB1c2VhYmxlOwoKICByZXR1cm4g
bW9kaWZ5X2xkdCgxLCAmbGR0X2luZm8sIHNpemVvZihsZHRfaW5mbykpOwp9CgppbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CiAgdW5zaWduZWQgc2hvcnQgX3NzLCBuZXdf
c3MsIGZzOwoKICAvKiBHZXQgU1MgKi8KICBhc20gdm9sYXRpbGUoCiAgICAibW92dyAlJXNz
LCAlMFxuIgogICAgOiI9bSIoX3NzKQogICk7CgogIC8qIEZvcmNlIHRvIExEVCAqLwogIG5l
d19zcyA9IChfc3MgJiAweGZmZmYpIHwgNDsKICAvKiBDcmVhdGUgdGhlIExEVCBlbnRyeSAq
LwogIHNldF9sZHRfZW50cnkobmV3X3NzID4+IDMsIDAsIDB4ZmZmZmYsIDAsIE1PRElGWV9M
RFRfQ09OVEVOVFNfREFUQSwgMCwgMSwgMCwgMCk7CgogIGFzbSAoIm1vdncgJSVmcywgJTAi
OiI9bSIoZnMpKTsKICBwcmludGYoImZzMT0weCVoeFxuIiwgZnMpOwogIGFzbSAoIm1vdncg
JTAsICUlZnMiOjoiYSIobmV3X3NzKSk7CiAgYXNtICgibW92dyAlJWZzLCAlMCI6Ij1tIihm
cykpOwogIHByaW50ZigiZnMyPTB4JWh4XG4iLCBmcyk7CiAgdXNsZWVwKDApOwogIGFzbSAo
Im1vdncgJSVmcywgJTAiOiI9bSIoZnMpKTsKICBwcmludGYoImZzMz0weCVoeFxuIiwgZnMp
OwogIGlmIChmcyAhPSBuZXdfc3MpCiAgICBwcmludGYoIkJVRyFcbiIpOwogIGVsc2UKICAg
IHByaW50ZigiQWxsIE9LXG4iKTsKICByZXR1cm4gMDsKfQo=
--------------010607050905010808060308--
