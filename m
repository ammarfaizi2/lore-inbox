Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRCNNVA>; Wed, 14 Mar 2001 08:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRCNNUu>; Wed, 14 Mar 2001 08:20:50 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:23045 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131348AbRCNNUf>;
	Wed, 14 Mar 2001 08:20:35 -0500
Date: Wed, 14 Mar 2001 14:19:44 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <20010314141944.A27572@pcep-jamie.cern.ch>
In-Reply-To: <20010309210913.F13320@pcep-jamie.cern.ch> <Pine.LNX.4.33.0103100154310.2283-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103100154310.2283-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Mar 10, 2001 at 01:56:41AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> > reschedule:
> > 	orl $PF_HONOUR_LOW_PRIORITY,flags(%ebx)
> > 	call SYMBOL_NAME(schedule)    # test
> > 	andl $~PF_HONOUR_LOW_PRIORITY,flags(%ebx)
> > 	jmp ret_from_sys_call
> 
> Wonderful !
> 
> I think we'll want to use this, since we can use it for:
> 
> 1. SCHED_IDLE
> 2. load control, when the VM starts thrashing we can just
>    suspend a few processes to make sure the system as a
>    whole won't thrash to death

Surely it would be easier, and more appropriate, to make the processes
sleep when they next page fault.

-- Jamie
