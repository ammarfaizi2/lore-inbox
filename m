Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTBTUOR>; Thu, 20 Feb 2003 15:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTBTUOQ>; Thu, 20 Feb 2003 15:14:16 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17861 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266944AbTBTUOO>; Thu, 20 Feb 2003 15:14:14 -0500
Date: Thu, 20 Feb 2003 12:23:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous	reboots)
Message-ID: <6220000.1045772628@[10.10.2.4]>
In-Reply-To: <1045776104.3790.34.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com> <1045776104.3790.34.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ok, the 4kB stack definitely won't work in real life, but that's because 
>> we have some hopelessly bad stack users in the kernel. But the debugging 
>> part would be good to try (in fact, it might be a good idea to keep the 
>> 8kB stack, but with rather anal debugging. Just the "mcount" part should 
>> do that).
> 
> You also need IRQ stacks to get down to 4K. The wrong pattern of ten
> different IRQ handlers using a mere 200 bytes each will eventually
> happen and eventually kill you otherwise.

That's in Dave's patchset, and 4K stacks is a config option for now.

M.

