Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUIITao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUIITao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUIITYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:24:37 -0400
Received: from holomorphy.com ([207.189.100.168]:48050 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263100AbUIITXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:23:18 -0400
Date: Thu, 9 Sep 2004 12:23:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909192313.GK3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909191142.GA30151@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 11:49:33 -0700, William Lee Irwin III wrote:
>> I'll follow up shortly with a task_mem()/task_mem_cheap() consolidation
>> patch atop the others I sent.

On Thu, Sep 09, 2004 at 09:11:42PM +0200, Roger Luethi wrote:
> I have a few minor changes coming up as well.

I rest assured that nothing I've written thus far will apply to or be
included in any of it, as a matter of course (nothing specific to you).


On Thu, Sep 09, 2004 at 09:11:42PM +0200, Roger Luethi wrote:
> One nitpick: As vmexe and vmlib are always 0 for !CONFIG_MMU, we should
> ifdef them out of the list of offered fields for that configuration (and
> maybe in nproc_ps_field as well).

This may be; I'll leave that decision to you as the interface designer.


On Thu, 09 Sep 2004 11:49:33 -0700, William Lee Irwin III wrote:
>> I'm not aware of a discrepancy with the fs/proc/task_nommu.c code; I
>> did, however, have to mangle the things via guesswork to avoid adding
>> the new fields, which I really wanted you to arrange for or comment on
>> as they are a matter of interface. Also, could you be more specific
>> about these discrepancies?

On Thu, Sep 09, 2004 at 09:11:42PM +0200, Roger Luethi wrote:
> task_nommu.c offers Mem, Slack, and Shared. __task_mem for !CONFIG_MMU
> offers VmData, VmStack, VmRSS, VmSize.

I took the structure fields to be just an argument passing convention
giving the nommu case an identical prototype much like the helpers in
fs/proc/task_{no,}mmu.c. Using different field names and etc. is also
feasible, of course. I'll wait for your updates to follow up further.


-- wli
