Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313327AbSDLDfd>; Thu, 11 Apr 2002 23:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313328AbSDLDfd>; Thu, 11 Apr 2002 23:35:33 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:18327 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313327AbSDLDfc>;
	Thu, 11 Apr 2002 23:35:32 -0400
Date: Fri, 12 Apr 2002 13:34:55 +1000
From: Anton Blanchard <anton@samba.org>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: task cpu affinity syscalls
Message-ID: <20020412033454.GA5773@krispykreme>
In-Reply-To: <1018275443.857.159.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a resync to 2.5.8-pre2 of my CPU affinity syscalls for 2.5's
> scheduler.
> 
> This patch implements two new syscalls:
> 
> 	int sched_setaffinity(pid_t pid, unsigned int len,
> 				unsigned long *new_mask_ptr)
> 
> 	int sched_getaffinity(pid_t pid, unsigned int *user_len_ptr,
> 				unsigned long *user_mask_ptr)

Since this isnt 32/64 bit compatible on big endian machines, can you
write some wrapper functions before all the archs implement it
themselves?

Think of 32 bit userspace passing a big endian bitmask into a 64 bit
kernel:

32 bit:
31-0 63-32 95-64 127-96

64 bit:
63-0 127-64

Anton
