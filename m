Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSCGIsx>; Thu, 7 Mar 2002 03:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSCGIsn>; Thu, 7 Mar 2002 03:48:43 -0500
Received: from are.twiddle.net ([64.81.246.98]:37274 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S286647AbSCGIsb>;
	Thu, 7 Mar 2002 03:48:31 -0500
Date: Thu, 7 Mar 2002 00:48:21 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Message-ID: <20020307004821.A26624@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
	david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
	frankeh@watson.ibm.com
In-Reply-To: <E16hjZY-0001AV-00@wagner.rustcorp.com.au> <20020306175203.A26064@twiddle.net> <20020307143947.000f51dd.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020307143947.000f51dd.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Thu, Mar 07, 2002 at 02:39:47PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 02:39:47PM +1100, Rusty Russell wrote:
> But since the real problem here is "lock held forever", so I don't care.

No, "lock held forever" merely makes the example trivial.  
"Lock held for a while" is the real problem.

> > You really do need that cmpxchg loop.
> 
> Well, not decrementing if count < 0 already also works

How, exactly, are you planning on doing that atomically?
Clue: 386 SMP requires an extra spinlock.

> PS. Will Alpha have to do any special magic with the mmap PROT_SEM flag?

No.


r~
