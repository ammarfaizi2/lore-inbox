Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSHAR5q>; Thu, 1 Aug 2002 13:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSHAR5q>; Thu, 1 Aug 2002 13:57:46 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:27645 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316199AbSHAR5p>; Thu, 1 Aug 2002 13:57:45 -0400
Date: Thu, 1 Aug 2002 14:01:12 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020801140112.G21032@redhat.com>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Aug 01, 2002 at 09:30:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 09:30:04AM -0700, Linus Torvalds wrote:
> Absolutely. I think "jiffies64" is fine (as long as is it converted to
> some "standard" time-measure like microseconds or nanoseconds so that
> people don't have to care about internal kernel state) per se.

Hmmm, it almost sounds like implementing clock_gettime as a syscall and 
exporting jiffies as CLOCK_MONOTONIC is the way to go, as that gives a 
nanosecond resolution export of jiffies.  Then, it would make sense to 
use that as the basis for "when" timeouts.  Relative timeouts still have 
a certain simplicity to them that is appealing, though.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
