Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293486AbSCABln>; Thu, 28 Feb 2002 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310239AbSCABf1>; Thu, 28 Feb 2002 20:35:27 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:36595
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310302AbSCABaS>; Thu, 28 Feb 2002 20:30:18 -0500
Date: Thu, 28 Feb 2002 17:30:56 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020301013056.GD2711@matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020227135001.I1495@inspiron.school.suse.de> <Pine.LNX.3.96.1020228165834.2006D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020228165834.2006D-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 05:11:25PM -0500, Bill Davidsen wrote:
> On Wed, 27 Feb 2002, Andrea Arcangeli wrote:
> 
> > I would like to have feedback about this VM update, if nobody can find
> > any serious issue I'd try to push vm-28 into mainline during 2.4.19pre.
> > Please test oom conditions as well.
> 
> I have enjoyed using your -aa patches (and run child first) for some time,
> and Rik's rmap patches as well. However, I find that for some machines
> your stuff works clearly better, particularly larger memory machines, and
> for some rmap is clearly more responsive, particularly for small machines
> under heavy memory pressure.
> 
> The point is that choice is good, and having two solutions two address
> various machines is a good thing, even if the convenience isn't all that
> great. That being said, I fear that if your solution gets pushed into
> mainline that it will preempt other solutions. And my testing tells me
> that there is no one solution here, even with all the tuning in your VM,
> using the hints you gave me.
> 

The problem here is that currently the mainline kernel makes some bad
dicesions in the VM, and -aa is the solution in this case.  When -aa is
merged, you will still have both solutions; one in mainline, one as a patch
(rmap).

Linus has already changed the VM once in 2.4, and I don't really see another
large VM change (rmap in 2.4) happening again.

Rmap looks promising for a 2.5 merge after several issues are overcome
(pte-highmem, etc).

Mike
