Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262451AbSI3Rej>; Mon, 30 Sep 2002 13:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSI3Rej>; Mon, 30 Sep 2002 13:34:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:24201 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262451AbSI3Rej>;
	Mon, 30 Sep 2002 13:34:39 -0400
Date: Mon, 30 Sep 2002 23:15:37 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] generic work queue handling, workqueue-2.5.39-D6
Message-ID: <20020930231537.A29582@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.44.0209301747560.13521-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209301747560.13521-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Sep 30, 2002 at 03:58:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 03:58:25PM +0000, Ingo Molnar wrote:
> it cannot get any simpler than this. Work-queues are SMP-safe and
> guarantee serialization of actual work performed.
> 

Ingo,

Is it possible that queue_task() handlers in earlier driver code may have
depended on implicit serialization against corresponding timer handlers since
each of those is run from BHs ? If so, isn't that an issue now with
no BHs ? Or, is it safe to assume that general smp-safety code in the
drivers will take care of serialization between timers and work-queues ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
