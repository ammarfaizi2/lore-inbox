Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCSSDo>; Tue, 19 Mar 2002 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSCSSDf>; Tue, 19 Mar 2002 13:03:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46835
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S286322AbSCSSD0>; Tue, 19 Mar 2002 13:03:26 -0500
Date: Tue, 19 Mar 2002 10:04:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, MrChuoi <MrChuoi@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020319180417.GP2254@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	MrChuoi <MrChuoi@yahoo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203190753140.25412-100000@netfinity.realnet.co.sz> <E16nJin-0007iU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 01:32:13PM +0000, Alan Cox wrote:
> > actually been *allocated* as per requests, but not necesserily in use? 
> > This one is my home box, looks a bit crazy don't you think? The box has 
> 
> Yes
> 
> > about ~120 processes right now, heavy X session (2000x2000@32 virtual, 
> > KDE2 with lots of eye candy), two kernel builds in the background and 
> > cdrecord. 
> 
> I'm chasing a leak or two somewhere. One common theme seems to be KDE so
> my guess is there is something like an mprotect/mremap/shared page path that
> isnt correctly accounted and kde triggers more than most other stuff (eg
> because of the strange way KDE execs new processes). 
> 
> Last night I added some validator code for the non shmfs cases to see if
> I can find it. 

Hmm, you must have missed my report I sent to you earlier.

After a fresh reboot, I booted into the console (no X/kde started) and ran the
while looped kernel compile for a couple days.  Then I switched to single
user mode to see if the address space was recovered, but it was not.

Is there any way (I don't thing so, but...) that KDE can affect this when
there aren't any KDE processes running?

Mike
