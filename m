Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272289AbTGYUR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272291AbTGYUR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:17:29 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:44162 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272289AbTGYURZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:17:25 -0400
Date: Fri, 25 Jul 2003 21:42:37 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307252042.h6PKgbxX001831@81-2-122-30.bradfords.org.uk>
To: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | > >    text    data     bss     dec     hex filename
> | > >  633028   37952  134260  805240   c4978 linux-2.4.x/linux-Os
> | > >  819276   52460   78896  950632   e8168 linux-2.5.x/vmlinux-inline-Os
> | > >  ^^^^^^
> | > >        2.6 still needs a hard diet... :-/
> | >
> | > I did the same observation a few weeks ago on 2.5.74/gcc-2.95.3. I tried
> | > to track down the responsible, to the point that I completely disabled
> | > every driver, networking option and file-system, just to see, and got about
> | > a 550 kB vmlinux compiled with -Os. 550 kB for nothing :-(
> | 
> | Some of the bigger 2.6 additions cannot be configured out.
> | I wish sysfs and the different I/O schedulers could be removed.

I thought that an optimisation for text size in 2.4 had been purposely
taken out of the 2.5 tree, because we expected GCC to do it
automatically by the time 2.6 was released?

> Perhaps after 2.6.n is out and stable for a month or so someone could
> look at the problem. Certainly the various io schedulers are good
> candidates for being optional and/or modules. The problem is that the
> parts which aren't needed aren't large, so you may not gain much.
>
> Clearly you have to have *some* io scheduler

For embedded systems, or anything completely solid state which doesn't
use a traditional spinning-disk-with-moving-heads, you could replace
it with a very simple one, and not loose much performance.

> I'm not sure if sysfs is optional in any meaningful way any more. I
> haven't tried running w/i /proc in a few months, it didn't work when
> I did, but old kernels are old news.

Try compiling out TCP/IP if your application doesn't need it.  A lot
of embedded systems don't.

John.
