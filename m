Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269229AbRHaUlX>; Fri, 31 Aug 2001 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269254AbRHaUlN>; Fri, 31 Aug 2001 16:41:13 -0400
Received: from unused ([12.150.234.220]:52222 "EHLO one.isilinux.com")
	by vger.kernel.org with ESMTP id <S269229AbRHaUlH>;
	Fri, 31 Aug 2001 16:41:07 -0400
Message-ID: <3B8FF671.1050804@interactivesi.com>
Date: Fri, 31 Aug 2001 15:41:21 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel hangs in 118th call to vmalloc
In-Reply-To: <E15cv3e-0003vf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> vmalloc shouldnt be hanging the box, although in 2.4.2 the out of memory 
> handling is not too reliable. You have to understand vmalloc isnt meant to 
> be used that way and the kernel gets priority over user space for allocs so
> is able to get itself to the point it killed off all user space.

So you're saying it's a bug that I can't work around?

It's probably a moot point.  I've come up with a different algorithm 
that allocates all but 32MB of RAM, and it appears to work well.

I heard that 2.4.9 doesn't even run "thrash".  Is this true?  If so, why 
are these buggy VM's being released in the first place?

