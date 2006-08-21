Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWHUIeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWHUIeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWHUIeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:34:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:43716 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750793AbWHUIeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:34:16 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 0/7] CPU controller - V1
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060820174015.GA13917@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 10:42:40 +0000
Message-Id: <1156156960.7772.38.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 23:10 +0530, Srivatsa Vaddagiri wrote:
> Salient design points of this patch:
> 
> 	- Each task-group gets its own runqueue on every cpu.
> 
> 	- In addition, there is an active and expired array of
> 	  task-groups themselves. Task-groups who have expired their
> 	  quota are put into expired array.
> 
> 	- Task-groups have priorities. Priority of a task-group is the
> 	  same as the priority of the highest-priority runnable task it
> 	  has. This I feel will retain interactiveness of the system
> 	  as it is today.

WRT interactivity: Looking at try_to_wake_up(), it appears that wake-up
of a high priority group-a task will not result in preemption of a lower
priority current group-b task.  True?

	-Mike

