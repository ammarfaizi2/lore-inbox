Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRHTTJY>; Mon, 20 Aug 2001 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbRHTTJP>; Mon, 20 Aug 2001 15:09:15 -0400
Received: from news.cistron.nl ([195.64.68.38]:59145 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S268860AbRHTTJB>;
	Mon, 20 Aug 2001 15:09:01 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in
 /proc/<pid>/status
Date: Mon, 20 Aug 2001 19:09:16 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9lrn8s$t23$1@ncc1701.cistron.net>
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu> <26210000.998324773@baldur>
X-Trace: ncc1701.cistron.net 998334556 29763 195.64.65.67 (20 Aug 2001 19:09:16 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <26210000.998324773@baldur>,
Dave McCracken  <dmc@austin.ibm.com> wrote:
>
>--On Monday, August 20, 2001 17:19:13 +0100 Alan Cox 
><alan@lxorguk.ukuu.org.uk> wrote:
>
>> I didnt think anyone was using the broken tgid stuff ?
>
>I was under the impression that the current LinuxThread library does use 
>CLONE_THREAD, and I know of at least one project under way that's also 
>using it (the NGPT pthread library).  The getpid() system call already 
>returns tgid instead of pid.  I'm also looking into what's involved in 
>making tgid more robust.

Hmm, I've always been a bit curious about this .. I don't think getpid()
should return tgid instead of pid. It looks broken to me. Thread groups
are a good idea, but they should act more like process groups do.
Switching pid and tgid is something that the LinuxThreads library
should probably do, but not the kernel. IMHO.

If one really wants CLONE_PID to work, fix CLONE_PID.

Mike.

