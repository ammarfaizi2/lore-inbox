Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSHRVj0>; Sun, 18 Aug 2002 17:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSHRVjZ>; Sun, 18 Aug 2002 17:39:25 -0400
Received: from mail2.fbab.net ([195.54.134.228]:18101 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id <S316258AbSHRVjZ>;
	Sun, 18 Aug 2002 17:39:25 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail2.fbab.net
X-Qmail-Scanner: 1.10 (Clear:0. Processed in 0.263213 secs)
Message-ID: <1678.212.151.58.193.1029707005.squirrel@mail2.fbab.net>
Date: Sun, 18 Aug 2002 23:43:25 +0200 (CEST)
Subject: linux-2.4.19-pre6aa1 sendfile problem
From: "Magnus Naeslund(w)" <mag@fbab.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: mag@fbab.net
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short story:

sendfile() seems to (sometimes) exit my app using linux-2.4.19-pre6aa1 on
alpha (EV56).

Short questions:

Do you know of any trouble that could cause this, like is this a known
bug in kernel X.Y.Z ?

Long story:

I have a server process that's started in a inetd kind of way.
It uses sendfile for sending entire small files (~230-250kb a pice).
Recently i added some accounting using shared memory.
It failed miserably because it didn't always exit via the cleanup
functions (i use atexit() and signal() to trap that exit).I hunted for bugs in my code for some hours, then i noticed that when i
logged "before sendfile" and "after sendfile" sometimes only the"before" thing showed up.

So to help this i'll probably do a wrapper for sendfile using std write(),
but i sure want to use sendfile if i can.

Does anyone have any ideas about this?

Regards

Magnus Naeslund

no .sig



