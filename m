Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269690AbUISB5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269690AbUISB5s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 21:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUISB5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 21:57:47 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:41714 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269690AbUISB5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 21:57:44 -0400
Date: Sat, 18 Sep 2004 21:57:32 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Keith Packard <keithp@keithp.com>, Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
In-Reply-To: <9e47339104091817545b3d2675@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0409182156160.3498@node2.an-vo.com>
References: <9e47339104091815125ef78738@mail.gmail.com>  <E1C8oiI-0001xU-UG@evo.keithp.com>
 <9e47339104091817545b3d2675@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Sep 2004, Jon Smirl wrote:

> Isn't there an enviroment variable that tells what device is the
> console for the session? How do you tell what serial port you're on
> when multiple people are logged in on serial lines?

>From any program you can do this:

volodya@silver:~$ ls -l /proc/self/fd/0
lrwx------  1 volodya users 64 Sep 18 21:56 /proc/self/fd/0 -> /dev/pts/1

So you get the pointer to the actual device stdin is associated to.

                          best

                            Vladimir Dergachev

>
>
> On Sat, 18 Sep 2004 16:33:54 -0700, Keith Packard <keithp@keithp.com> wrote:
>>
>> Around 18 o'clock on Sep 18, Jon Smirl wrote:
>>
>>> The sysfs scheme has the advantage that there is no special user
>>> command required. You just use echo or cp to set the mode.
>>
>> But it makes it difficult to associate the sysfs entry with the particular
>> session.  Seems like permitting multiple opens of /dev/fb0 with mode
>> setting done on that file pointer will be easier to keep straight
>>
>>
>>
>>
>
>
>
> -- 
> Jon Smirl
> jonsmirl@gmail.com
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>
