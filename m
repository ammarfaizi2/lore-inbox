Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSJPF5Q>; Wed, 16 Oct 2002 01:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSJPF5Q>; Wed, 16 Oct 2002 01:57:16 -0400
Received: from [203.117.131.12] ([203.117.131.12]:41900 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264885AbSJPF5P>; Wed, 16 Oct 2002 01:57:15 -0400
Message-ID: <3DAD0118.80807@metaparadigm.com>
Date: Wed, 16 Oct 2002 14:03:04 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: J Sloan <joe@tmsusa.com>, Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <1034710299.1654.4.camel@localhost.localdomain>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>	 <3DACEB6E.6050700@metaparadigm.com>  <3DACEC85.3020208@tmsusa.com> <1034743416.29307.11.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/02 12:43, GrandMasterLee wrote:
> My Dell 6650 has been doing this exact behaviour since we got on 5.38.9
> and up, using LVM in a production capacity. Both servers we have, have
> crashed mysteriously, without any kernel dump, etc, but all hardware
> diags come out clean.

I tell you my honest hunch - remove LVM and try again. This has made
my life a little more peaceful lately. Even with a 2-3 minute outages
while our cluster automatically fails over - the 100's of users whining
about their sessions being disconnected makes you a bit depressed.

> All hardware configuration bits are perfect, as can be anyway, and we
> still get this behaviour. After 5-6.5 days...the box black screens. So
> bad so, that all the XFS volumes we have, never enter a shutdown. We
> must repair them all, today this happened, and we lost one part of the
> tablespace on our beta db. We're using LVM1, on 2.4.19-aa1.

We had the black screen also until we got the machines oopsing over
serial. The oops was actually showing up in ext3 with a corrupted
bufferhead. Without LVM, i've measured my longest uptime, 17 days x
4 machines in the cluster (68 days) ie. we only did it 17 days ago.

~mc


> 
> 
> 
> 
> On Tue, 2002-10-15 at 23:35, J Sloan wrote:
> 
>>Just to make sure we are on the same page,
>>was that LVM1, LVM2, or EVMS?
>>
>>Joe
>>
>>Michael Clark wrote:
>>
>>
>>>I doubt it will make a difference. LVM and qlogic drivers seem
>>>to be a bad mix. I've already tried the beta5 of 6.01
>>>and same problem exists - ooops about every 5-8 days.
>>>Removing LVM and solved the problem.

