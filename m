Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRCMC4y>; Mon, 12 Mar 2001 21:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRCMC4o>; Mon, 12 Mar 2001 21:56:44 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:7182 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S130685AbRCMC42>;
	Mon, 12 Mar 2001 21:56:28 -0500
Date: Mon, 12 Mar 2001 19:56:47 -0700
From: Nathan Paul Simons <npsimons@fsmlabs.com>
To: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
Message-ID: <20010312195647.A32437@fsmlabs.com>
Reply-To: npsimons@fsmlabs.com
In-Reply-To: <Pine.GSO.4.21.0103121324280.25792-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0103122111500.31224-100000@erdos.shef.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103122111500.31224-100000@erdos.shef.ac.uk>; from g.liakhovetski@ragingbull.com on Mon, Mar 12, 2001 at 09:21:37PM +0000
X-Bad-Disk-Header: Do you ever get that syncing feeling?
Organization: Finite State Machine Labs <http://www.fsmlabs.com/>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2001 at 09:21:37PM +0000, Guennadi Liakhovetski wrote:
> CPU utilisation. Each new application has to calculate it (ps, top, qps,
> kps, various sysmons, procmons, etc.). Wouldn't it be worth it having a
> syscall for that? Wouldn't it be more optimal?

	No, it wouldn't be worth it because you're talking about 
sacrificing simplicity and kernel speed in favor of functionality.
This has been know to lead to "bloat-ware".  Every new syscall you
add takes just a little bit more time and space in the kernel, and
when only a small number of programs will be using it, it's really 
not worth it.  This time and space may not be large, but once you
get _your_ syscall added, why can't everyone else get theirs added 
as well?  And so, after making about a thousand specialized syscalls
standard in the kernel, you end up with IRIX (from what I've heard).
	Don't even get me started about opening security holes, and
increasing code complexity.  Please do a search for every other
syscall that has ever been proposed on this list, read them all 
and the arguments for them, then think long and hard about why yours
should be accepted.  Because I'm sure that I'm not the only person
who's going to want a good explanation as to why this syscall is
essential.

ps - CPU time is cheap, that's why they don't charge for it anymore.
Programmer time is _not_.
