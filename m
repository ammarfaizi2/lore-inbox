Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272360AbRH3Reh>; Thu, 30 Aug 2001 13:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272361AbRH3Re2>; Thu, 30 Aug 2001 13:34:28 -0400
Received: from smtp5.us.dell.com ([143.166.83.100]:42764 "EHLO
	smtp5.us.dell.com") by vger.kernel.org with ESMTP
	id <S272360AbRH3ReN>; Thu, 30 Aug 2001 13:34:13 -0400
Date: Thu, 30 Aug 2001 12:34:31 -0500 (CDT)
From: Michael E Brown <michael_e_brown@dell.com>
X-X-Sender: <mebrown@blap.linuxdev.us.dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <Pine.LNX.4.33.0108301306300.12593-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108301226260.1213-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Ben LaHaise wrote:

> No, that's not what's got me miffed.  What is a problem here is that an
> obvious next to use ioctl number in a *CORE* kernel api was used without
> reserving it.  AND PEOPLE SHIPPED IT!  I for one don't go about shipping
> new ABIs without reserving at least a placeholder for it in the main
> kernel (or stating that the code is not bearing a fixed ABI).  If the
> ioctl # was in the main kernel, this mess would never have happened even
> with the accidental shipping of the patch in e2fsprogs.  I just hope
> people will remember this in the future.  ABI compatibility is not that
> hard if it's thought about.

Ok. I can agree with that. As a junior kernel hacker, I did not know about
this issue, and I agree that somebody with a bit more experience should
have reserved the next number. Sorry :-(

But, since I've gone through this ioctl reservation conflict twice now
(e2fsprogs and something having to do with XFS), I think this is a more
general problem.

As a side note, a copy of the second edition of "Linux Device Drivers" I
am using doesn't mention this idea of reserving ioctl numbers.

-- 
Michael Brown
Linux OS Development
Dell Computer Corp

  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.


