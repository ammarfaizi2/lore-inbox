Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRCGAIT>; Tue, 6 Mar 2001 19:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRCGAIJ>; Tue, 6 Mar 2001 19:08:09 -0500
Received: from jalon.able.es ([212.97.163.2]:31945 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129733AbRCGAH5>;
	Tue, 6 Mar 2001 19:07:57 -0500
Date: Wed, 7 Mar 2001 01:07:34 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Ying Chen <yingchenb@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: threads
Message-ID: <20010307010734.C1132@werewolf.able.es>
In-Reply-To: <F41oVQAiEGKROptzzpY000014a6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <F41oVQAiEGKROptzzpY000014a6@hotmail.com>; from yingchenb@hotmail.com on Wed, Mar 07, 2001 at 00:55:55 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.07 Ying Chen wrote:
> 2. We ran multi-threaded application using Linux pthread library on 2-way 
> SMP and UP intel platforms (with both 2.2 and 2.4 kernels). We see 
> significant increase in context switching when moving from UP to SMP, and 
> high CPU usage with no performance gain in turns of actual work being done 
> when moving to SMP, despite the fact the benchmark we are running is 
> CPU-bound. The kernel profiler indicates that the a lot of kernel CPU ticks 
> went to scheduling and signaling overheads. Has anyone seen something like 
> this before with pthread applications running on SMP platforms? Any 
> suggestions or pointers on this subject?
> 

Too much contention ? How frequently do you create and destroy threads ?
How much frequently do they access shared-writable-data ?
How do you protect them ?

It seems like your system spents more time creating and killing threads
that doing real work.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac13 #3 SMP Wed Mar 7 00:09:17 CET 2001 i686

