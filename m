Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRJSSto>; Fri, 19 Oct 2001 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278595AbRJSSt0>; Fri, 19 Oct 2001 14:49:26 -0400
Received: from [207.8.4.6] ([207.8.4.6]:22216 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S278594AbRJSSsX>;
	Fri, 19 Oct 2001 14:48:23 -0400
Message-ID: <3BD07586.3090706@interactivesi.com>
Date: Fri, 19 Oct 2001 13:48:38 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
Subject: Allocating more than 890MB in the kernel?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc() fails after about 890MB because the kernel memory map is only for 
about 1GB.  I know there are some hacks and work-arounds to get more than 
that, but instead of reinventing the wheel, I was hoping some kind soul would 
tell me how (a few hints would be nice!)

The reason we use vmalloc() is because we need to apply memory pressure during 
the allocating: memory should be swapped out to make room for our allocation.

We're trying to allocate up to 3GB on a 4GB machine.  Thanks in advance!

