Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317542AbSFRSfP>; Tue, 18 Jun 2002 14:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSFRSfO>; Tue, 18 Jun 2002 14:35:14 -0400
Received: from web12302.mail.yahoo.com ([216.136.173.100]:18037 "HELO
	web12302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317542AbSFRSfN>; Tue, 18 Jun 2002 14:35:13 -0400
Message-ID: <20020618183515.13963.qmail@web12302.mail.yahoo.com>
Date: Tue, 18 Jun 2002 11:35:15 -0700 (PDT)
From: Myrddin Ambrosius <imipak@yahoo.com>
Subject: Re: Drivers, Hardware, and their relationship to Bagels.
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020618111156.3808B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> No hole you can drive through. A process with a UID
> of 0 and
> a GID of 0 can do anything it wants. It can execute
> iopl(3)
> and set an I/O permission level that allows it to
> directly access
> hardware I/O ports, etc. It can also turn off
> interrupts. Basically,
> it can do anything, since such a process can also
> memory-map anything.

But since it is the kernel that permits that (by
definition, since somebody has to check the UID & GID!
:) then the kernel can also restrict that.

The system admin account (UID/GID 0) could just as
easily access a virtual memory map, virtual I/O ports,
etc, with the kernel then handling how that maps onto
the physical world, and even IF it does.

> Users are not supposed to execute as 'root'. Also,
> only certain
> priviliged tasks execute as root. Ignore that this

The problem with priviliged tasks is that (in general)
they run with absolute privilige. Sure, some of these
priviliges can be turned off, but if /dev/mem is
reachable, then they can be turned back on again,
precicely for the reasons you give.

I guess that my understanding for having kernels the
size and complexity of Linux, as opposed to, say,
CP/M, is that the kernel can reduce the need for
userspace apps to have dangerous powers.


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
