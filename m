Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314051AbSDKNZf>; Thu, 11 Apr 2002 09:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSDKNZe>; Thu, 11 Apr 2002 09:25:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63494 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314051AbSDKNZc>; Thu, 11 Apr 2002 09:25:32 -0400
Date: Thu, 11 Apr 2002 09:22:27 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS access to loopback mounts
In-Reply-To: <2576.1018503672@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.3.96.1020411090957.3677G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Keith Owens wrote:

> Is accessing a loopback mount via NFS supposed to work or not?  If not,
> how do you export iso contents without duplicating the entire iso?
> 
> Machine A.
>   mount -t iso9660 -o ro,loop /foo/iso /mnt/iso
>   /etc/exports contains /mnt *(rw,no_root_squash,no_all_squash)
> 
> Machine B.
>   mount -t nfs A:/mnt/iso /local/iso

> I have a note from April 2000 where NFS access to a loopback mount used
> to work.  Before I dig through two years of kernels to find out where
> it stopped working, is it valid to access loopback via NFS?
> 
> AFAIK doing NFS first then loopback on the local NFS directory has
> never worked.

  I usually export a CD by mounting and exporting that, actually. If you
have the space for the ISO I would think that just copying it from CD to a
hierarchy would take no more space (although if you want to have the ISO
image handy for burning that would take more space).

  Can you export the directory with the ISO image and do a loopback mount
on the client end? haven't tried that, and I'm working on a laptop at the
end of a slow modem this morning, so I'm not able to try it here.

  Oops, I'm wrong, I could ssh into a machine with an NFS directory
containing ISO images, and I did nicely mount one and look at the
contents.

  So to answer your questions, I have no idea why it doesn't work, but you
can get around it if the NFS client is a Linux machine.

  While we're mentioning loopback problems, mounting a CD with loopack and
offset:
  mount -o ro,loop,offset=7480 /dev/cdrom /mnt
used to work and doesn't. I get these CDs all the time with a chunk of
binary data of variable length and an ISO image. Used to work, and I can
mount them on 2.0 and 2.2 systems still. I posted that one before and got
no feedback other than one private E-mail saying that the format was dumb
and I should change it. Since it works for the client and is written by
hardware, LOL.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

