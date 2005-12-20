Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVLTPaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVLTPaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVLTPaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:30:13 -0500
Received: from mtai03.charter.net ([209.225.8.183]:34244 "EHLO
	mtai03.charter.net") by vger.kernel.org with ESMTP id S1750764AbVLTPaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:30:12 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Message-ID: <43A822A0.4020101@cybsft.com>
Date: Tue, 20 Dec 2005 09:26:24 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.15-rc5-rt2 slowness
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain> <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu>
In-Reply-To: <20051220135725.GA29392@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>>> Now, is the solution to bring the SLOB up to par with the SLAB, or to
>>>> make the SLAB as close to possible to the mainline (why remove NUMA?)
>>>> and keep it for PREEMPT_RT?
>>>>
>>>> Below is the port of the slab changes if anyone else would like to see
>>>> if this speeds things up for them.
>>> ok, i've added this back in - but we really need a cleaner port of SLAB
>>> ...
>>>
>> Actually, how much do you want that SLOB code?  For the last couple of 
>> days I've been working on different approaches that can speed it up. 
>> Right now I have one that takes advantage of the different caches.  
>> But unfortunately, I'm dealing with a bad pointer some where that 
>> keeps making it bug. Argh!
> 
> well, the SLOB is mainly about being simple and small. So as long as 
> those speedups are SMP-only, they ought to be fine. The problems are 
> mainly SMP related, correct?
> 
> 	Ingo

No. I experienced horrible performance running the original patch with
the SLOB on my uniprocessor system vs. the patch with Steven's SLAB
patch applied on the same system. In fact I am currently running the
latter on that system now. With the original patch the system is really
unusable.

-- 
   kr
