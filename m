Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTF1RGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 13:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbTF1RGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 13:06:43 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:53252 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265297AbTF1RGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 13:06:40 -0400
Date: Sat, 28 Jun 2003 13:20:55 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>, ldl@aros.net
Subject: [PATCH] nbd: maintain compatibility with existing nbd tools
In-Reply-To: <3EFA1F7E.2080602@aros.net>
Message-ID: <Pine.LNX.4.10.10306281315240.764-200000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="296485894-1381922393-1056820855=:764"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--296485894-1381922393-1056820855=:764
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 25 Jun 2003, Lou Langholtz wrote:

> [ ... ] In the meantime, the nbd-client tool currently can't correctly set 
> the size of the device and either that needs to be worked around in the 
> driver (I'd done that in the original jumbo patch), or the nbd-client 
> tool needs to be updated (the patch I'd mailed out for nbd-client works 
> around the sizing issue by re-opening the nbd). To be clear, that's not 
> something any of the changes that have gone in so far broke nor address. 
> It's a consequence of how bd_set_size() is called in fs/block_dev.c 
> do_open().

And here's the (tiny) patch for nbd to maintain compatibility with the
existing nbd-client tool. Compiled and tested on a couple machines.
Please apply.

Thanks,
Paul

--296485894-1381922393-1056820855=:764
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nbd_2_5_compat.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10306281320550.764@clements.sc.steeleye.com>
Content-Description: nbd patch
Content-Disposition: attachment; filename="nbd_2_5_compat.diff"

LS0tIG5iZC5jLk9SSUcJMjAwMy0wNi0yNiAxMDozNTo0My4wMDAwMDAwMDAg
LTA0MDANCisrKyBuYmQuYwkyMDAzLTA2LTI2IDE3OjAzOjA4LjAwMDAwMDAw
MCAtMDQwMA0KQEAgLTQ2NSwxNSArNDY4LDE4IEBADQogCQkJbG8tPmJsa3Np
emVfYml0cysrOw0KIAkJCXRlbXAgPj49IDE7DQogCQl9DQotCQlsby0+Ynl0
ZXNpemUgJj0gfihsby0+Ymxrc2l6ZS0xKTsgDQorCQlsby0+Ynl0ZXNpemUg
Jj0gfihsby0+Ymxrc2l6ZS0xKTsNCisJCWlub2RlLT5pX2JkZXYtPmJkX2lu
b2RlLT5pX3NpemUgPSBsby0+Ynl0ZXNpemU7DQogCQlzZXRfY2FwYWNpdHko
bG8tPmRpc2ssIGxvLT5ieXRlc2l6ZSA+PiA5KTsNCiAJCXJldHVybiAwOw0K
IAljYXNlIE5CRF9TRVRfU0laRToNCi0JCWxvLT5ieXRlc2l6ZSA9IGFyZyAm
IH4obG8tPmJsa3NpemUtMSk7IA0KKwkJbG8tPmJ5dGVzaXplID0gYXJnICYg
fihsby0+Ymxrc2l6ZS0xKTsNCisJCWlub2RlLT5pX2JkZXYtPmJkX2lub2Rl
LT5pX3NpemUgPSBsby0+Ynl0ZXNpemU7DQogCQlzZXRfY2FwYWNpdHkobG8t
PmRpc2ssIGxvLT5ieXRlc2l6ZSA+PiA5KTsNCiAJCXJldHVybiAwOw0KIAlj
YXNlIE5CRF9TRVRfU0laRV9CTE9DS1M6DQogCQlsby0+Ynl0ZXNpemUgPSAo
KHU2NCkgYXJnKSA8PCBsby0+Ymxrc2l6ZV9iaXRzOw0KKwkJaW5vZGUtPmlf
YmRldi0+YmRfaW5vZGUtPmlfc2l6ZSA9IGxvLT5ieXRlc2l6ZTsNCiAJCXNl
dF9jYXBhY2l0eShsby0+ZGlzaywgbG8tPmJ5dGVzaXplID4+IDkpOw0KIAkJ
cmV0dXJuIDA7DQogCWNhc2UgTkJEX0RPX0lUOg0K
--296485894-1381922393-1056820855=:764--
