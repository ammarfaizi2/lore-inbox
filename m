Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKHOyU>; Wed, 8 Nov 2000 09:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKHOyJ>; Wed, 8 Nov 2000 09:54:09 -0500
Received: from mailhub.icx.net ([206.96.250.12]:13832 "EHLO icx.net")
	by vger.kernel.org with ESMTP id <S129094AbQKHOyE>;
	Wed, 8 Nov 2000 09:54:04 -0500
Message-ID: <3A092269.9020501@edge.net>
Date: Wed, 08 Nov 2000 09:52:41 +0000
From: Anthony Chatman <anthony@edge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10 i686; en-US; m18) Gecko/20000929 Netscape6/6.0b3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Nvidia GeForce2 kernel driver - kernel 2.4.0 test-10
In-Reply-To: <3A08F5E9.61F424A0@ihug.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of Nvidia, I have a Nvidia GeForce2, and had problems loading 
the NV kernel module with a patched test10 kernel (i was running test9 
before).  I took a look at the test10 patch, and noticed the following 2 
lines were taken out of  <linux_dir>/include/linux/wrapper.h:

#define mem_map_inc_count(p) atomic_inc(&(p->count))
#define mem_map_dec_count(p) atomic_dec(&(p->count))

I added those two defines back into wrapper.h and then was able to load 
the NVdriver successfully, with no problems. This doesn't appear to 
break compiliation of the test10 kernel either. I thought I'd let 
everyone know if anyone was having problems with the NV kernel driver. 
Please note, I am not a C programmer, but more of a C hacker, and this 
worked for me on my Slackware 7.1 machine. I have no idea what this may 
have broken in the kernel or whatnot. I only know that this fixed the 
problem on this particular box with the NV kernel driver, so proceed at 
your own risk ;-)





david wrote:

> hi i am writing a video kernel driver for linux lexos and have got stuck
> 
> this is how NVIDIA do their regs
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
