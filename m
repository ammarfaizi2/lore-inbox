Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbTD2Oip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 10:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTD2Oip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 10:38:45 -0400
Received: from SPARCLINUX.MIT.EDU ([18.248.2.241]:23812 "EHLO
	sparclinux.mit.edu") by vger.kernel.org with ESMTP id S262025AbTD2Oil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 10:38:41 -0400
Date: Tue, 29 Apr 2003 10:32:44 -0400
From: Rob Radez <rob@osinvestor.com>
To: Schwarzseher <fields35@coolgoose.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.5.68 and SMP on arch/sparc
Message-ID: <20030429143243.GA17387@osinvestor.com>
References: <3EAE7F0E.7080003@coolgoose.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAE7F0E.7080003@coolgoose.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 03:33:02PM +0200, Schwarzseher wrote:
> Hi,
> out whatever reasons I'm currently trying to update a debian 
> installation on an old 2 processor SparcStation 20 clone.
> 
> Unfortunately I run into trouble compiling a 2.5.68 kernel on it. It 
> seems that the inline "cpu_possible" is missing out of 
> include/asm-sparc/smp.h while being existent in include/asm-i386/smp.h 
> and others. A
> Also unfortunately it seems to be needed for compiling successfully. 
> Even more unfortunately I don't have an idea on how to add it (or rather 
> what to add) because I'm not so deeply involved into inner kernel 
> workings or the sparc architecture.

This is a known problem and one that I'm hoping (if no one else gets
around to it) to fix when I get back home and have access to my SMP
sparc to test with.

> 
> I attached the errors below. Am I the only one who tries to ran an 
> actual 2.5 testing kernel on this vintage hardware?

I know for sure that I am, check out http://osinvestor.com/sparc/ for my
sparc32 kernel status page.  I also know for sure that not many other
people are.

> While in this issue (even when it's off topic for this list, so please 
> ignore if you feel insulted): Does anyone have an idea why swapon 
> /dev/sdc2 throws a core since I updated to a (successfully for SMP 
> compiled) 2.4.20 kernel? The swapon syscall is executed and in fact the 
> swapspace is added but afterwards the swapon utility hickups with an 
> segmentation fault... Had a look into the source but didn't understand 
> what may be happening that results into a segfault.

There is a patch going around for this that will hopefully be in the
next stock release.

One note: please e-mail the sparclinux@vger.kernel.org with sparc
specific problems since you're more likely not to get lost in the noise
there.  Also, the list archives at
http://marc.theaimsgroup.com/?l=linux-sparc (or various other places)
hold answers to all sorts of questions.

Regards,
Rob Radez
