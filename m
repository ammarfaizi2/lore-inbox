Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUCCHud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 02:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUCCHud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 02:50:33 -0500
Received: from web20909.mail.yahoo.com ([216.136.226.231]:45969 "HELO
	web20909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262409AbUCCHu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 02:50:27 -0500
Message-ID: <20040303075026.2822.qmail@web20909.mail.yahoo.com>
Date: Tue, 2 Mar 2004 23:50:26 -0800 (PST)
From: Anonymous <anon78344@yahoo.com>
Subject: Re: init dies after reboot
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0403021145150.489@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for answer, but the thing with core is
imposible as I said that there is no /proc/1 dir :(

--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Tue, 2 Mar 2004, Anonymous wrote:
> 
> > Hello
> >
> > I encountered a strange problem, and i'm not sure
> that
> > it originates or not in the kernel.
> > the probl. is that on many slack boxes init dies
> after
> > some time, but the OS is still up and running.
> > if I 'ps aux' the machine,no init, and /proc/1
> doesn't
> > exist.
> > although, `lsof | grep init` shows:init          1
> > root  cwd    DIR        8,3        472         2 /
> > init          1   root  rtd    DIR        8,3
> > 472         2 /
> > init          1   root  txt    REG        8,3
> > 468916     15607 /sbin/init
> > init          1   root    0r   CHR        1,3
> >        5659 /dev/null
> > init          1   root    1u   CHR        1,3
> >        5659 /dev/null
> > init          1   root    2u   CHR        1,3
> >        5659 /dev/null
> > init          1   root   10u  FIFO        8,3
> >      137774 /dev/initctl
> >
> >
> > Any kind of ideea?
> >
> > Thanks,
> > Uwe Bower
> 
> The kernel will never send a signal 9 to init.
> However, it can
> send many other signals. If the signal handler in
> init got
> corrupt from a buffer overrun, bad memory, etc.,
> it's quite
> possible for init to die. When it dies, it would
> usually
> die as a result of a seg-fault. You can observe
> /proc/1/cwd to
> see where init lives. There may be a core-file in
> that directory.
> The core-file might be able to give you a hint.
> Also, somebody
> who has su privs can `cp /dev/random /dev/initctl`
> with some
> interesting results.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine
> (797.90 BogoMips).
>             Note 96.31% of all statistics are
> fiction.
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
