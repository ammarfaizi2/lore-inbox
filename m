Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263230AbVCKHpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbVCKHpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 02:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbVCKHpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 02:45:40 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:10720 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S263230AbVCKHpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 02:45:31 -0500
Date: Fri, 11 Mar 2005 09:45:30 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: oom with 2.6.11
Message-ID: <20050311074530.GV25818@edu.joroinen.fi>
References: <422DC2F1.7020802@g-house.de> <3f250c710503090518526d8b90@mail.gmail.com> <3f250c7105030905415cab5192@mail.gmail.com> <422F016A.2090107@g-house.de> <423063DB.40905@g-house.de> <20050310163956.0a5ff1d7.akpm@osdl.org> <4230F0E6.5080708@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4230F0E6.5080708@g-house.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 02:14:14AM +0100, Christian Kujau wrote:
> Andrew Morton wrote:
> > Christian Kujau <evil@g-house.de> wrote:
> > 
> >>i was going to compile 2.6.11-rc5-bk4, to sort out the "bad" kernel.
> >>compiling went fine. ok, finished some email, ok, suddenly my swap was
> >>used up again, and no memory left - uh oh! OOM again, with 2.6.11-rc5-bk2!
> > 
> > 
> > Well if you ran out of swap then yes, the oom-killer will visit you.
> > 
> > Why did you run out of swapspace?
> 
> hm, if i only knew. i don't know how long it took the other night to go
> from "normal" to "OOM". but today, with 2.6.11-rc5-bk2 (well, yesterday
> actually) i was working normally, and all of a sudden swap goes from 170MB
> used swap (normal) to OOM. i think it took a minute or so, but i just
> can't tell which application went nuts. today the first process that got
> killed was "ssh-agent", the other day it was mysqld. but even after this,
> it should've released some memory, right? but the oom-killer goes on and
> on and kills the next task.
> 
> i'll monitor memory usage tonight and see what it gives. these "pppd"
> messages are suspicious though.
> 

I've also seen this 3 times now.. I'm running Xen 2.0 and the 2.6.10-xen0
kernel (with -as5 patch) goes OOM after a couple of days operation.. and
then the box reboots.

The "virtual machines" are OK, it's only the dom0 kernel that goes OOM.. 
And I'm not running anything special on dom0, only xen control stuff
(which is written in python..), ntp, nfs server, ssh, lvm2 and software raid.

Now I'm running a script which logs the cpu/memory/swap usage every 1
minutes.. trying to see if I can find the cause for the OOM.

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
