Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTEYK0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTEYK0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:26:47 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:34433
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261706AbTEYK0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:26:46 -0400
Date: Sun, 25 May 2003 06:29:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH][2.5] Possible race in wait_task_zombie and
 finish_task_switch
In-Reply-To: <Pine.LNX.4.44.0305251226170.25774-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0305250625050.19617-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0305251226170.25774-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003, Ingo Molnar wrote:

> On Sun, 25 May 2003, Zwane Mwaikambo wrote:
> 
> > 	if (prev->state & (TASK_DEAD | TASK_ZOMBIE))
> > 		put_task_struct(prev);
> 
> we initialize tsk->usage with 2 in fork() - are you sure the removal of
> the above code will not result in a memory leak?

Isn't current the forked task? Also we initialise the forked task's state 
to TASK_UNINTERRUPTIBLE.

	Zwane
-- 
function.linuxpower.ca
