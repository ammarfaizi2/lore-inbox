Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSCHWy7>; Fri, 8 Mar 2002 17:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291214AbSCHWys>; Fri, 8 Mar 2002 17:54:48 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:33017 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291088AbSCHWyc>; Fri, 8 Mar 2002 17:54:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Fri, 8 Mar 2002 17:55:20 -0500
X-Mailer: KMail [version 1.3.1]
Cc: rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org
In-Reply-To: <E16jRAU-0007QU-00@the-village.bc.nu>
In-Reply-To: <E16jRAU-0007QU-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020308225425.772D13FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 03:40 pm, Alan Cox wrote:
> > So I would suggest making the size (and thus alignment check) of locks at
> > least 8 bytes (and preferably 16). That makes it slightly harder to put
> > locks on the stack, but gcc does support stack alignment, even if the
> > code sucks right now.
>
> Can we go to cache line alignment - for an array of locks thats clearly
> advantageous

NO and let me explain.

I would to be able to integrate the lock with the data.
This is much more cache friendly then putting the lock on a different 
cacheline.

If you want an array you need to pad each element. 
That's easy enough to do....
Can't shrink a datastructure on the other hand :-)

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
