Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131653AbQKDIkH>; Sat, 4 Nov 2000 03:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131714AbQKDIj5>; Sat, 4 Nov 2000 03:39:57 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12556 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131653AbQKDIjr>;
	Sat, 4 Nov 2000 03:39:47 -0500
Message-ID: <3A03CB4B.20183FED@mandrakesoft.com>
Date: Sat, 04 Nov 2000 03:39:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Hammerton <dhammerton@labyrinth.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4-test10: new wrapper.h brakes drivers
In-Reply-To: <200011040827.TAA14095@mr14.vic-remote.bigpond.net.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hammerton wrote:
> 
> Hi,
> 
> i just installed the latest kernel (2.4-test10).
> 
> On recompilation of my "Nvidia" kernel drivers (for geforce 2 3d video support
> in linux), it failed linking to "mem_map_inc_count" (and dec_count).
> 
> Im not much of a programmer, but to get it working all i had to do was to add
> to '/usr/src/linux/include/linux/wrapper.h':
> /*the patch*/
> #define mem_map_inc_count(p)    atomic_inc(&(p->count))
> #define mem_map_dec_count(p)    atomic_dec(&(p->count))
> /*end patch*/
> 
> yes, you'll notice i ripped this out of the older kernels..
> 
> good luck in finding an alternative, or just leave it in, or whatever.

if the nvidia kernel shell needs to support multiple kernel versions,
they should add

#ifndef mem_map_inc_count
...compat code...
#endif

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
