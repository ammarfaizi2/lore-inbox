Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVHCQtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVHCQtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVHCQsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:48:24 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:43395 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262337AbVHCQsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:48:20 -0400
Message-ID: <42F0F53C.5020403@andrew.cmu.edu>
Date: Wed, 03 Aug 2005 12:47:56 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ambx1@neo.rr.com
CC: "Theodore Ts'o" <tytso@mit.edu>, David Weinehall <tao@acc.umu.se>,
       Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <dbb91149e.1149edbb9@columbus.rr.com>
In-Reply-To: <dbb91149e.1149edbb9@columbus.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry all, but after receiving about 5 similar messages I'm going to 
make one last reply.)

ambx1@neo.rr.com wrote:
> Also, my understanding was that when we properly support usb suspend,
> this won't be an issue anyway for much usb hardware.  I think it's
> possible to put some mice to sleep when there isn't any motion and
> then wakeup later.

By the time we properly support USB suspend, it won't matter because the 
dynamic tick patch will likely have been integrated.  An argument for 
why we should change a value in the future is pointless when the 
question is what the value should be right now.

> 4.4% savings may not be much, but these things do add up.

A 300% increase in minimum sleep latency adds up quite quickly.

The point that people joining this thread keep missing is that we're 
making a change that:
   (a) offers a small benefit to laptop users
   (b) messes up other uses such as video
   (c) is likely to be completely obsolete by 2.6.14

> For a laptop's workload, I think this is worth it.

Good, so on your laptop go choose 100Hz.  You already have to configure 
your kernel to change values from their defaults anyway, otherwise you 
won't see any of that 4.4% savings.  However, please don't screw up 
video and interactivity (1) for everyone who uses default values on 
their desktops in order to get your savings.

(1) http://article.gmane.org/gmane.linux.kernel/319124/

Rather like the famous gcc 2.96, this is something that will confuse 
users for some time to come.  Just about every video app will need an 
FAQ entry to say why 2.6.13 doesn't work as well and drops frames while 
2.6.(x!=13) works just fine.  Unless of course distros read this thread 
and decide not to pick up this change; That I guess is the only reason 
I'm still posting.

Now as Lee said, please let this thread die.  We need to go work on 
dyntick and test it on as much hardware as possible and try to uncover 
any lurking bugs.  If you care about saving power or multimedia, you 
should test it too (think ~10% savings rather than 4.4%).

  - Jim Bruce
