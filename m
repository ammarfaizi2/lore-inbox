Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTFRL7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTFRL7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:59:50 -0400
Received: from pop.gmx.de ([213.165.64.20]:40104 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265170AbTFRL7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:59:49 -0400
Message-Id: <5.2.0.9.2.20030618140742.0274abf8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 18 Jun 2003 14:17:59 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds
  like  Windows!
Cc: Yaroslav Rastrigin <yarick@relex.ru>, linux-kernel@vger.kernel.org,
       mlmoser@comcast.net
In-Reply-To: <20030618110218.GA2037@hh.idb.hist.no>
References: <200306181330.48072.yarick@relex.ru>
 <200306172030230870.01C9900F@smtp.comcast.net>
 <3EF0214A.3000103@aitel.hist.no>
 <200306181330.48072.yarick@relex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:02 PM 6/18/2003 +0200, Helge Hafting wrote:
>On Wed, Jun 18, 2003 at 01:30:48PM +0400, Yaroslav Rastrigin wrote:
>[...]
> > Well, the problem is probably unsolvable on kernel level (kernel is 
> unaware of
> > user's habits in app/mem usage), but I think it's pretty solvable on user
> > level - give us a knob to tune VM's behavior. We mere mortals often know
> > better how we will use our system's memory, and which apps we will be
> > running.
>
>There are some knobs.  There's the mlock call that disables
>paging for whatever memory you want.
>
>xmms could easily stop skipping if it mlocks its own code
>and data.  Running it at elevated priority might also
>be a good idea, so cpu hogs don't starve it.

Unless it's having trouble getting music into ram fast enough.  It doesn't 
skip here unless I'm pushing hard on the pagecache.

>Both of these needs root pribileges, or at least a suid
>binary.  (The priority stuff _can_ be done without extra
>privileges by nicing every _other_ process instead.)
>
> > I, for myself, like laptop-mode patch (basically, it groups disk
> > writes to do them once in 5-10 minutes, thus allowing hdd to sleep a lot)
> > very much - when I'm on AC, most probably I'm in office , and turning 
> it off
> > is reasonable. When I'm on battery, though, chances are I won't be 
> compiling
> > the kernel and/or do other heavy disk IO, instead, I most likely will be
> > coding, so echo 1 >/proc/sys/vm/laptop_mode seems appropriate, 
> reasonable and
> > useful.
> > Could something like this be done with VM/swap policy ?
> >
>Sure.  Take a look at /proc/sys/vm/swappiness for example.
>More stuff like this can be made - by those interested.
>
>The original poster also fixed the problems by doing
>swapoff -a ; swapon -a...

I don't understand that.  Here, I can swap heftily and not skip.

         -Mike 

