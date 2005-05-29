Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVE2MYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVE2MYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 08:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVE2MYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 08:24:43 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:49868 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261254AbVE2MYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 08:24:34 -0400
Message-Id: <4299B450.3040605@khandalf.com>
Date: Sun, 29 May 2005 14:23:44 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de>
    <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
    <20050526193230.GY86087@muc.de>
    <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
    <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
    <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
    <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>
    <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au>
    <4299A98D.1080805@andrew.cmu.edu>
In-Reply-To: <4299A98D.1080805@andrew.cmu.edu>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: df1dac84941c1977af9997d0e172bf2e
X-Transmit-Date: Sunday, 29 May 2005 14:25:14 +0200
X-Message-Uid: 0000b49cec9df3d800000002000000004299b4aa000cb38000000001000b8c02
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 32701; Body=9
	Fuz1=9 Fuz2=9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, the u-kernel has been tried, MACH & Chorus, and even the real
NT core, as opposed to the Win32 API skin, and has not worked well
yet.

James Bruce wrote:
> Nick Piggin wrote:
> 
>> But nobody has been able to say why a single kernel is better than a
>> nanokernel.
> 
> 
> I think it's a bit more like you haven't realized the answer when people
> gave it, so let me try to be more clear.  It's purely a matter of effort
> - in general it's far easier to write one process than two communicating
> processes.  As far as APIs, with a single-kernel approach, an RT
> programmer just has to restrict the program to calling APIs known to be
> RT-safe (compare with MT-safe programming).  In a split-kernel approach,
> the programmer has to write RT-kernel support for the APIs he wants to
> use (or beg for them to be written).  Most programmers would much rather
> limit API usage than implement new kernel support themselves.
> 
> A very common RT app pattern is to do a bunch of non-RT stuff, then
> enter an RT loop.  For an example from my work, a robot control program
> starts by reading a bunch of configuration files before it starts doing
> anything requiring deadlines, then enters the RT control loop.  Having
> to read all the configuration in a separate program and then marshall
> the data over to an RT-only process via file descriptors is quite a bit
> more effort.  I guess some free RT-nanokernels might/could support
> non-RT to RT process migration, or better messaging, but there's
> additional programming effort (and overhead) that wasn't there before.
> In general an app may enter and exit RT sections several times, which
> really makes a split-kernel approach less than ideal.
> 
> An easy way to visualize the difference in programming effort for the
> two approaches is to take your favorite threaded program and turn it
> into one with separate processes that only communicate via pipes.  You
> can *always* do this, its just very much more painful to develop and
> maintain.  Your stance of "nobody can prove why a split-kernel won't
> work" is equivalent to saying "we don't ever really need threads, since
> processes suffice".  That's true, but only in the same way that I don't
> need a compilier or a pre-existing operating system to write an
> application.
> 
>  - Jim Bruce
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
mit freundlichen Grüßen, Brian.

Dr. Brian O'Mahoney
Mobile +41 (0)79 334 8035 Email: omb@bluewin.ch
Bleicherstrasse 25, CH-8953 Dietikon, Switzerland
PGP Key fingerprint = 33 41 A2 DE 35 7C CE 5D  F5 14 39 C9 6D 38 56 D5
