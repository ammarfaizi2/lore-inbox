Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUJIQg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUJIQg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 12:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUJIQg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 12:36:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:40404 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267164AbUJIQg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 12:36:56 -0400
Subject: Re: Inconsistancies in /proc (status vs statm) leading to
	wrong	documentation (proc.txt)
From: Albert Cahalan <albert@users.sf.net>
To: eric.valette@free.fr
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4167F0D7.3020502@free.fr>
References: <1097329771.2674.4036.camel@cube>  <4167F0D7.3020502@free.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1097339477.2669.4212.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Oct 2004 12:31:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 10:08, Eric Valette wrote:
> Albert Cahalan wrote:
> 
> > The documentation is incorrect. It was written to match a buggy
> > implementation in early 2.6.x kernels.
> 
> Well the Documentation is said to matches 2.6.8-rc3 and is only 5 weeks 
> old according to bitkeeper changesets... So at least the doc should be 
> fixed.

Removal would be simpler.

> > VmSize is the address space occupied, excluding memory-mapped IO.
> > The statm value is the address space occupied.
> 
> Why removing memory-mapped IO in one case (status) and not the other 
> (statm)? Memory mapped IO, may of course reserve some physical memory 
> pages for establishing the mmu->phys adress translation table (if any) 
> but not really the amount of space mapped.

First of all, because that's the way it's been done.
This interface goes back to the Linux 1.0.xx days.

Second of all, because you get more information this
way. You can subtract to determine the address space
used for IO alone.

I could go for another number: available address space.
Then I could display percent used.

> >>May I suggest :
> >> - To use consistent memory size units between status and statm,
> 
> > No way. This would instantly break the "top" program.
> 
> OK. Too bad because statm is hardly readable but I guess it is not for 
> human then...

Even the other files are only partly for humans.
Minor changes will cause many tools to break.


