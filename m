Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271124AbRHYIKC>; Sat, 25 Aug 2001 04:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272392AbRHYIJw>; Sat, 25 Aug 2001 04:09:52 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:38283 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271124AbRHYIJp>; Sat, 25 Aug 2001 04:09:45 -0400
Date: Sat, 25 Aug 2001 09:09:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: What version of the kernel fixes these VM issues?
Message-ID: <20010825090959.A2561@flint.arm.linux.org.uk>
In-Reply-To: <20010824222924Z16116-32383+1243@humbolt.nl.linux.org> <Pine.LNX.4.33.0108241940280.25240-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108241940280.25240-100000@xanadu.home>; from nico@cam.org on Fri, Aug 24, 2001 at 11:00:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 11:00:05PM -0400, Nicolas Pitre wrote:
> 6 page tables cached

Although this won't help the basic problem, there could me as much as 100K
cached in those page tables.  I wonder if we could hook the pgt cache into
the VM cache shrinking, so we can free most, if not all of this cache
(rather than it being in the idle loop only).

I'll look into it, produce a patch, but I'm not a VM hacker.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

