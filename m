Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277970AbRJMRsC>; Sat, 13 Oct 2001 13:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277974AbRJMRrv>; Sat, 13 Oct 2001 13:47:51 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:64270 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S277970AbRJMRrf>; Sat, 13 Oct 2001 13:47:35 -0400
Date: Sat, 13 Oct 2001 13:48:05 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Patrick McFarland <unknown@panax.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
In-Reply-To: <20011013130228.E249@localhost>
Message-ID: <Pine.LNX.4.10.10110131305490.17521-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, the great kernel hacker, ac, said that 2.2 is better at vm in low
> memory situations than 2.4 is. Why is this? Why hasnt someone fixed the 2.4
> code? 

not to slight TGKH AC, but he's also the 2.2 maintainer; perhaps there's 
some paternal protectiveness there ;)

my test for VM is to compile a kernel on my crappy old BP6 with mem=64m;
I use a dedicated partition with a fresh ext2, unpack the same source tree,
make -j2 7 times, drop 1 outlier, and average:

2.2.19: 584.462user 57.492system 385.112elapsed 166.5%CPU
2.4.12: 582.318user 40.535system 337.093elapsed 184.5%CPU

notice that elapsed is noticably faster even than the 1+17 second
benefit to user and system times.  Rik's VM seems to be slightly
slower on this test.  with 128M, there's much less diference for 
any of the versions (and I don't have the patience for <64M.)

regards, mark hahn.

