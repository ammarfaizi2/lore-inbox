Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263372AbRFEV1Y>; Tue, 5 Jun 2001 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbRFEV1O>; Tue, 5 Jun 2001 17:27:14 -0400
Received: from gateway.sequent.com ([192.148.1.10]:5542 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S263372AbRFEV1A>; Tue, 5 Jun 2001 17:27:00 -0400
Date: Tue, 5 Jun 2001 14:26:50 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Nigel Gamble <nigel@nrg.org>
Cc: Mike Kravetz <mkravetz@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: reschedule_idle changes in ac kernels
Message-ID: <20010605142650.D1104@w-mikek2.des.sequent.com>
In-Reply-To: <20010604160837.B15640@w-mikek2.des.sequent.com> <Pine.LNX.4.05.10106041656430.3260-100000@cosmic.nrg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.05.10106041656430.3260-100000@cosmic.nrg.org>; from nigel@nrg.org on Mon, Jun 04, 2001 at 05:25:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran the VolanoMark and TPC-H benchmarks on an 8 CPU system
to observe the differences when changing the value at which
preemptions are triggered.  I used the 2.4.5 kernel as a basis
and only changed the 'max_prio = ' statement in reschedule_idle()
to change the preemption trigger threshold.  In the 2.4.5 kernel
the value of max_prio is set to 1.

The results:

In VolanoMark, changing the preemption trigger from 1 to 0
resulted in a 4% drop in throughput.

In TPC-H there was virtually no difference when going from
1 to 0.  If anything, the results were slightly better with
0 as a threshold value as opposed to 1.

My guess is that the threshold value was changed from 0 to
1 in the 2.4 kernel for better performance with some workload.
Anyone remember what that workload was/is?

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
