Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVBOUYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVBOUYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVBOUVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:21:49 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:61927 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S261879AbVBOUOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:14:06 -0500
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Stefan Seyfried <seife@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4212121B.807@suse.de>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>
	 <20050214231605.GA13969@suse.de>
	 <1108423715.32293.2.camel@krustophenia.net>  <4212121B.807@suse.de>
Content-Type: text/plain
Message-Id: <1108498326.3866.57.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 15 Feb 2005 15:12:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 10:15, Stefan Seyfried wrote:
> You can boot a SUSE 9.2 with parallel init scripts (default AFAIR),
> sequential init scripts and with a Makefile based solution. "Normal"
> (not Makefile based) parallel booting is possible much longer on SUSE,
> at least since 9.0 IIRC.
> And guess what? "Parallel booting" alone, regardless of the mechanism
> does not make much of a difference for the boot time.
> 

My experience has been that hardware detection is what slows boot
process.  I've tested on various distros, Red Hat Linux, Slackware
Linux, SUSE, and Debian.

Starting services never seems to take any time (noticeable time).  But
when it lands on detecting hardware, that's where the time is chewed. 
Typically with hotplug (all using 2.4 kernels) it's about 30 seconds,
which is the same as the rest of the boot process in my testing lab. 
1394, USB, and PCMCIA seem to be the slowest (because when I remove
these devices or turn off detection of these types boot time is *much*
faster).


Two things that I believe should be addressed;

1) Speeding up boot time (even if that means moving some hardware
detection and recognition to after login)

-and-

2) Proper identification of filesystem types.  Would love to have an
agreed upon by majority change that would change the mounting of
filesystems (identifying FS TYPE) to be more accurate.  


regards,

-fd

