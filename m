Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289307AbSA2OBk>; Tue, 29 Jan 2002 09:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSA2OBb>; Tue, 29 Jan 2002 09:01:31 -0500
Received: from [193.105.113.102] ([193.105.113.102]:46044 "EHLO
	mailrennes.rennes.si.fr.atosorigin.com") by vger.kernel.org
	with ESMTP id <S289307AbSA2OBW>; Tue, 29 Jan 2002 09:01:22 -0500
Message-ID: <02c801c1a8cd$027ccd20$8a140237@rennes.si.fr.atosorigin.com>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
In-Reply-To: <008f01c1a815$d8cdcc70$8a140237@rennes.si.fr.atosorigin.com> <20020129114222.B2298@redhat.com>
Subject: Re: Assertion failure / do_get_write_acess() / loop / samba
Date: Tue, 29 Jan 2002 14:58:20 +0100
Organization: ENIB - Promo `98
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 13:58:20.0685 (UTC) FILETIME=[0280EBD0:01C1A8CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen! Hi lists!

> > Assertion failure in do_get_write_access() at transaction.c:728:
> > "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
>
> Are there any other log messages in the kernel log?

No. This is the only one. Even when I enter 'reboot' and hit enter, it
just freezes without any message. For quite a while (more than 5').
Nothing more appears, niether on screen nor on my serial console.

> The only easy way I can see for this to be triggered is if there is a
> bad block on disk being accessed.  That ought to appear in the log.

That I tested. No bad block on the remote host (assertion happens
only when writing to a loop residing on a samba share, on a Win2k
host).

> Could you also please run ksymoops to decode the log trace?

Unfortunately no, I haven't got enough place on the machine to test
more than two kernel at a time. Now is time for the 2.4.18-pre7 with
the ext3 debug patch. But this one will get ksymoops run against.

Regards,
Yann.

PS. Because I'm  often away from work in these days, and because my
test machine is a plain old Pentium Pro, I can't do tests as often as
I might want to... Please forgive slowliness...
YEM.

PPS. I'm not subscribed to ext2-devel, please copy me (or lkml).
YEM.

--
.---------------------------.----------------------.------------------.
|       Yann E. MORIN       |  Real-Time Embedded  | ASCII RIBBON /"\ |
| Phone: (33/0) 662 376 056 |  Software  Designer  |   CAMPAIGN   \ / |
|   http://ymorin.free.fr   °----------------------:   AGAINST     X  |
| yann.morin.1998@anciens.enib.fr                  |  HTML MAIL   / \ |
°--------------------------------------------------°------------------°



