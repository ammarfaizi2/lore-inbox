Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286266AbRLJNuI>; Mon, 10 Dec 2001 08:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286265AbRLJNt5>; Mon, 10 Dec 2001 08:49:57 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:39299 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286261AbRLJNtu>; Mon, 10 Dec 2001 08:49:50 -0500
Date: Mon, 10 Dec 2001 08:47:58 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DQl3-00023R-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112100844210.17065-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> >  How does one do the following task: obtain a bunch of free pages (around
> > 300K) with physical addresses between certain bounds (more then
> > 0x4000000, but it is likely this is not constant) reserver them and map to
> > kernel space so that the driver can access them directly ?
> 
> We support allocating pages below 16Mb, below 4Gb, or anywhere within RAM
> on x86. If you want to within a range or your 300K must be a single 300K
> block then you need to allocate it at boot time
> 

It does not have to be contiguous. I was thinking of simply starting with 
the smallest address and trying to free the pages until the needed amount 
is available. But I have no idea how to properly do locking or force the
page to be swapped out or something. 

As for doing this during boot time this does not seem like a good idea for
two reasons: 
  a) I need at least _two_ buffers 300K each
  b) the actual amount of RAM needed changes depending on video standard
     (this is for video capture).

                     thanks

                            Vladimir Dergachev

