Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271656AbRHQOPU>; Fri, 17 Aug 2001 10:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271661AbRHQOPK>; Fri, 17 Aug 2001 10:15:10 -0400
Received: from nef.ens.fr ([129.199.96.32]:18700 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S271656AbRHQOO7>;
	Fri, 17 Aug 2001 10:14:59 -0400
Date: Fri, 17 Aug 2001 16:15:05 +0200
From: David Madore <david.madore@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: broken memory chip -> software fix?
Message-ID: <20010817161505.A25194@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have a broken bit in my memory - at address 0x04d5ae38 if you want
to know the details (bit 29 of the double word there sometimes reads
as 1 when it was written as 0, in particular if bit 15 is at 1).  I
discovered this by observing a one-bit corruption of some files, and
diagnosed it by running memtest86.

Now that I know the address, is there a way I can prevent Linux from
using that region of memory in any way?  The simplest and cleanest
way, would be, I guess, for a userland process I would write to ask of
the kernel to map permanently and unswappably the page at physical
location 0x04d5a000 to its virtual address space.  (Besides, that
would let me play with that broken bit.)

So: is there a way for a userland process (running at euid 0) to
request of the kernel an explicit physical address to virtual address
translation?  If so, how?  I would prefer not to have to patch the
kernel, if at all possible.

Thanks,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
