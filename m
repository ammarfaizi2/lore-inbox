Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUHDKEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUHDKEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUHDKEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:04:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:429 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263159AbUHDKEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:04:44 -0400
Date: Wed, 4 Aug 2004 15:36:42 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: dipankar@in.ibm.com, Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, zwane@linuxpower.ca
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
Message-ID: <20040804100642.GA20278@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040802094907.GA3945@in.ibm.com> <20040802095741.GA4599@in.ibm.com> <1091475519.29556.4.camel@pants.austin.ibm.com> <1091478386.29556.36.camel@pants.austin.ibm.com> <1091567239.28036.36.camel@biclops.private.network>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091567239.28036.36.camel@biclops.private.network>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 04:07:20PM -0500, Nathan Lynch wrote:
>                 BUG_ON(rq->nr_running != 0);
> 
> I can reproduce this on both ppc64 and i386.  Does anyone know why this
> is happening?

I guess some task is still stuck with the dead CPU. Can you put a breakpoint on the BUG_ON 
and see the ps output (in kdb) to see which task is that when you hit the breakpoint?

I will also try debugging the 2.6.8-rc2 CPU Hotplug woes as soon as I can.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
