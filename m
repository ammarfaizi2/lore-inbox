Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285927AbRLTDVy>; Wed, 19 Dec 2001 22:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285940AbRLTDVn>; Wed, 19 Dec 2001 22:21:43 -0500
Received: from tierra.ucsd.edu ([132.239.214.132]:34706 "EHLO burn")
	by vger.kernel.org with ESMTP id <S285937AbRLTDVd>;
	Wed, 19 Dec 2001 22:21:33 -0500
Date: Wed, 19 Dec 2001 19:21:05 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: kerndev@sc-software.com, billh@tierra.ucsd.edu, bcrl@redhat.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011219192105.B26007@burn.ucsd.edu>
In-Reply-To: <20011219.184527.31638196.davem@redhat.com> <Pine.LNX.3.95.1011219184950.581H-100000@scsoftware.sc-software.com> <20011219.190629.03111291.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.190629.03111291.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 07:06:29PM -0800
From: Bill Huey <billh@tierra.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 07:06:29PM -0800, David S. Miller wrote:
> Firstly, you say this as if server java applets do not function at all
> or with acceptable performance today.  That is not true for the vast
> majority of cases.
> 
> If java server applet performance in all cases is dependent upon AIO
> (it is not), that would be pretty sad.  But it wouldn't be the first

Java is pretty incomplete in this area, which should be addressed to a
great degree in the new NIO API.

The core JVM isn't dependent on this stuff per se for performance, but
it is critical to server side programs that have to deal with highly
scalable IO systems, largely number of FDs, that go beyond the current
expressiveness of select()/poll().

This is all standard fare in *any* kind of high performance networking
application where some kind of high performance kernel/userspace event
delivery system is needed, kqueue() principally.

> time I've heard crap like that.  There is propaganda out there telling
> people that 64-bit address spaces are needed for good java
> performance.  Guess where that came from?  (hint: they invented java
> and are in the buisness of selling 64-bit RISC processors)

What ? oh god. HotSpot is a pretty amazing compiler and it performs well.
Swing does well now, but the lingering issue in Java is the shear size
of it and possibly GC issues. It pretty clear that it's going to get
larger, which is fine since memory is cheap.

bill

