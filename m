Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265109AbSJROP7>; Fri, 18 Oct 2002 10:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265110AbSJROP7>; Fri, 18 Oct 2002 10:15:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6410 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265109AbSJROP6>; Fri, 18 Oct 2002 10:15:58 -0400
Date: Fri, 18 Oct 2002 15:21:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jbradford@dial.pipex.com
Cc: _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.5 and lowmemory boxens
Message-ID: <20021018152155.A5437@flint.arm.linux.org.uk>
References: <E182V29-000Pfa-00@f15.mail.ru> <200210181154.g9IBsG2A001135@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210181154.g9IBsG2A001135@darkstar.example.net>; from jbradford@dial.pipex.com on Fri, Oct 18, 2002 at 12:54:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 12:54:15PM +0100, jbradford@dial.pipex.com wrote:
> >  the one problem was the ppp over serial not working, but i suspect
> >  that it just needs to be recompiled with 2.5 headers (am i right?).
> 
> I have found that 16450-based serial ports are unreliable under
> 2.5.x.  Enabling interrupt un-masking didn't help, and I suspect that
> it is just the generally more bloated kernel making the cache, (or in
> the case of a 386, the pre-fetch unit :-) ), less efficient, and
> causing data to be lost.

Well, finding the cause of this is going to be such a pain in the ass.
With the major IDE change after the serial code went in 2.5, there is
no one kernel I can say "could you try to see what effect that kernel
has" to narrow it down to whether it is really due to the new serial
or due to other changes elsewhere.

You seem to imply that you loose received characters when you get IDE
activity.  It would be nice to find out if how old serial + new IDE or
new serial + old IDE behave.  (Such kernels do not exist.)  Unfortunately,
neither is possible without lots of work, and there presently aren't
enough hours in the day to put together such kernels without co-operation
of other kernel developers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

