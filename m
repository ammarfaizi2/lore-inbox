Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbSJPGer>; Wed, 16 Oct 2002 02:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264911AbSJPGer>; Wed, 16 Oct 2002 02:34:47 -0400
Received: from [203.117.131.12] ([203.117.131.12]:59566 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264910AbSJPGeq>; Wed, 16 Oct 2002 02:34:46 -0400
Message-ID: <3DAD09E3.2050602@metaparadigm.com>
Date: Wed, 16 Oct 2002 14:40:35 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: J Sloan <joe@tmsusa.com>, Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <1034710299.1654.4.camel@localhost.localdomain>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>	 <3DACEB6E.6050700@metaparadigm.com>  <3DACEC85.3020208@tmsusa.com>	 <1034743416.29307.11.camel@localhost>  <3DAD0118.80807@metaparadigm.com> <1034749907.2045.15.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/02 14:31, GrandMasterLee wrote:
> On Wed, 2002-10-16 at 01:03, Michael Clark wrote:
> 
>>On 10/16/02 12:43, GrandMasterLee wrote:
>>
[snip]
>>>All hardware configuration bits are perfect, as can be anyway, and we
>>>still get this behaviour. After 5-6.5 days...the box black screens. So
>>>bad so, that all the XFS volumes we have, never enter a shutdown. We
>>>must repair them all, today this happened, and we lost one part of the
>>>tablespace on our beta db. We're using LVM1, on 2.4.19-aa1.
>>
>>We had the black screen also until we got the machines oopsing over
>>serial. The oops was actually showing up in ext3 with a corrupted
>>bufferhead. Without LVM, i've measured my longest uptime, 17 days x
>>4 machines in the cluster (68 days) ie. we only did it 17 days ago.
> 
> I believe you, that was my next thought, but I didn't know if that would
> really help just to be honest. Thanks for the input there. 
> 
> I've been going crazy trying to catch any piece of sanity out of this
> thing to understand if this was what was happening or not. I feel a bit
> dumb for not trying serial console yet, but I knew either that or KDB
> should tell us something. I will see what we can do, it will take less
> time to do this, than to reload everything all over again.
> 
> Should I remove LVM all together, or just not use it? In your opinion.

I just didn't load the module after migrating my volumes. If the problem
is a stack problem, then its probably not necessarily a bug in LVM
- just the combination of it, ext3 and the qlogic driver don't mix well
- so if its not being used, then it won't be increasing the stack footprint.

~mc

