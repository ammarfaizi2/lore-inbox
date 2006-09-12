Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWILVs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWILVs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWILVs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:48:26 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:15502 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S1751450AbWILVsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:48:25 -0400
Date: Tue, 12 Sep 2006 23:48:22 +0200
From: Christian Leber <christian@leber.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] 2.6.18-rc6: hda is allready "IN USE" when booting / pi futex
Message-ID: <20060912214822.GA20437@core>
References: <20060907133357.GA30888@core> <20060912153932.GA14388@core> <20060912173455.GB6236@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912173455.GB6236@elte.hu>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 07:34:55PM +0200, Ingo Molnar wrote:

> yeah, i too suspect that it's timing related.

I guess that means it's actually a bug in the ide chipset driver.

> The b29739f902ee76a05493fb7d2303490fc75364f4 patch is quite large, so i 
> have created a finegrained, functional splitup of it:
> 
>   sched-cleanups.patch
>   sched-add-task-rq-lock-ops.patch
>   sched-add-rt-mutex-setprio.patch
>   sched-pi-lock.patch
>   sched-add-new-macros.patch
>   sched-add-normal-prio.patch
>   sched-use-has-rt-policy.patch

until here everthing seems to be ok (20 boots)

>   sched-set-user-nice-fix.patch

here we go, that one triggers the problem

>   sched-use-normal-prio.patch
> 
> and have attached the resulting tarball.

Thank you a lot, i didn't know how to split it up.


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
