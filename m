Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSGTVXT>; Sat, 20 Jul 2002 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSGTVXT>; Sat, 20 Jul 2002 17:23:19 -0400
Received: from 209-161-7-161.bradetich.boi.fiberpipe.net ([209.161.7.161]:18341
	"EHLO beavis.ybsoft.com") by vger.kernel.org with ESMTP
	id <S317528AbSGTVXR>; Sat, 20 Jul 2002 17:23:17 -0400
Subject: Re: [PATCH] kernel/sched.c - Use the task state macros provided in
	include/linux/sched.h
From: Ryan Bradetich <rbradetich@uswest.net>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44.0207202138430.17900-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207202138430.17900-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jul 2002 15:26:16 -0600
Message-Id: <1027200377.28932.5.camel@beavis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am working on a a kernel janitor project to use the task state
macros provided in the include/linux/sched.h instead of setting the
task state directly.  Ingo suggested I bring the discussion to this
list to see if this janitor project is still valid, or the best way
to impliment this project.

The entire kernel janitor thread can be found here:
http://sourceforge.net/mailarchive/forum.php?thread_id=908916&forum_id=2314


Thanks,

- Ryan


On Sat, 2002-07-20 at 13:46, Ingo Molnar wrote:
> 
> On 20 Jul 2002, Ryan Bradetich wrote:
> 
> > Finally, since this is a janitor project, and I have only receieved
> > feedback from you, should I continue generating these patches and have
> > the maintainers reject the patches if they feel it makes the code less
> > clear?  Or should I just abandon the project?
> 
> Using the macro has one more advantage i did not consider: it shows that
> the maintainer has considered the SMP issues and has intentionally decided
> to use one of the two variants. So it's not just a simple wrapping of an
> assignment.
> 
> > I guess what I would like to see is the task change state done fairly
> > consistently throught the kernel ... lots of places already use the
> > __set_[current_task]_state macros, while other set the state directly. I
> > also realize maintenance is more important then look/feel consistenance.
> 
> in 2.5.26, 555 places use it directly, 128 places use the __set_*_state
> macros, 865 places use the SMP-safe set_*_state macros.
> 
> perhaps it might make sense to raise the issue on the kernel-list?
> 
> 	Ingo
> 
> 


