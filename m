Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVK0K5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVK0K5I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 05:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVK0K5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 05:57:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:57356 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750990AbVK0K5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 05:57:07 -0500
Date: Sun, 27 Nov 2005 11:57:00 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Brown <dmlb2000@gmail.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.14.tar.bz2 permissions
Message-ID: <20051127105700.GO11266@alpha.home.local>
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <200511270138.25769.s0348365@sms.ed.ac.uk> <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com> <200511270151.21632.s0348365@sms.ed.ac.uk> <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com> <29495f1d0511261827s7984bea8l92149b8a3091e6d8@mail.gmail.com> <9c21eeae0511261838ncec563v1739a1230347365b@mail.gmail.com> <20051127060937.GN11266@alpha.home.local> <9c21eeae0511270122h38cfb4a4y5d242347cbf9a21e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c21eeae0511270122h38cfb4a4y5d242347cbf9a21e@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 01:22:26AM -0800, David Brown wrote:
> > It certainly is not an excuse, but at least it my explain why nobody
> > noticed it before you :-)
> 
> Thanks for the info and suggestions ;)
> I trust Linus enough to compile a kernel as root... but maybe that's just me ;)

I don't, he's subject to errors just like any of us mere humans. I
wouldn't like anybody telling me he trusts my scripts or makefiles
and blindly runs them as root.

> (or maybe I trust that I can fix anything that can fsck up my system
> even with root perms ;))

I have an anecdote : several years ago, a collegue replaced me on a
benchmark platform during my hollidays. He wrote a few scripts to
help the guy doing the benchmarks, and one of his scripts archived
the logs and removed all the log directory and sub-directories to
prepare it for another run. When I came back, the guy doing the
benchs asked me to run this fresh new script to archive the logs,
which I tried. Unfortunately, it had to be run outside the log
directory so that it could find the directory name. One of its
lines was "rm -rf $LOGDIR/". Believe me, even on this Digital Unix
Alpha, it took a very long time to purge the directory when LOGDIR
was void, and we had to reinstall everything from scratch !

> I agree compiling the kernel as a non-root user is perfered but
> sometimes it doesn't happen that way...

Sudo generally helps here. It's even easy to put $SUDO in front
of sensible commands in build scripts and have SUDO=${SUDO-sudo}
at the beginning of the script.

Regards,
Willy

