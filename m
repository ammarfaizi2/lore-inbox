Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310587AbSCHHGZ>; Fri, 8 Mar 2002 02:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310709AbSCHHGF>; Fri, 8 Mar 2002 02:06:05 -0500
Received: from CPE-203-51-27-100.nsw.bigpond.net.au ([203.51.27.100]:11022
	"EHLO front.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S310587AbSCHHF6>; Fri, 8 Mar 2002 02:05:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks 
In-Reply-To: Your message of "Thu, 07 Mar 2002 22:29:44 -0800."
             <3C885A58.4040307@zytor.com> 
Date: Fri, 08 Mar 2002 18:09:18 +1100
Message-Id: <E16jEVC-0006uu-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C885A58.4040307@zytor.com> you write:
> Okay, dumb question...
> 
> What can this do that shared memory + existing semaphores can't do?
> 
> 	-hpa

Ignoring speed issues and the fundamentally horrible interface of SysV
semaphores, there are two main issues:

1) There's a limit on the number of SysV semaphores you can have.
2) Instead of one object to deal with (ie. a memory region), you now
   have two, with different lifetimes.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
