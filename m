Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUJNUXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUJNUXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUJNTqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:46:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51605 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267421AbUJNTmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:42:32 -0400
Date: Fri, 15 Oct 2004 01:13:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014194310.GI4112@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <1097779972.30253.947.camel@dhcp153.mvista.com> <20041014192803.GA10972@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014192803.GA10972@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 09:28:04PM +0200, Ingo Molnar wrote:
> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > When I was reviewing this it seemed like it would be possible to keep
> > RCU anonymous by moving the callback processing out of the tasklet .
> > The reason it was moved into a tasklet was to reduce latency. But if
> > you serialize it like you have, aren't you removing all the benefits
> > of the RCU type lock in those section that are converted to the new
> > API ?
> 
> only if compiling for PREEMPT_REALTIME. Given the overhead of
> PREEMPT_REALTIME i'm not sure RCU matters that much. But the nicest
> would be Dipankar's preemptible-RCU patch.
> 

I am swamped this week and racing against time to get some other
pending things done in time. I will look at the issue of RCU with
PREEMPT_REALTIME next week and try to help out.

Thanks
Dipankar
