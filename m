Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288245AbSATLZO>; Sun, 20 Jan 2002 06:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288283AbSATLY6>; Sun, 20 Jan 2002 06:24:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47024 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288245AbSATLYi>;
	Sun, 20 Jan 2002 06:24:38 -0500
Date: Sun, 20 Jan 2002 14:22:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [sched] [patch] uninline-wakeup-2.5.3-pre2-A0
Message-ID: <Pine.LNX.4.33.0201201419410.7972-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-797276765-1011532924=:7972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-797276765-1011532924=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch removes the inlining of wake_up_process within
kernel/sched.c - the only user is sched_init() which clearly does not need
the inlining. This saves a few bytes.

	Ingo

--8323328-797276765-1011532924=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="uninline-wakeup-2.5.3-pre2-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201201422040.7972@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="uninline-wakeup-2.5.3-pre2-A0"

LS0tIGxpbnV4L2tlcm5lbC9zY2hlZC5jLm9yaWcJU3VuIEphbiAyMCAxMToz
NzoyMSAyMDAyDQorKysgbGludXgva2VybmVsL3NjaGVkLmMJU3VuIEphbiAy
MCAxMTozODozOCAyMDAyDQpAQCAtMjMyLDcgKzIzMiw3IEBADQogCXJldHVy
biBzdWNjZXNzOw0KIH0NCiANCi1pbmxpbmUgaW50IHdha2VfdXBfcHJvY2Vz
cyh0YXNrX3QgKiBwKQ0KK2ludCB3YWtlX3VwX3Byb2Nlc3ModGFza190ICog
cCkNCiB7DQogCXJldHVybiB0cnlfdG9fd2FrZV91cChwLCAwKTsNCiB9DQo=
--8323328-797276765-1011532924=:7972--
