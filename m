Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289779AbSAJXiE>; Thu, 10 Jan 2002 18:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289780AbSAJXho>; Thu, 10 Jan 2002 18:37:44 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:45142 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S289779AbSAJXhi>; Thu, 10 Jan 2002 18:37:38 -0500
Date: Thu, 10 Jan 2002 23:29:24 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
        andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020110231849.GA28945@kroah.com>
Message-ID: <Pine.LNX.3.96.1020110232055.7473C-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Greg KH wrote:
> So on to the requirements:
>   1) portable
>      This is still true.
>      
>      dietlibc and uClibc currently do not cover the
>      range of platforms that this code must run on.  For either of them
>      to be used, they must be worked on.

FWIW we (at Axis) run both uClibc and glibc for embedded Linux products,
and both work fine but obviously with different target compromises wrgds
to memory footprints, speed of porting etc. uClibc works fine with a
majority of programs relevant to us, not just a small list of useful
tools.

We have an arch/cris port of uClibc, which could be merged with the
official branch at some point.

>   3) dynamic version available
>      Probably not true anymore.
>      In talking with lots of people, and playing with the dynamic
>      linking capabilities of different libraries, I don't think this is
>      worth having as a requirement for this kind of library.

uClibc seem to work fine shared, that's how I've ran it for a while now.
When doing a "complete" linux system in 2 MB flash to put in a product,
every shared byte possible is worth to put some time on :) Granted, if the
goal is just to compile 10 small tools it might not be very useful but
since it's not that difficult to support it, and you're making yet another
libc, why not keep it flexible.

> How about responses from the dietlibc and uClibc people on the odds of
> them being able to port to the remaining platforms?

I'm sorry I must have missed why yet another libc was needed in the first
place :)

/BW


