Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287464AbSALUoc>; Sat, 12 Jan 2002 15:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287467AbSALUoX>; Sat, 12 Jan 2002 15:44:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287464AbSALUoF>; Sat, 12 Jan 2002 15:44:05 -0500
Message-ID: <3C409FF3.3090904@transmeta.com>
Date: Sat, 12 Jan 2002 12:43:31 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <200201121048.CAA11276@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

> 
> 	Your comment prompted me to look at
> linux-2.5.2-pre11/include/asm-i386/spinlock.h, and I now believe that
> the "lock; decb" that it uses for grabbing spinlocks will return an
> incorrect success if 255 or more processors are waiting on the same
> spinlock.  I don't know if anybody has ever built a shared memory x86
> multiprocessor with 257 (not a typo) or more CPU's, but it's possible
> to imagine.  It's also possible to imagine this scenario happening
> with even just one processor and a preemtable kernel.  I believe that
> the current preemtable kernel patch limits the number of preempted
> processes to something like four or six, but that's just a temporary
> limitation of the current version.
> 


Linux specificially does not allow for more processors than there are 
bits in a long (32 or 64).  Libc, however, since it counts processes, 
not CPUs, uses a 4-byte word.

	-hpa

