Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbTCGJor>; Fri, 7 Mar 2003 04:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261461AbTCGJor>; Fri, 7 Mar 2003 04:44:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:54161
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261459AbTCGJoq>; Fri, 7 Mar 2003 04:44:46 -0500
Date: Fri, 7 Mar 2003 04:53:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
In-Reply-To: <20030307010539.3c0a14a3.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0303070450290.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
 <20030306222328.14b5929c.akpm@digeo.com>
 <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
 <20030306233517.68c922f9.akpm@digeo.com>
 <Pine.LNX.4.50.0303070351060.18716-100000@montezuma.mastecende.com>
 <20030307010539.3c0a14a3.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Andrew Morton wrote:

> > [root@dev16-002 root]# Slab corruption: start=db0bbc44, expend=db0bbc83, problemat=db0bbc48
> > Data: ....71 F0 2C .........................................................
> > Next: 71 F0 2C .71 F0 2C .........................
> > slab error in check_poison_obj(): cache `size-64': object was modified after freeing
> > Call Trace:
> >  [<c0142319>] check_poison_obj+0x119/0x130
> >  [<c0143c92>] kmalloc+0xd2/0x180
> >  [<c0166188>] pipe_new+0x28/0xd0
> >  [<c0166263>] get_pipe_inode+0x23/0xb0
> >  [<c0166322>] do_pipe+0x32/0x1e0
> >  [<c01704ac>] dput+0x1c/0x2b0
> >  [<c016661e>] getname+0x5e/0xa0
> >  [<c012f9b0>] sigprocmask+0xe0/0x150
> >  [<c012fb9a>] sys_rt_sigprocmask+0x17a/0x190
> >  [<c0111ed3>] sys_pipe+0x13/0x60
> >  [<c010ad9b>] syscall_call+0x7/0xb
> 
> I don't see any clues there.
> 
> This is a bad, bad bug.  How are you triggering it?

Very hard to trigger, currently it's happening whilst the system appears 
to be idle so i'm trying to track down what processes there are when the 
trigger happens.

> Manfred, would it be possible to add builtin_return_address(0) into each
> object, so we can find out who did the initial kmalloc (or kfree, even)?
> 
> It'll probably require CONFIG_FRAME_POINTER.

	Zwane
-- 
function.linuxpower.ca
