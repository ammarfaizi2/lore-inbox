Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLGNGV>; Thu, 7 Dec 2000 08:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbQLGNGL>; Thu, 7 Dec 2000 08:06:11 -0500
Received: from [62.172.234.2] ([62.172.234.2]:59282 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129655AbQLGNFv>;
	Thu, 7 Dec 2000 08:05:51 -0500
Date: Thu, 7 Dec 2000 12:36:46 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microsecond accuracy
In-Reply-To: <Pine.GSO.4.10.10012071337530.7874-100000@athena.ics.forth.gr>
Message-ID: <Pine.LNX.4.21.0012071233420.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How about TSC? I know this has disadvantages such as:

a) not all machines have TSC

b) not all machines that claim to have TSC have a usable one.

c) on SMP the kernel makes a best effort to synchronize TSC but this may
or may not be guaranteed

d) you still need a userspace implementation to correctly map TSC cycles
to (micro)seconds using various MHz-specific ratios/whatever. I think
someone I know has already done this work but will let him speak if he
wants to release this to public or not.

other than the above, TSC (rdtsc instruction) is perfectly available to
userspace applications without special privileges. And it is 64bit so it
won't easily wrap around...

regards,
Tigran.

On Thu, 7 Dec 2000, Kotsovinos Vangelis wrote:

> 
> Is there any way to measure (with microsecond accuracy) the time of a
> program execution (without using Machine Specific Registers) ?
> I've already tried getrusage(), times() and clock() but they all have
> 10 millisecond accuracy, even though they claim to have microsecond
> acuracy.
> The only thing that seems to work is to use one of the tools that measure
> performanc through accessing the machine specific registers. They give you
> the ability to measure the clock cycles used, but their accuracy is also
> very low from what I have seen up to now.
> 
> Thank you very much in advance
> 
> --) Vangelis
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
