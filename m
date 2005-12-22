Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVLVVrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVLVVrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVLVVrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:47:41 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:4850 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030324AbVLVVrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:47:40 -0500
Message-ID: <43AB1E55.6040703@mvista.com>
Date: Thu, 22 Dec 2005 13:44:53 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Eric Dumazet <dada1@cosmosbay.com>, Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
References: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu> <43A90225.4060007@cosmosbay.com> <20051221074346.GA2398@elte.hu> <43A90C07.4000003@cosmosbay.com> <20051222211132.GA21742@elte.hu>
In-Reply-To: <20051222211132.GA21742@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> that's just the profiling interrupt hitting them. You should not analyze 
> irq-safe code with a non-NMI profiling interrupt.
> 
> CLI/STI is extremely fast. (In fact in the -rt tree i'm using them 
> within mutexes instead of preempt_enable()/preempt_disable(), because 
> they are faster and generate less register side-effect.)
> 
Hm... I rather thought that the cli would cause a rather large hit on 
the pipeline and certainly on OOE.  Is your observation based on any 
particular instruction stream?  Sti, on the otherhand should be fast...
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
