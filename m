Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbUL3DJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbUL3DJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 22:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUL3DJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 22:09:48 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:53509 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261529AbUL3DJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 22:09:39 -0500
Message-ID: <41D37252.8020201@conectiva.com.br>
Date: Thu, 30 Dec 2004 01:13:22 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?UmFtw7NuIFJleSBWaWNlbnRl?= <rrey@usuarios.retecal.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6-bk]  net/core/sock.o build failed
References: <41D34E4D.7020802@usuarios.retecal.es>
In-Reply-To: <41D34E4D.7020802@usuarios.retecal.es>
Content-Type: multipart/mixed;
 boundary="------------070209050301080205050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070209050301080205050609
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Ram=C3=B3n Rey Vicente wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> CC      net/core/sock.o
> In file included from include/net/ipv6.h:18,
> ~                 from include/net/xfrm.h:16,
> ~                 from net/core/sock.c:121:
> include/linux/ipv6.h: In function `inet6_sk':
> include/linux/ipv6.h:278: error: structure has no member named `pinet6'
> make[2]: *** [net/core/sock.o] Error 1
> make[1]: *** [net/core] Error 2
> make: *** [net] Error

Use the attached patch, this was already sent to David Miller, as I menti=
oned
in another message, this only happens when you don't select IPV6.

Regards,

- Arnaldo

--------------070209050301080205050609
Content-Type: text/plain;
 name="inet6_sk.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="inet6_sk.patch"

PT09PT0gaW5jbHVkZS9saW51eC9pcHY2LmggMS4yMyB2cyBlZGl0ZWQgPT09PT0KLS0tIDEu
MjMvaW5jbHVkZS9saW51eC9pcHY2LmgJMjAwNC0xMi0yNyAyMzo1NjozMyAtMDI6MDAKKysr
IGVkaXRlZC9pbmNsdWRlL2xpbnV4L2lwdjYuaAkyMDA0LTEyLTI5IDIwOjIyOjQ1IC0wMjow
MApAQCAtMjczLDYgKzI3Myw3IEBACiAJc3RydWN0IGlwdjZfcGluZm8gaW5ldDY7CiB9Owog
CisjaWYgZGVmaW5lZChDT05GSUdfSVBWNikgfHwgZGVmaW5lZChDT05GSUdfSVBWNl9NT0RV
TEUpCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBpcHY2X3BpbmZvICogaW5ldDZfc2soY29uc3Qg
c3RydWN0IHNvY2sgKl9fc2spCiB7CiAJcmV0dXJuIGluZXRfc2soX19zayktPnBpbmV0NjsK
QEAgLTI4Myw3ICsyODQsNiBAQAogCXJldHVybiAmKChzdHJ1Y3QgcmF3Nl9zb2NrICopX19z
ayktPnJhdzY7CiB9CiAKLSNpZiBkZWZpbmVkKENPTkZJR19JUFY2KSB8fCBkZWZpbmVkKENP
TkZJR19JUFY2X01PRFVMRSkKICNkZWZpbmUgX19pcHY2X29ubHlfc29jayhzaykJKGluZXQ2
X3NrKHNrKS0+aXB2Nm9ubHkpCiAjZGVmaW5lIGlwdjZfb25seV9zb2NrKHNrKQkoKHNrKS0+
c2tfZmFtaWx5ID09IFBGX0lORVQ2ICYmIF9faXB2Nl9vbmx5X3NvY2soc2spKQogI2Vsc2UK

--------------070209050301080205050609--
