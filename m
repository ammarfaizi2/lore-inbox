Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132743AbRDDDwJ>; Tue, 3 Apr 2001 23:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132744AbRDDDvt>; Tue, 3 Apr 2001 23:51:49 -0400
Received: from gateway.sequent.com ([192.148.1.10]:40309 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S132743AbRDDDvl>; Tue, 3 Apr 2001 23:51:41 -0400
Date: Tue, 3 Apr 2001 19:47:00 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Fabio Riccardi <fabio@chromium.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, Ingo Molnar <mingo@elte.hu>,
        frankeh@us.ibm.com, Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: a quest for a better scheduler
Message-ID: <20010403194700.A1024@w-mikek2.sequent.com>
In-Reply-To: <20010403121308.A1054@w-mikek2.sequent.com> <Pine.LNX.4.30.0104032024290.9285-100000@elte.hu> <20010403154314.E1054@w-mikek2.sequent.com> <3ACA683A.89D24DED@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3ACA683A.89D24DED@chromium.com>; from fabio@chromium.com on Tue, Apr 03, 2001 at 05:18:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 05:18:03PM -0700, Fabio Riccardi wrote:
> 
> I have measured the HP and not the "scalability" patch because the two do more
> or less the same thing and give me the same performance advantages, but the
> former is a lot simpler and I could port it with no effort on any recent
> kernel.

Actually, there is a significant difference between the HP patch and
the one I developed.  In the HP patch, if there is a schedulable task
on the 'local' (current CPU) runqueue it will ignore runnable tasks on
other (remote) runqueues.  In the multi-queue patch I developed, the
scheduler always attempts to make the same global scheduling decisions
as the current scheduler.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
