Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUEZJd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUEZJd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265381AbUEZJdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:33:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10880 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265373AbUEZJdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:33:19 -0400
Date: Wed, 26 May 2004 10:40:19 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk>
To: Helge Hafting <helgehaf@aitel.hist.no>, orders@nodivisions.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40B45CB7.6010407@aitel.hist.no>
References: <40B43B5F.8070208@nodivisions.com>
 <40B45CB7.6010407@aitel.hist.no>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Helge Hafting <helgehaf@aitel.hist.no>:
> Anthony DiSante wrote:
> 
> > As a general question about ram/swap and relating to some of the 
> > issues in this thread:
> >
> >     ~500 megs cached yet 2.6.5 goes into swap hell
> >
> > Consider this: I have a desktop system with 256MB ram, so I make a 
> > 256MB swap partition.  So I have 512MB "memory" and if some process 
> > wants more, too bad, there is no more.
> >
> > Now I buy another 256MB of ram, so I have 512MB of real memory.  Why 
> > not just disable my swap completely now?  I won't have increased my 
> > memory's size at all, but won't I have increased its performance lots? 
> 
> This is correct. You now have 512M of fast memory instead of
> 256M fast memory and 256M "slow" memory. You don't _need_ to have additional
> swap, but it is usually a good idea.  If you keep your 256M of swap, 
> then you now
> have 512M fast memory + 256M slow memory for a total of 768M.  This is 
> even better.

I strongly disagree on the last point.  It may be better, but it may also
be a lot worse.  Too much swap can be a bad thing - see my example in another
post about run-away processes on remote machines.

> Please note that  your machine _will_ do one kind of swapping even if you
> don't configure any swap: Executable files are a kind of swap-files,
> if memory pressure happens then (part of) your programs will be evicted
> from memory _because_ they can be reloaded from their executables.
> 
> This cause the same sort of performance degradations as swapping to
> a swap partition.  Actually, it is worse because swapping to a swap 
> partition
> allows swapping out little-used writeable memory before discarding
> program code that might see more use.  So if swapping happens, then
> you're better off with a swap partition because then it is the least used
> stuff that goes first. Without a swap partition, the least used program code
> goes, but it may or may not be the least used memory overall.

Again, the user _may_ be better off swapping to a swap partition rather than
having executable code paged out, but this is not necessarily true in all
circumstances.

John.
