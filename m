Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVE3IiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVE3IiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVE3IiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:38:05 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:29637 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S261564AbVE3Ihy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:37:54 -0400
Date: Mon, 30 May 2005 10:29:26 +0200 (CEST)
From: Patrick Boettcher <pb@linuxtv.org>
X-X-Sender: pboettch@pub6.ifh.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Johannes Stezenbach <js@linuxtv.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1: drivers/media/dvb/dvb-usb/a800.c compile error
In-Reply-To: <20050529144548.GC10441@stusta.de>
Message-ID: <Pine.LNX.4.61.0505301024120.11869@pub6.ifh.de>
References: <20050525134933.5c22234a.akpm@osdl.org> <20050529144548.GC10441@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="579696143-1284282855-1117441766=:11869"
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--579696143-1284282855-1117441766=:11869
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,

On Sun, 29 May 2005, Adrian Bunk wrote:
> It seems this patch is responsible for the following compile error with
> gcc 2.95:
> <--  snip  -->
>
> ...
>  CC      drivers/media/dvb/dvb-usb/a800.o
> In file included from drivers/media/dvb/dvb-usb/dibusb.h:15,
>                 from drivers/media/dvb/dvb-usb/a800.c:16:
> drivers/media/dvb/dvb-usb/dvb-usb.h:196: field `devices' has incomplete type
> ...
> make[4]: *** [drivers/media/dvb/dvb-usb/a800.o] Error 1
>
> <--  snip -->

The attached patch solves the problem by adding a '0' to the array 
declaration. I don't know if this is ethically correct, but I saw it in 
some v4l-code, so I assume it is.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>


Thanks for reporting,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
--579696143-1284282855-1117441766=:11869
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dvb-usb-incomplete-type-gcc-2.95-2.6.12-rc5-mm1.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="dvb-usb-incomplete-type-gcc-2.95-2.6.12-rc5-mm1.patch"

SW5kZXg6IGxpbnV4L2RyaXZlcnMvbWVkaWEvZHZiL2R2Yi11c2IvZHZiLXVz
Yi5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9s
aW51eHR2L2R2Yi1rZXJuZWwvbGludXgvZHJpdmVycy9tZWRpYS9kdmIvZHZi
LXVzYi9kdmItdXNiLmgsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE2DQpk
aWZmIC11IC1yMS4xNiBkdmItdXNiLmgNCi0tLSBsaW51eC9kcml2ZXJzL21l
ZGlhL2R2Yi9kdmItdXNiL2R2Yi11c2IuaAkyIE1heSAyMDA1IDEyOjQ4OjAx
IC0wMDAwCTEuMTYNCisrKyBsaW51eC9kcml2ZXJzL21lZGlhL2R2Yi9kdmIt
dXNiL2R2Yi11c2IuaAkzMCBNYXkgMjAwNSAwODoyNDo1NSAtMDAwMA0KQEAg
LTE5Myw3ICsxOTMsNyBAQA0KIAl9IHVyYjsNCiANCiAJaW50IG51bV9kZXZp
Y2VfZGVzY3M7DQotCXN0cnVjdCBkdmJfdXNiX2RldmljZV9kZXNjcmlwdGlv
biBkZXZpY2VzW107DQorCXN0cnVjdCBkdmJfdXNiX2RldmljZV9kZXNjcmlw
dGlvbiBkZXZpY2VzWzBdOw0KIH07DQogDQogDQo=

--579696143-1284282855-1117441766=:11869--
