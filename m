Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSCOOnC>; Fri, 15 Mar 2002 09:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292674AbSCOOmw>; Fri, 15 Mar 2002 09:42:52 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:38925 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292666AbSCOOmo>; Fri, 15 Mar 2002 09:42:44 -0500
Date: Fri, 15 Mar 2002 14:42:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
Message-ID: <20020315144237.G24984@flint.arm.linux.org.uk>
In-Reply-To: <20020315142854.E24984@flint.arm.linux.org.uk> <20020315131612.C24984@flint.arm.linux.org.uk> <30439.1016201464@redhat.com> <20020315142854.E24984@flint.arm.linux.org.uk> <1901.1016202759@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1901.1016202759@redhat.com>; from dwmw2@infradead.org on Fri, Mar 15, 2002 at 02:32:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 02:32:39PM +0000, David Woodhouse wrote:
> rmk@arm.linux.org.uk said:
> >  Well, I've tried this approach, Linus rejected it.
> > If you'd like to take up this problem, be my guest. 
> 
> Not really - I also tried already. But I'm disinclined to offer band-aids
> for the brokenness.

I don't know of any Linux kernel that has ever been able to cope with PID1
dying.  I certainly remember facing the PID1 dying causing lockup as far
back as 1.3 kernels, and I even tried to fix it back then.  The argument
put forward for not fixing it is that PID1 should not exit.  Period.

The point here is not that the kernel itself can't cope with PID1 exiting,
but that the code _bypasses_ the protection put into the kernel against
PID1 exiting.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

