Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbRCSUAX>; Mon, 19 Mar 2001 15:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRCSUAN>; Mon, 19 Mar 2001 15:00:13 -0500
Received: from sal.qcc.sk.ca ([198.169.27.3]:15108 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S131564AbRCSUAG>;
	Mon, 19 Mar 2001 15:00:06 -0500
Date: Mon, 19 Mar 2001 13:59:10 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
Message-ID: <20010319135910.A3804@qcc.sk.ca>
In-Reply-To: <3AB66233.B85881C7@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AB66233.B85881C7@bluewin.ch>; from otto.wyss@bluewin.ch on Mon, Mar 19, 2001 at 08:46:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss <otto.wyss@bluewin.ch> wrote:
> Lately I had an USB failure, leaving me without any access to my system
> since I only use an USB-keyboard/-mouse. All I could do in that
> situation was switching power off and on after a few minutes of
> inactivity. From the impression I got during the following startup, I
> assume Linux (2.4.2, EXT2-filesystem) is not very suited to any power
> failiure or manually switching it off. Not even if there wasn't any
> activity going on. 

You're not using the filesystem the way you should, if you expect to be
able to kill the power and not lose data.

> How could this be accomplished:
> 1. Flush any dirty cache pages as soon as possible. There may not be any
> dirty cache after a certain amount of idle time.

Mount the filesystem sychronously if you want this.

> 2. Keep open files in a state where it doesn't matter if they where
> improperly closed (if possible).

Mount the filesystem read-only if you want this.

> 3. Swap may not contain anything which can't be discarded. Otherwise
> swap has to be treated as ordinary disk space.

The kernel doesn't care about what's in swap.  Fix your applications if they
do.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
Any opinions expressed are just that -- my opinions.
-----------------------------------------------------------------------
