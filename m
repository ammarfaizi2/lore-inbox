Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTELDZa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTELDZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:25:30 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.93.67.82]:22164 "EHLO
	ms-smtp-01.southeast.rr.com") by vger.kernel.org with ESMTP
	id S261846AbTELDZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:25:29 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Posible memory leak!?
Date: Sun, 11 May 2003 23:42:27 -0400
User-Agent: KMail/1.5.1
References: <3EBC9C62.5010507@nortelnetworks.com> <3EBF144E.7050608@nortelnetworks.com> <m3y91cj0vm.fsf@varsoon.wireboard.com>
In-Reply-To: <m3y91cj0vm.fsf@varsoon.wireboard.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305112342.27469.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok i hope someone can help with this.. I have been trying to figure it out
ever since 2.4.20(this behaviour is present with all the pre and rc's and
also with all the ac patches).
I have 385844k(377mb) of SDRAM and 128512k(126mb) of SWAP. Now here is the
deal: before I upgraded to 2.4.20 swap was never touched and my ram was
always staying down at arround 3/5% usage (unless i did some compiling).
Now when I did the upgrade to 2.4.20 I did not change my config file at all
the only new thing that I added was adding usb-to-usb networking ( i have a
zaurus) ( i have tried both module and compiled into the kernel, this is
not the cause of the problem). Now if I leave the machine on for a couple
of hours my ram begins to be eaten up (top says that all goes into cache)
and the system begins to eat away into the swap, at this point if I start
anything resource intensive (like compiling or running NetBeans) RAM usage
goes down and swap usage shoots up.
These are the things I have tried so far:
1. use all the pre, rc, ac (the pres and rc with and without ac applied)
2. compile the one and only new thing (usb-tp-usb) as module and building it
into the kernel.
3. leaveing the system at the console (not running X not doing anything just
let it sit there). (the problem appears still, so I know it is not my X)
4. running X and leaving the machine to idle.(the problem presists)
5. turning swap off completely. (in this case of course ram was used but it
was never released, it always stayed above 50% usage and never came down).

None of these lead to anything... my ram was still eaten up (pretty much all
was put into cache, at least that is what top was reporting) and then once
I started using the computer instead of ram the system was using swap.

As i said i have not been albe to find out what the problem is... or where
it is coming from, I hope someone here might be able to help.
My distro is slackware 9, kernel is 2.4.20-rc2 (have not applied the ac
yet), i have X 4.3.0 and KDE 3.1.1a.
Thanks for any help.
