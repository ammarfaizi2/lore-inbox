Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286434AbRLTWfi>; Thu, 20 Dec 2001 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286430AbRLTWea>; Thu, 20 Dec 2001 17:34:30 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:42171 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S286423AbRLTWeU>;
	Thu, 20 Dec 2001 17:34:20 -0500
Date: Fri, 21 Dec 2001 09:30:27 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Robert Love <rml@tech9.net>
Cc: mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        billh@tierra.ucsd.edu, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011221093027.A24398@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <Pine.LNX.4.33.0112201101580.2464-100000@localhost.localdomain> <1008872459.2777.10.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008872459.2777.10.camel@phantasy>; from rml@tech9.net on Thu, Dec 20, 2001 at 01:20:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 01:20:55PM -0500, Robert Love <rml@tech9.net> wrote:
| On Thu, 2001-12-20 at 05:18, Ingo Molnar wrote:
| > there are two possibilities i can think of:
| > 1) lets get Ben's patch in but do *not* export the syscalls, yet.
| 
| This is an excellent way to give aio the testing and exposure Linus
| wants without getting into the commitment / syscall mess.
| Stick aio in the kernel, play with it via Tux, etc.  The really
| interested can add temporary syscalls.  aio (which I like, btw) will get
| testing and in time, once proven, we can add the syscalls.
| Comments?

Only that it would be hard for user space people to try it - does Ben's
patch (with hypothetical syscalls) present the POSIX async interfaces out
of the box? If not, testing with in-kernel things is sufficient. But
if it does then it becomes more reasonable to transiently define some
syscall numbers (high up, in some defined as "testing and like shifting
sands" range) so user space can test the interface.

Thought: is there a meta-syscall in the kernel API for calling other syscalls?
You could have such a beast taking negative numbers for experimental calls...
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Sometimes the only solution is to find a new problem.
