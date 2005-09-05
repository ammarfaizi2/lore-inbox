Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVIEXNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVIEXNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVIEXNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:13:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25160
	"EHLO g5.random") by vger.kernel.org with ESMTP id S964934AbVIEXNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:13:33 -0400
Date: Tue, 6 Sep 2005 01:13:12 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org, klive@cpushare.com
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050905231312.GI5606@g5.random>
References: <20050830030959.GC8515@g5.random> <20050906000507.5c0a1c9f@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906000507.5c0a1c9f@vaio.gigerstyle.ch>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 12:05:07AM +0200, Marc Giger wrote:
> Hi Andrea
> 
> Two little details:
> 
> The following line does not print what you expect on
> alpha's:
> 
> MHZ = int(re.search(r' (\d+)\.?\d?',
>                     os.popen("grep -i mhz /proc/cpuinfo | head -n
> 1").read()).group(1))

Thanks for reminding me about it ;)

> Second, you should mention somewhere that it needs at minimum twisted
> 1.3.0 to work correctly, did you?

I didn't, I actually hoped it would work with older twisted too ;)

> Oh, another point:
> Some of my machines have long uptimes, and I won't it reboot
> to just match the klive runtime. So the reported uptime
> is (in my cases) far away from true.

You don't need to reboot them, however I can't trust past uptimes or it
would be way too easy to fake the results (it's still easy but it takes
a lot more effort).

> It is very interesting to see how often a vanilla/-git/-mm etc kernel is
> tested. [..]

This is the objective yes.

> [..]. Perhaps klive could be extended to automatically report oopses
> and/or other troubles if possible. What abut reporting core features
> which are used on the machine like fs, scheduler, raid, lvm etc, so
> that the devs can see which subsystem got a lot testing and what is
> not used much?

So it sounds like the next thing to do is to extend the protocol to add
an _optional_ reporting of more info on the subsystems and hardware
involved (turned off by default). About the oopses that will require
kernel changes, and as per previous emails that'd be a very interesting
feature to enable optionally too (via sysctl etc..).

The old protocol (number 0) will stay, infact that will remain the
default.

Thanks.
