Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUIQRgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUIQRgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUIQRgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:36:25 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:49310 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268886AbUIQRgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:36:04 -0400
Message-ID: <9e4733910409171035164ff87b@mail.gmail.com>
Date: Fri, 17 Sep 2004 13:35:51 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: walt <wa1ter@myrealbox.com>
Subject: Re: [2.6.9-rc2-bk] Freeze during boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <414AE6DA.3050600@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <414AE6DA.3050600@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something is broken in general with the networking drivers. I have
e1000 and tg3 and both are broken. When Redhat goes into the probing
for new hardware phase all of the net drivers OOPs.

Problem has happened in the last 24hr in Linus BK. From the stack
track it is near fib_disable_ip().


On Fri, 17 Sep 2004 06:30:02 -0700, walt <wa1ter@myrealbox.com> wrote:
> Something committed in the last 24 hours is causing my machine
> to halt partway thru bootup.  It will print appropriate messages
> on the console for USB hotplug events, but networking never
> comes up so I can't ping the machine, and the login process
> never starts so I can't login and I can't tell what processes
> are actually running.
> 
> When I boot yesterday's kernel I get error messages saying
> that the kernel modules (from today) can't be loaded because
> they are in the wrong format.  That's an error I've never seen
> before this morning.  The only thing I can think to do is to
> recompile with all the drivers compiled into the kernel and
> see if I get any error messages (I'm not seeing any errors
> now).
> 
> Anyone else seeing anything like this?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Jon Smirl
jonsmirl@gmail.com
