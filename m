Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbRHBAE4>; Wed, 1 Aug 2001 20:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267912AbRHBAEq>; Wed, 1 Aug 2001 20:04:46 -0400
Received: from web14408.mail.yahoo.com ([216.136.174.78]:22024 "HELO
	web14408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267911AbRHBAEd>; Wed, 1 Aug 2001 20:04:33 -0400
Message-ID: <20010802000441.95526.qmail@web14408.mail.yahoo.com>
Date: Wed, 1 Aug 2001 17:04:40 -0700 (PDT)
From: Rajeev Bector <rajeev_bector@yahoo.com>
Subject: debugging memory leaks in drivers/module
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am thinking of creating a small patch
to track heap memory allocations and
deallocations from drivers and modules.
This could be really useful in a system
where you are testing lots of drivers 
and modules in your test environment and
want to keep track of how much kmalloc()ed
memory the module has allocated.

Has anyone written such a thing and it
is available for use somewhere ?

(Basically how it would work is I would
intercept the kmalloc() call in my routine
and then look at the __builtin_return_address
to find which module has requested the allocation)
Same with kfree() although I will have to dig
into the slab cache to figure out the original
request size. We can then record this info in 
a table of some sort and export it via /proc
or an ioctl()).. Is there a better way of
doing this ?

Thanks in advance !
Rajeev


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
