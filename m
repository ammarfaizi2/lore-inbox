Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289984AbSAKPYG>; Fri, 11 Jan 2002 10:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSAKPX5>; Fri, 11 Jan 2002 10:23:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18697 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289984AbSAKPXi>; Fri, 11 Jan 2002 10:23:38 -0500
Date: Fri, 11 Jan 2002 15:23:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H5
Message-ID: <20020111152332.C31366@flint.arm.linux.org.uk>
In-Reply-To: <20020111145811.B31366@flint.arm.linux.org.uk> <E16P3W4-0007vd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16P3W4-0007vd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 11, 2002 at 03:22:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 03:22:48PM +0000, Alan Cox wrote:
> > Unfortunately it wasn't a simple "replace global irq with spinlocks" - some
> > code also got moved around so its not clear that the problem was fixed by
> > the spinlocks or the code reordering.  I'd rather know which it was.
> 
> The code re-ordering fixes the bug. The spinlocks are an unrelated change
> that belong in a seperate diff.

This is at odds with the evidence at present:

| I'll give it a try, but from what I experienced in those days was that
| adding the _spinlock protection_ finally solved all.

He tried 2.4.17 without patch which locked up, and then he tried 2.4.17
with the patch, which didn't.  Unfortunately it contains both the reordering
and the spinlocking.

I'm trying to work with him at the moment to find out which change fixed
the problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

