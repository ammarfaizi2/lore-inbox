Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132740AbRDKSTA>; Wed, 11 Apr 2001 14:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132716AbRDKSSt>; Wed, 11 Apr 2001 14:18:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132728AbRDKSSk>; Wed, 11 Apr 2001 14:18:40 -0400
Message-ID: <3AD49FE1.D609E032@transmeta.com>
Date: Wed, 11 Apr 2001 11:18:09 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: announce: PPSkit patch for Linux 2.4.2 (pre6)
In-Reply-To: <E14nOy5-0007Ei-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > appropriately.)  One could, at least theoretically, make them usable
> > in kernel space only (in user space there is no hope, since you can't
> > know which CPU's TSC you're reading), but these machines seem to be so
> > rare that hardly anyone technical enough to fix it cares.
> 
> Im working on making the 'notsc' automatic. Trying to 'fix' it is just plain
> hard work. With the fixed one however we can still use the tsc for udelay
> as we have per cpu loops_per_jiffy data.
> 
> This btw is why -ac figures out the bus multiplier on your processors. If they
> dont match then we know tsc wants to be off. Just nobody has written the code
> to disable it across all CPUs yet
> 

Yes, there are two cases where we can "fix" it: in the timer interrupt
code, and the loops_per_jiffy stuff.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
