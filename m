Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbQKLW2Y>; Sun, 12 Nov 2000 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131377AbQKLW2O>; Sun, 12 Nov 2000 17:28:14 -0500
Received: from shell.webmaster.com ([209.133.28.73]:39678 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S131221AbQKLW14>; Sun, 12 Nov 2000 17:27:56 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "David Wragg" <dpw@doc.ic.ac.uk>, <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: What protects f_pos?
Date: Sun, 12 Nov 2000 14:27:54 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKKENGLNAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <y7raeb69cmg.fsf@sytry.doc.ic.ac.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> tytso@mit.edu writes:
> > This looks like it's a bug to me....  although if you have multiple
> > threads hitting a file descriptor at the same time, you're pretty much
> > asking for trouble.
>
> Yes, I haven't been able to come up with an example that might trigger
> this that wasn't dubious to begin with.  I'll raise this again at a
> convenient time during 2.5.
>
> David

	Suppose you had a multithreaded program that used a configuration file with
a group of fixed-length blocks indicating what work it had to do. Each
thread read a block from the file and then did the work. One might think
that there's no need to protect the file descriptor with a mutex.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
