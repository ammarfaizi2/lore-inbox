Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSI3TVs>; Mon, 30 Sep 2002 15:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261153AbSI3TVs>; Mon, 30 Sep 2002 15:21:48 -0400
Received: from tapu.f00f.org ([66.60.186.129]:24993 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261298AbSI3TVr>;
	Mon, 30 Sep 2002 15:21:47 -0400
Date: Mon, 30 Sep 2002 12:27:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] generic work queue handling, workqueue-2.5.39-D6
Message-ID: <20020930192713.GA15615@tapu.f00f.org>
References: <Pine.LNX.4.44.0209301747560.13521-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209301747560.13521-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 06:04:31PM +0200, Ingo Molnar wrote:

> the attached patch (against BK-curr) cleans up the impact of the
> removal of task-queue support. It merges kernel/context.c (keventd)
> and the old task-queue concept into a unified 'work queue'
> concept. The basic primitives are:

>      extern workqueue_t *create_workqueue(const char *name);
>      extern void destroy_workqueue(workqueue_t *wq);
>      extern int queue_work(work_t *work, workqueue_t *wq);
>      extern void flush_workqueue(workqueue_t *wq);

Is it possible to pin/stick a workqueue to a CPU (or group thereof)?
I'm thinking about trying to intelligently spread the load on larger
boxes exspecially perhaps NUMA machines where you may want the
workqueue local to some specific node.


  --cw

