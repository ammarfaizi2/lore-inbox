Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313902AbSDJV77>; Wed, 10 Apr 2002 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313904AbSDJV76>; Wed, 10 Apr 2002 17:59:58 -0400
Received: from pacman.mweb.co.za ([196.2.45.77]:18400 "EHLO pacman.mweb.co.za")
	by vger.kernel.org with ESMTP id <S313902AbSDJV75>;
	Wed, 10 Apr 2002 17:59:57 -0400
Subject: Re: 2.5.8-pre2: preempt: exits with preempt_count 1
From: Bongani <bonganilinux@mweb.co.za>
To: Robert Love <rml@tech9.net>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1018463295.6681.18.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 Apr 2002 00:14:34 +0200
Message-Id: <1018476875.6315.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 20:28, Robert Love wrote:
> On Wed, 2002-04-10 at 08:53, Duncan Sands wrote:
> 
> > error: halt[411] exited with preempt_count 1
> > 
> > This was after about 24 hours of up time.  What can I do to help
> > track down this locking problem?
> 
> It is not a big deal.  The issue is that in the system shutdown code,
> something does not release a lock but just figures "the system is going
> down, what is the point?"  It is probably the BKL ...
> 
> For the sake of code readability and having nothing quit with a nonzero
> preempt_count, we should explicitly drop the lock, but it is not hurting
> anything (now, if you get this message elsewhere, there may be a
> problem).
> 
> I am trying to find what is the cause but I have not tracked it down yet

This is also still happening on 2.4.19-pre6 + preempt 


> ...

> 
> 	Robert Love





> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


