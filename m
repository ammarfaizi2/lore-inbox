Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275387AbRIZRrb>; Wed, 26 Sep 2001 13:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275383AbRIZRrW>; Wed, 26 Sep 2001 13:47:22 -0400
Received: from chiara.elte.hu ([157.181.150.200]:9996 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275381AbRIZRrF>;
	Wed, 26 Sep 2001 13:47:05 -0400
Date: Wed, 26 Sep 2001 19:45:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] pagecache SMP locking bug, 2.4.10.
Message-ID: <Pine.LNX.4.33.0109261933360.6884-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-193400649-1001526309=:6884"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-193400649-1001526309=:6884
Content-Type: TEXT/PLAIN; charset=US-ASCII


there is a SMP locking bug in 2.4.10's invalidate_list_pages2() that can
lead to a double spinlock acquire & result in a soft lockup. Patch
attached.

	Ingo

--8323328-193400649-1001526309=:6884
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pagecachefix-2.4.10-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109261945090.6884@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="pagecachefix-2.4.10-A0"

LS0tIGxpbnV4L21tL2ZpbGVtYXAuYy5vcmlnCVdlZCBTZXAgMjYgMTk6MTc6
MzMgMjAwMQ0KKysrIGxpbnV4L21tL2ZpbGVtYXAuYwlXZWQgU2VwIDI2IDE5
OjE4OjI1IDIwMDENCkBAIC0zNjQsNiArMzY0LDcgQEANCiAJCQkJY3VyciA9
IGN1cnItPnByZXY7DQogCQkJCWNvbnRpbnVlOw0KIAkJCX0NCisJCQlzcGlu
X3VubG9jaygmcGFnZWNhY2hlX2xvY2spOw0KIAkJfSBlbHNlIHsNCiAJCQkv
KiBSZXN0YXJ0IG9uIHRoaXMgcGFnZSAqLw0KIAkJCWxpc3RfZGVsKGhlYWQp
Ow0K
--8323328-193400649-1001526309=:6884--
