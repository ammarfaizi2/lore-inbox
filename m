Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUIIS4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUIIS4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUIISwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:52:51 -0400
Received: from holomorphy.com ([207.189.100.168]:29362 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266391AbUIIStl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:49:41 -0400
Date: Thu, 9 Sep 2004 11:49:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909184933.GG3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909184300.GA28278@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2004 17:35:29 -0700, William Lee Irwin III wrote:
>> Any chance you could convert these to use the new vm statistics
>> accounting?

On Thu, Sep 09, 2004 at 08:43:01PM +0200, Roger Luethi wrote:
> Mea culpa. I copied the routines wholesale from 2.6.7 when I started
> work on nproc. They still seemed to work with 2.6.9-rc1-bk13, I hadn't
> noticed the work that had gone into field computation already. So for
> CONFIG_MMU, values in both __task_mem and __task_mem_cheap are cheap
> now. The routines can be merged.
> !CONFIG_MMU is a different story. Presumably, it needs a change in the
> fields that are offered (cp. task_mem in fs/proc/task_nommu.c).
> FWIW, my prefered solution would be to have only one routine task_mem
> to fill the respective struct for nproc and /proc.

I'll follow up shortly with a task_mem()/task_mem_cheap() consolidation
patch atop the others I sent.


On Thu, Sep 09, 2004 at 08:43:01PM +0200, Roger Luethi wrote:
> There seems to be a discrepancy between current task_mem in
> fs/proc/task_nommu.c and the __task_mem{,_cheap} routines you wrote
> for the nproc !CONFIG_MMU case. Can you explain?

I'm not aware of a discrepancy with the fs/proc/task_nommu.c code; I
did, however, have to mangle the things via guesswork to avoid adding
the new fields, which I really wanted you to arrange for or comment on
as they are a matter of interface. Also, could you be more specific
about these discrepancies?


-- wli
