Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTF2UvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTF2UvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:51:15 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:60676 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264619AbTF2Uuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:50:46 -0400
Date: Sun, 29 Jun 2003 17:04:55 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: linux-kernel@vger.kernel.org, akpm@digeo.com, Pavel Machek <pavel@suse.cz>
cc: ldl@aros.net
Subject: Re: [PATCH 2.5.73] nbd: maintain compatibility with existing nbd
 tools
In-Reply-To: <20030629184253.GE267@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10306291624250.764-200000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="296485894-1974830749-1056920695=:764"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--296485894-1974830749-1056920695=:764
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 29 Jun 2003, Pavel Machek wrote:

> > > [ ... ] In the meantime, the nbd-client tool currently can't correctly set 
> > > the size of the device and either that needs to be worked around in the 
> > > driver (I'd done that in the original jumbo patch), or the nbd-client 
> > > tool needs to be updated (the patch I'd mailed out for nbd-client works 
> > > around the sizing issue by re-opening the nbd). To be clear, that's not 
> > > something any of the changes that have gone in so far broke nor address. 
> > > It's a consequence of how bd_set_size() is called in fs/block_dev.c 
> > > do_open().
> > 
> > And here's the (tiny) patch for nbd to maintain compatibility with the
> > existing nbd-client tool. Compiled and tested on a couple machines.
> > Please apply.
> 
> You are the maintainer, you can go to the linus directly. (I hope
> Linus took that MAINTAINERS patch).

Not yet, I don't think...

> [Aha, if you wanted *Andrew* to apply it... I guess it is better to
> say directly who do you want to take it.]

Well, it's just that Andrew seems particularly willing to help on this,
so that's why I sent to him...

At any rate, Andrew, here's a cleaned up version of the patch... please apply.

Thanks,
Paul

--296485894-1974830749-1056920695=:764
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nbd_2_5_compat.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10306291704550.764@clements.sc.steeleye.com>
Content-Description: 
Content-Disposition: attachment; filename="nbd_2_5_compat.diff"

LS0tIGxpbnV4LTIuNS9kcml2ZXJzL2Jsb2NrL25iZC5jLlBSSVNUSU5FCVNh
dCBKdW4gMjggMTI6NTc6MDMgMjAwMw0KKysrIGxpbnV4LTIuNS9kcml2ZXJz
L2Jsb2NrL25iZC5jCVNhdCBKdW4gMjggMTI6NTc6NTQgMjAwMw0KQEAgLTUw
MywxNSArNTAzLDE4IEBADQogCQkJbG8tPmJsa3NpemVfYml0cysrOw0KIAkJ
CXRlbXAgPj49IDE7DQogCQl9DQotCQlsby0+Ynl0ZXNpemUgJj0gfihsby0+
Ymxrc2l6ZS0xKTsgDQorCQlsby0+Ynl0ZXNpemUgJj0gfihsby0+Ymxrc2l6
ZS0xKTsNCisJCWlub2RlLT5pX2JkZXYtPmJkX2lub2RlLT5pX3NpemUgPSBs
by0+Ynl0ZXNpemU7DQogCQlzZXRfY2FwYWNpdHkobG8tPmRpc2ssIGxvLT5i
eXRlc2l6ZSA+PiA5KTsNCiAJCXJldHVybiAwOw0KIAljYXNlIE5CRF9TRVRf
U0laRToNCi0JCWxvLT5ieXRlc2l6ZSA9IGFyZyAmIH4obG8tPmJsa3NpemUt
MSk7IA0KKwkJbG8tPmJ5dGVzaXplID0gYXJnICYgfihsby0+Ymxrc2l6ZS0x
KTsNCisJCWlub2RlLT5pX2JkZXYtPmJkX2lub2RlLT5pX3NpemUgPSBsby0+
Ynl0ZXNpemU7DQogCQlzZXRfY2FwYWNpdHkobG8tPmRpc2ssIGxvLT5ieXRl
c2l6ZSA+PiA5KTsNCiAJCXJldHVybiAwOw0KIAljYXNlIE5CRF9TRVRfU0la
RV9CTE9DS1M6DQogCQlsby0+Ynl0ZXNpemUgPSAoKHU2NCkgYXJnKSA8PCBs
by0+Ymxrc2l6ZV9iaXRzOw0KKwkJaW5vZGUtPmlfYmRldi0+YmRfaW5vZGUt
Pmlfc2l6ZSA9IGxvLT5ieXRlc2l6ZTsNCiAJCXNldF9jYXBhY2l0eShsby0+
ZGlzaywgbG8tPmJ5dGVzaXplID4+IDkpOw0KIAkJcmV0dXJuIDA7DQogCWNh
c2UgTkJEX0RPX0lUOg0K
--296485894-1974830749-1056920695=:764--
