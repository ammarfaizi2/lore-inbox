Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbTBQPSS>; Mon, 17 Feb 2003 10:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTBQPSR>; Mon, 17 Feb 2003 10:18:17 -0500
Received: from [81.2.122.30] ([81.2.122.30]:56069 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267129AbTBQPSQ>;
	Mon, 17 Feb 2003 10:18:16 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302171529.h1HFTVPk010325@darkstar.example.net>
Subject: Re: Performance of ext3 on large systems
To: sneakums@zork.net (Sean Neakums)
Date: Mon, 17 Feb 2003 15:29:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6uisvj9bno.fsf@zork.zork.net> from "Sean Neakums" at Feb 17, 2003 03:20:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Can we just say that ext3's talents lie elsewhere?
> >
> > I've got some stuff which helps a bit, but nobody has had the time
> > to implement the significant overhaul which is needed here.
> >
> > noatime would help.
> 
> ext3 doesn't implement noatime!?  Hurg...

Actually, it makes sense in a way - noatime only speeds up reads, not
writes, (access time is always updated on a write), whereas a
journaled filesystem is presumably intended to be tuned for write
performance.  So, for it's intended usage, not implementing noatime
shouldn't be a huge problem, although it would be useful.

John.
