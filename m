Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131000AbQKSK7j>; Sun, 19 Nov 2000 05:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131933AbQKSK73>; Sun, 19 Nov 2000 05:59:29 -0500
Received: from slc154.modem.xmission.com ([166.70.9.154]:28938 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S131000AbQKSK61>; Sun, 19 Nov 2000 05:58:27 -0500
To: David Ford <david@linux.com>
Cc: Andrew Park <apark@cdf.toronto.edu>, linux-kernel@vger.kernel.org
Subject: Re: neighbour table?
In-Reply-To: <Pine.LNX.4.21.0011190158480.3036-100000@blue.cdf.utoronto.ca> <3A1779D9.409FB87B@linux.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2000 00:45:17 -0700
In-Reply-To: David Ford's message of "Sat, 18 Nov 2000 22:57:29 -0800"
Message-ID: <m1ofzc4d82.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david@linux.com> writes:

> Andrew Park wrote:
> 
> > I get a message
> >
> >         neighbour table overflow
> >
> > What does that mean?  It seems that
> >
> >         net/ipv4/route.c
> >
> > is the place where it prints this.  But under what circumstances
> > does this happen?
> > Thanks
> 
> It means you set the link state of eth0 up before lo.
> 
> Be sure lo is established before eth0 and you won't see this message.

Hmm.  How does the interaction work.  I've been meaning to track it for
a while but haven't yet.  

>From the cases I have observed it seems to be connected with arp requests
that aren't answered. (I.e when something is misconfigured and you try to nfsroot off
of the wrong ip on your subnet)
And I keep thinking neighbour table underflow would have been a better message.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
