Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315096AbSDWHR2>; Tue, 23 Apr 2002 03:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315097AbSDWHR1>; Tue, 23 Apr 2002 03:17:27 -0400
Received: from ns.suse.de ([213.95.15.193]:39698 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315096AbSDWHR0>;
	Tue, 23 Apr 2002 03:17:26 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <3CC4861C.F21859A6@mvista.com.suse.lists.linux.kernel> <E16zuPf-0007yD-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Apr 2002 09:17:25 +0200
Message-ID: <p73g01m994q.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > The problem is in accounting (or time slicing if you prefer) where we
> > need to start a timer each time a task is context switched to, and stop
> > it when the task is switched away.  The overhead is purely in the set up
> > and tear down.  MOST of these never expire.
> 
> Done properly on many platforms a variable tick is very very easy and also
> very efficient to handle. X86 is a paticular problem case because the timer
> is so expensive to fiddle with

Depends. On modern x86 you can either use the local APIC timer or
the mmtimers (ftp://download.intel.com/ial/home/sp/mmts097.pdf - 
should be in newer x86 chipsets). Both should be better than the 
8254 timer and are also not expensive to work with. 

-Andi
