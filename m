Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263893AbTCVUgj>; Sat, 22 Mar 2003 15:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263895AbTCVUgi>; Sat, 22 Mar 2003 15:36:38 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:53831
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263893AbTCVUgh>; Sat, 22 Mar 2003 15:36:37 -0500
Date: Sat, 22 Mar 2003 15:44:21 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       "" <linux-kernel@vger.kernel.org>, "" <jochen@jochen.org>
Subject: Re: BUG: Use after free in detach_pid
In-Reply-To: <20030322124447.59c6b4c3.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0303221543440.18911-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
 <3E7CC4F2.8000500@colorfullife.com> <20030322124447.59c6b4c3.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Andrew Morton wrote:

> Manfred Spraul <manfred@colorfullife.com> wrote:
> >
> > You mentioned that the last detach_pid() within __unhash_process oopsed. That means the reference count of the task structure was off by one, and the
> > 	put_task_struct(pid->task)
> > within 
> > 	detach_pid(p,PIDTYPE_PGID);
> > freed the task structure.
> > 
> 
> Might be related to http://bugme.osdl.org/show_bug.cgi?id=482
> in which someone did put_task_struct() on an already-freed task_struct.
> 
> And that was a uniprocessor without pgcl gunk.
> 
> It is not known whether preemption was enabled?

CONFIG_PREEMPT=y on 3way P133

-- 
function.linuxpower.ca
