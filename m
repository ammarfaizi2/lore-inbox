Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbTCYAps>; Mon, 24 Mar 2003 19:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbTCYAps>; Mon, 24 Mar 2003 19:45:48 -0500
Received: from [209.104.139.7] ([209.104.139.7]:25022 "EHLO
	mail.baldwinlib.org") by vger.kernel.org with ESMTP
	id <S261305AbTCYApr>; Mon, 24 Mar 2003 19:45:47 -0500
Message-ID: <4818.68.40.176.184.1048553816.squirrel@mail.baldwinmail.org>
Date: Mon, 24 Mar 2003 19:56:56 -0500 (EST)
Subject: Re: 2.5.65: *huge* interactivity problems
From: "George Glover" <zed@baldwinmail.org>
To: <akpm@digeo.com>
In-Reply-To: <20030324171936.680f98e2.akpm@digeo.com>
References: <20030323231306.GA4704@elf.ucw.cz>
        <20030324171936.680f98e2.akpm@digeo.com>
X-Priority: 3
Importance: Normal
Cc: <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>
Reply-To: zed@baldwinmail.org
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have a similar problem, when running setiathome with priority 1.

All _running_ applications remain interactive, anything requring disk
access, in particular starting a new program, causes things to block.

I've so far only been in X when this happens, mouse still moves, remote
applications update their windows fine, no lost keystrokes, it's when I
run something locally requiring disk IO.

Renicing setiathome to -19 causes the problem to vanish.

Dragging an xterm around seems to help it recover from a hang too.

> - How much memory does the machine have?

256

> - UP/SMP/preempt?

preempt

>
> - What do vmstat and top say?

3  1   2216  21008  27464  69920    0    0     0     0 1024   241 100  0  0 0
3  1   2216  20176  27464  69920    0    0     0     0 1024   249 100  0  0 0
3  1   2216  20176  27464  69920    0    0     0     0 1024   252  99  1  0 0
3  1   2216  21060  27464  69920    0    0     0     0 1025   236 100  0  0 0

> - Did it happen in 2.5.64?  2.5.63?  2.4.20?

2.5.64

> - Does it get better if you renice stuff?

Yes

> - What steps should others take to reproduce it?

Running setiathome with priority one seems to do it for me.

George


