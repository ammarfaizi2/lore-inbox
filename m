Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284809AbRLURDj>; Fri, 21 Dec 2001 12:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284810AbRLURDa>; Fri, 21 Dec 2001 12:03:30 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38383 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284809AbRLURDV>;
	Fri, 21 Dec 2001 12:03:21 -0500
Date: Fri, 21 Dec 2001 09:00:15 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011221090014.A1103@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <87y9jxzg5q.fsf@fadata.bg> <Pine.LNX.4.40.0112201453390.1622-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112201453390.1622-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Thu, Dec 20, 2001 at 02:57:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:57:55PM -0800, Davide Libenzi wrote:
> On 21 Dec 2001, Momchil Velikov wrote:
> >
> > I'd like to second that, IMHO the RT task scheduling should trade
> > throughput for latency, and if someone wants priority inversion, let
> > him explicitly request it.
> 
> No a great performance loss anyway. It's zero performance loss if the CPU
> that has ran the woke up RT task for the last time is not running another
> RT task ( very probable ). If the last CPU of the woke up task is running
> another RT task a CPU discovery loop ( like the current scheduler ) must
> be triggered. Not a great deal anyway.

Some time back, I asked if anyone had any RT benchmarks and got
little response.  Performance (latency) degradation for RT tasks
while implementing new schedulers was my concern.  Does anyone
have ideas about how we should measure/benchmark this?  My
'solution' at the time was to take a scheduler heavy benchmark
like reflex, and simply make all the tasks RT.  This wasn't very
'real world', but at least it did allow me to compare scheduler
overhead in the RT paths of various scheduler implementations.

-- 
Mike
