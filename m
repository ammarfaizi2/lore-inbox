Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286456AbRLTWqk>; Thu, 20 Dec 2001 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286455AbRLTWqd>; Thu, 20 Dec 2001 17:46:33 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:19246 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286448AbRLTWqT>; Thu, 20 Dec 2001 17:46:19 -0500
Date: Thu, 20 Dec 2001 17:46:16 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Cameron Simpson <cs@zip.com.au>
Cc: Robert Love <rml@tech9.net>, mingo@elte.hu,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, billh@tierra.ucsd.edu,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220174616.F6276@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112201101580.2464-100000@localhost.localdomain> <1008872459.2777.10.camel@phantasy> <20011221093027.A24398@zapff.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011221093027.A24398@zapff.research.canon.com.au>; from cs@zip.com.au on Fri, Dec 21, 2001 at 09:30:27AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 09:30:27AM +1100, Cameron Simpson wrote:
> Only that it would be hard for user space people to try it - does Ben's
> patch (with hypothetical syscalls) present the POSIX async interfaces out
> of the box?

No.  POSIX aio does not have any concept of a completion queue.  Completion 
in POSIX aio comes via a thread callback, signal delivery or polling, all 
of which are horrendously inefficient.

> If not, testing with in-kernel things is sufficient. But
> if it does then it becomes more reasonable to transiently define some
> syscall numbers (high up, in some defined as "testing and like shifting
> sands" range) so user space can test the interface.

Maybe.  The unfortunate aspect to this is that you can't tell if a number 
matches the name you expect it to be, and invariably people end up running 
the wrong code on the wrong kernel.  Or vendors start shipping patches to 
enable these new syscalls....

> Thought: is there a meta-syscall in the kernel API for calling other 
> syscalls?  You could have such a beast taking negative numbers for 
> experimental calls...

I'm working on something.  Stay tuned.

		-ben
-- 
Fish.
