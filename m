Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSCSGUU>; Tue, 19 Mar 2002 01:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310207AbSCSGUL>; Tue, 19 Mar 2002 01:20:11 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46586
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310206AbSCSGT7>; Tue, 19 Mar 2002 01:19:59 -0500
Date: Mon, 18 Mar 2002 22:20:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: MrChuoi <MrChuoi@yahoo.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020319062030.GN2254@matchmail.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	MrChuoi <MrChuoi@yahoo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020319012940.430CC4E534@mail.vnsecurity.net> <Pine.LNX.4.44.0203190753140.25412-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 07:54:12AM +0200, Zwane Mwaikambo wrote:
> Hi,
> Just a question, does the commited as field specify how much memory has 
> actually been *allocated* as per requests, but not necesserily in use? 
> This one is my home box, looks a bit crazy don't you think? The box has 
> about ~120 processes right now, heavy X session (2000x2000@32 virtual, 
> KDE2 with lots of eye candy), two kernel builds in the background and 
> cdrecord. 
> 
> Linux version 2.4.19-pre2-ac3 (zwane@montezuma) (gcc version 2.96 20000731 
> (Red Hat Linux 7.1 2.96-98)) #2 Sat Mar 9 20:44:38 SAST 2002
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  527527936 519610368  7917568        0 16871424 398352384
> Swap: 542785536 73433088 469352448
> MemTotal:       515164 kB
> MemFree:          7732 kB
> MemShared:           0 kB
> Buffers:         16476 kB
> Cached:         380044 kB
> SwapCached:       8972 kB
> Active:         262252 kB
> Inact_dirty:    209392 kB
> Inact_clean:     11248 kB
> Inact_target:    96576 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       515164 kB
> LowFree:          7732 kB
> SwapTotal:      530064 kB
> SwapFree:       458352 kB
> Committed AS:  8060848 kB
> 
> Things could get interesting if everyone touches their pages ;)

What's your uptime?

I've been able to get "Committed AS" to just grow and grow with a kernel
compile within a while loop after a couple days (pii 350, so faster machines
should show that sooner...).

When you get a chance, go into single user mode and see if "Committed AS"
goes down to a sane level.  If not, you're seeing what I am.

I've seen it without highmem, with and without smp, etc. more info available
upon request.

Mike
