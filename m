Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWBRQCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWBRQCC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWBRQAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16812 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751435AbWBRQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:33 -0500
Date: Sat, 18 Feb 2006 15:26:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060218142610.GT3490@openzaurus.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211104130.GA28282@kobayashi-maru.wspse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for a fresh air in this flamewar...

> I have to completly agree with Sebastian here. 16 months ago I was in
> the need to have a suspend mode running on my new notebook. Back then
> Suspend 2 was the only choice, and while it had still problems it was
> surprisingly well behaving (in contrast to S3 mode and the mainline
> swsusp). The support of the community was, as said above, very good, and
> most issues very fixed fast.

Can you test recent swsusp?
> 
> Since it worked good for me, I started to contribute by supplying Fedora
> patched kernels, helper packages and some documentation. Today on
> Fedora, it is as easy as installing 4 RPM-packages and adding the
> "resume2=" parameter to the kernel commandline, and I know that it works
> this well on several other distributions too.

...well, thanks for your good work.

> Some more numbers: judging from my access logs and the feedback I get, I
> suspect at least 2000 Fedora users using Suspend 2 on a regular basis
> with success. Listening to the IRC channel and reading the forums and
> wikis, I see a huge bunch of people using Suspend 2 on nearly every
> distribution. The problems are incredible low, mostly minor things that
> get fixed nearly instantly.

Well, at least Fedora and SuSE ship swsusp by default. So it is getting
huge ammount of testing, too.
> 
> Some pros of Suspend 2 from my view:
> - it is reliable and stable (really!)
> - it is fast (10-30 seconds on my notebook with 1280 MB ram, depending
>   on how much caches are saved)
> - it can save all buffers and caches and the system is instantly
>   responsible after resume (even Windows cannot do this and is very slow
>   the first minute after resume)
> - it works on all major platforms (x86, SMP, x86_64, there were success
>   reports for PPC, and I believe even ARM works)
> - and the most important thing, as already said, it is available _today_

swsusp is also available today, and works better than you think. It is slightly
slower, but has all the other
features you listed in 2.6.16-rc3.

> The only con I see is the complexity of the code, but then again, Nigel

..but thats a big con.

> Again, you said the code is complex, it might be, but still most part of
> the code is completly seperate from the rest of the kernel, and only
> touches minor things (and Nigel is still working on that). I believe it
> would not hurt.

It would hurt at least me, Andrew and Linus... It would make lot
of suspend2 users very happy...
> From a user, and contributor, point of view, I really do not understand
> why not even trying to push a working implementation into mainline (I
> know that you cannot just apply the Suspend 2 patches and shipping it,

It is less work to port suspend2's features into userspace than to make
suspend2 acceptable to mainline. Both will mean big changes, and may
cause some short-term problems, but it will be less pain than 
maintaining suspend2 forever. Please help with the former...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

