Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTBQQ7W>; Mon, 17 Feb 2003 11:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTBQQ7W>; Mon, 17 Feb 2003 11:59:22 -0500
Received: from mail2.fbab.net ([195.54.134.228]:13785 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id <S267267AbTBQQ7U>;
	Mon, 17 Feb 2003 11:59:20 -0500
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail2.fbab.net
X-Qmail-Scanner: 1.10 (Clear:0. Processed in 0.263194 secs)
Message-ID: <14f601c2d6a7$4c0f5170$f80c0a0a@mnd>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Manfred Spraul" <manfred@colorfullife.com>,
       "Anton Blanchard" <anton@samba.org>, "Andrew Morton" <akpm@digeo.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Zwane Mwaikambo" <zwane@holomorphy.com>
References: <Pine.LNX.4.44.0302161951580.1424-100000@home.transmeta.com>
Subject: Re: more signal locking bugs?
Date: Mon, 17 Feb 2003 18:09:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> Doh.
> 
> This should fix it.

[snip]

> + spin_lock_irq(&task->sighand->siglock);
> + collect_sigign_sigcatch(task, &sigign, &sigcatch);
> + spin_lock_irq(&task->sighand->siglock);

[snip]

You take the lock twice here?

Magnus
