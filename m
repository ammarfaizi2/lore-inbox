Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSHEMl5>; Mon, 5 Aug 2002 08:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318433AbSHEMl5>; Mon, 5 Aug 2002 08:41:57 -0400
Received: from odeon.net ([63.229.205.185]:43173 "HELO titan.odeon.net")
	by vger.kernel.org with SMTP id <S318432AbSHEMl4>;
	Mon, 5 Aug 2002 08:41:56 -0400
Date: Mon, 5 Aug 2002 07:45:26 -0500 (CDT)
From: "Robert A. Hayden" <rhayden@geek.net>
X-X-Sender: <rhayden@titan.odeon.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 crashdump - P4/3ware/NFS
In-Reply-To: <Pine.NEB.4.44.0208051104300.27501-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0208050736080.2100-100000@titan.odeon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Adrian Bunk wrote:

> - Does this problem still exist in 2.4.19?
> - Are there temperature problems inside your machine?
> - Does your power supply give your system enough energy?
> - You can test your memory using memtest86 [1].
> - Is there anything in the logfiles after the machine "mysteriously
>   rebooted"?
> - If none of the above helps, could you type the information of the
>   screenshot (best the information if it happens using 2.4.19) to a file
>   and run it through ksymoops?

Adrian et al,

I thought it might have been heat-related (4 120GB drives get very hot) so
I added two high-volume fans to the case.  While it did lower the
motherboard temp about 8 degrees F, the system still froze up doing both
NFS and Samba xfers.

The power supply is a 400w, so it should be able to handle 4 hard drives
and a P4 ok.

There was never anything in any of the logfiles to indicate much of
anything.

When 2.4.19 came out Friday, I noticed in the changelog several references
to both the 3ware drivers as well as the SiS chipset, which my motherboard
uses (ECS).  Since upgrading to 2.4.19 the system has been rock-solid
steady.  I've been stress-testing it for about 72 hours now, copying 10
2GB files across to /dev/null over NFS in a rotation, as well as moving
about 100GB of production data over NFS and not even so much as a hiccup.

The result: I think whatever problem there was has been fixed.  I'm
guessing that it was SiS-related, as I've been using 3ware controllers for
a couple years with never so much as even a hiccup.  I am going to
continue running my stress-test over the rest of the week to be sure, but
so far so good.

Nice to see a kernel change fix the problem.  I was already pricing out a
replacement motherboard.

