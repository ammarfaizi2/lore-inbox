Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286949AbSAIOvd>; Wed, 9 Jan 2002 09:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSAIOvX>; Wed, 9 Jan 2002 09:51:23 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:45587 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286949AbSAIOvP>; Wed, 9 Jan 2002 09:51:15 -0500
Message-ID: <3C3C58E0.EB1333F0@redhat.com>
Date: Wed, 09 Jan 2002 14:51:12 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <000a01c19917$0b567ec0$0501a8c0@psuedogod>; from ed.sweetman@wmich.edu on Wed Jan 09 2002 at 09:07:55AM -0500 <20020109152717.J1543@inspiron.school.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Jan 09, 2002 at 09:07:55AM -0500, Ed Sweetman wrote:
> > Ok so the medicine is worse than the disease.   I take it that you only want
> > some key points made for rescheduling instead of the full preempt patch by
> > Robert.   That seems logical enough.   The only issue i see is that for the
> 
> My ideal is to have the kernel to be as low worst latency as -preempt,
> but without being preemptive. that's possible to achieve, I don't think
> we're that far.
> 
> mean latency is another matter, but I personally don't mind about mean
> latency and I much prefer to save cpu cycles instead.

hear hear!

The akpm patch is achieving a MUCH better latency than pure -preempt,
and only has 40 
or so coded preemption points instead of a few hundred (eg every
spin_unlock).... 

and if with 40 we can get <= 1ms then everybody will be happy; if you
want, say, 50 usec
latency instead you need RTLinux anyway. With 1ms _worst case_ latency
the "mean" latency 
is obviously also very good.......
