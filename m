Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbSATUfU>; Sun, 20 Jan 2002 15:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSATUfA>; Sun, 20 Jan 2002 15:35:00 -0500
Received: from isis.telemach.net ([213.143.65.10]:15880 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S284305AbSATUe7>;
	Sun, 20 Jan 2002 15:34:59 -0500
Date: Sun, 20 Jan 2002 21:35:54 +0100
From: Jure Pecar <pegasus@telemach.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc2aa2 oops in page_alloc.c
Message-Id: <20020120213554.667bd8d2.pegasus@telemach.net>
In-Reply-To: <20020120190835.H21279@athlon.random>
In-Reply-To: <20020120182655.301234b4.pegasus@telemach.net>
	<20020120190835.H21279@athlon.random>
Organization: Select Technology 
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002 19:08:35 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

ok, will recompile with this patch.

> the real question is, does it feel slower with 50mbyte in swap? I mean,

can't really say, as there is almost no shell usage to get the true feeling of the box. but judging by the users' feedback it is much better with aa2 than with stock 2.4.17.

> some very very lightweight background activity in the long run should be
> a very good thing, it should save you some ram on the very long run. of
> course unless you keep seeing swapin/swapout almost all the time, in

will setup a mrtg script to monitor the amount of swap in use. 

> such a case it would be a big mistake but I don't think it's the case.
> If after a week you see 50mbyte in swap (and you almost never seen any
> swapin, and maybe only a few very seldom swapout), that sounds good.
> Infact it's not even sure that you did any real swapout yet, part of the
> 50mbyte in swap may only be preallocated.
> 
> with -aa if you don't want to see such 50mbyte in swap (even if they
> seems very sane at first sight, so this is not a suggestion, this is
> just informational, just if you want to try) you can run:
> 
> 	echo 1000 >/proc/sys/vm/vm_mapped_ratio
> 
> Andrea
> 


-- 


Jure Pecar


Unfortunatly, SMTP email is anything but a small set of problems.  Quite the opposite: it's a tarpit of bureaucratic standards committees, arrogant implementors, impatient administrators and whiny end-users.

