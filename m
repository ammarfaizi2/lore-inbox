Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271326AbRH3FU1>; Thu, 30 Aug 2001 01:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271318AbRH3FUQ>; Thu, 30 Aug 2001 01:20:16 -0400
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:29703 "EHLO mail1.mn.rr.com")
	by vger.kernel.org with ESMTP id <S271326AbRH3FUA>;
	Thu, 30 Aug 2001 01:20:00 -0400
From: "Elan Feingold" <efeingold@mn.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Multithreaded core dumps
Date: Thu, 30 Aug 2001 00:21:06 -0500
Message-ID: <000c01c13113$91d7c060$0400000a@gorilla>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First post (although lurking on and off since 0.99pl14 or so), so please
be gentle.

We recently convinced my company to move from VxWorks to (embedded)
Linux.  For better or worse, our application is heavily multithreaded.
It seems that current versions of Linux dump single-threaded core.  I've
done a bit of research and it seems that:

- GDB is more than happy to load multiple register sets per core file.

- There are patches to the kernel dump multiple core files, one per LWP.
This is not really helpful in my case, since we're on an embedded
platform with little Flash to store cores.  Besides, loading up gdb on
10-20 core files looking for the one that had the problem doesn't sound
very fun, as opposed to saying "info threads".

Because I am (not so) young and (very) foolish, it doesn't sound that
hard, at first (and uneducated) glance, to dump register sets for all
related LWPs to a single core file, even in a portable way across x86
and PPC architectures.  Under SMP, it might be a bit trickier, but
Solaris manages to do it, so it can't be impossible, and capturing any
state for each thread would seem better than nothing at all, since all
the LWPs are about to die anyways.  I'm considering using some of my
(copious) spare time and trying to patch the kernel to do this.  I have
a few questions:

0. Am I wrong or confused about the state of postmortem multithreaded
debugging under Linux?

1. Is anyone else working on this?  If not, why not?  Am I missing
something?

2. If this is simply something that nobody is working on because other
things are more interesting, can anybody give me a few pointers on where
to start?

Best regards,

-elan
Aspiring Kernel Hacker

