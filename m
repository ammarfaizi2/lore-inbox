Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUD2WNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUD2WNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbUD2WNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:13:43 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:54535 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264997AbUD2WNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:13:33 -0400
Message-ID: <40917F1E.8040106@techsource.com>
Date: Thu, 29 Apr 2004 18:18:06 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       akpm@osdl.org, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au>	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>	<20040429133613.791f9f9b.pj@sgi.com>	<409175CF.9040608@techsource.com> <20040429144737.3b0c736b.pj@sgi.com>
In-Reply-To: <20040429144737.3b0c736b.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:
> Timothy wrote:
> 
>>Perhaps nice level could influence how much a process is allowed to 
>>affect page cache.
> 
> 
> I'm from the school that says 'nice' applies to scheduling priority,
> not memory usage.
> 
> I'd expect a different knob, a per-task inherited value as is 'nice',
> to control memory usage.
> 


Linux kernel developers seem to be of the mind that you cannot trust 
what applications tell you about themselves, so it's better to use 
heuristics to GUESS how to schedule something, rather than to add YET 
ANOTHER property to it.

Nick, Con, Ingo, and others have done an impressive job of taking the 
guess/heuristic approach to scheduling.  I don't see why that can't be 
taken further.

Also, there seems to be strong resistance to adding a property to 
something which is not easily accessible through existing UNIX tools. 
"nice" and "renice" commands have been around forever.  Adding another 
control requires new commands, new libc functions, changes to "top", etc.

Besides, when would you want to have a sched-nice of -20 and an io-nice 
of 20, or a sched-nice of 20 and an io-nice of -20?  Things like that 
would make no sense.

