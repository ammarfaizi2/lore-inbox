Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132263AbRAESya>; Fri, 5 Jan 2001 13:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRAESyU>; Fri, 5 Jan 2001 13:54:20 -0500
Received: from tweetie.comstar.net ([130.205.120.2]:55941 "EHLO
	tweetie.comstar.net") by vger.kernel.org with ESMTP
	id <S132783AbRAESyG>; Fri, 5 Jan 2001 13:54:06 -0500
Date: Fri, 5 Jan 2001 13:53:10 -0500 (EST)
From: Gregory McLean <gregm@comstar.net>
To: Christoph Rohland <cr@sap.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-prerelease shmget woes.
In-Reply-To: <m3n1d9wu49.fsf@linux.local>
Message-ID: <Pine.LNX.4.30.0101051352220.26701-100000@tweetie.comstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Jan 2001, Christoph Rohland wrote:

> Gregory McLean <gregm@comstar.net> writes:
> > cat /proc/sys/kernel/shmall
> > 0
>
> That's your problem. Your limit for overall shm pages is zero. So you
> cannot allocate any shm segments.
>
> echo 2000000 > /proc/sys/kernel/shmall
>
> and check /etc/sysctl.conf or wherever your system stores kernel
> parameters to restore on boot.

Yeah for some odd reason RedHack stuffed a 0 in there *grumble*
That fixed it.

>
> Greetings
>                 Christoph
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
