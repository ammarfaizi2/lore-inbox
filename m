Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315570AbSENJ3K>; Tue, 14 May 2002 05:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315572AbSENJ3J>; Tue, 14 May 2002 05:29:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59917 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315570AbSENJ3I>; Tue, 14 May 2002 05:29:08 -0400
Date: Tue, 14 May 2002 10:29:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: rpm <rajendra.mishra@timesys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ADS GCP reboots when running the application!
Message-ID: <20020514102901.A17054@flint.arm.linux.org.uk>
In-Reply-To: <200205131138.g4DBcU526690@localhost.localdomain> <20020513173714.F6024@flint.arm.linux.org.uk> <200205140911.g4E9B7624219@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 02:41:06PM +0530, rpm wrote:
> On Monday 13 May 2002 10:07 pm, Russell King wrote:
> > No such thing on ARMs.  If you take a fault while handling one, you
> > re-enter the fault handler - you don't reboot.
>   
> What if the fault handler does a fault  ( like seg fault in seg fault handler 
> )  , cause in i386, i remember such a situation causes a processor reboot as  
> it becomes a infinite loop !

You're right in the x86 case, but wrong in the ARM case - you just take a
fault after fault after fault (and you'll either end up overwriting the
kernel or something else of that nature).

> so i conclude that the system crashes in brk() sys call !

strace would print 'brk(' on entry to the syscall though.

> If you can point out  the cases where the kernel reboots without showing
> any message ,   then it will be easier to debug for me!

Well, if I knew of any, they'd get removed/fixed pretty damned fast.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

