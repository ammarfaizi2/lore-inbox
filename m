Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSKCAhS>; Sat, 2 Nov 2002 19:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSKCAhS>; Sat, 2 Nov 2002 19:37:18 -0500
Received: from sun.cesr.ncsu.edu ([152.14.51.17]:34182 "EHLO sun.cesr.ncsu.edu")
	by vger.kernel.org with ESMTP id <S261525AbSKCAhR>;
	Sat, 2 Nov 2002 19:37:17 -0500
Date: Sat, 2 Nov 2002 19:43:48 -0500 (EST)
From: Anu <avaidya@unity.ncsu.edu>
X-X-Sender: avaidya@sun.cesr.ncsu.edu
To: LKML <linux-kernel@vger.kernel.org>
Subject: identifying the idling kernel and kernel hacking.
In-Reply-To: <Pine.GSO.4.44.0211021518290.6197-100000@sun.cesr.ncsu.edu>
Message-ID: <Pine.GSO.4.44.0211021903230.6319-100000@sun.cesr.ncsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
         I am looking at some way of "automatically" figuring out when a
kernel might be idle -- more at the level of the kernel code itself. After
a day's reading i have the following pieces of information:

.a. There is something called the run_queue which has a list of process
    that can be run.
.b. When nothing is running, we have the swapper process running (process
    0 ) that is the ancestor of all processes.
.c. the scheduler goes in and checks this readyqueue every so often, so,
    we can figure out if there are no processes running at any given
    time..
.d. I am now trying to modify the kernel to do something interesting when
    there is only the idle process running..  No idea what though. Linux
2.4.9 (which is the version i am looking at ) has a bunch of gotos and I
think i have identified that the section under still_running_back: is the
place to identify when the run_queue is empty.. I am thinking of putting
in some printfs() to make the kernel put out a message that says something
like "i am idling.." everytime the kernel is idling.. and execute a ps uax
simultaneously to show that the kernel is indeed idling..

are there any obvious disasters that u chaps see? (im not an OS person..)

-a



********************************************************************************

			      Think, Train, Be

*******************************************************************************


