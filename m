Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310141AbSCKPEC>; Mon, 11 Mar 2002 10:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSCKPDw>; Mon, 11 Mar 2002 10:03:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310141AbSCKPDr>; Mon, 11 Mar 2002 10:03:47 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 11 Mar 2002 15:19:05 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C8CA5D8.50203@evision-ventures.com> from "Martin Dalecki" at Mar 11, 2002 01:40:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kRZp-0000or-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    in replacements for CF cards in digital cameras and I would rather expect
>    them to be very tolerant about the driver in front of them. And then 

Oh dear me. Wrong again. Microdrives require proper polite wakeups. But you
see camera vendors buy in IDE code from people who can read and follow 
standards documents. 

> the WB
>    caches of IDE devices are not caches in the sense of a MESI cache, 
> they are
>    more like buffer caches and should therefore flush them self after s 
> short
>    period of inactivity without the application of any special flush 
> command.

You now have an absolute vote of *NO CONFIDENCE* on my part. I'm simply
not going to consider running your code. "It probably wont eat your disk"
and handwaving is not how you write a block layer.

How is anyone supposed to debug file system code in 2.5 when its known
that it will trash data on some disks anyway ? I'd like to see you cite
a paragraph where the IDE device is required to flush the data back
promptly, or on power off. I'd like to see what you plan to do about all
the IBM disks you plan to mistreat and give bad blocks that require a 
reformat ?

Alan
