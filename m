Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSHTUEY>; Tue, 20 Aug 2002 16:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSHTUEY>; Tue, 20 Aug 2002 16:04:24 -0400
Received: from host-65-162-110-4.intense3d.com ([65.162.110.4]:53520 "EHLO
	exchusa03.intense3d.com") by vger.kernel.org with ESMTP
	id <S317286AbSHTUEY>; Tue, 20 Aug 2002 16:04:24 -0400
Message-ID: <23B25974812ED411B48200D0B774071701248C6A@exchusa03.intense3d.com>
From: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
To: Mike Galbraith <efault@gmx.de>,
       Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       Gilad Ben-Yossef <gilad@benyossef.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Alloc and lock down large amounts of memory
Date: Tue, 20 Aug 2002 15:08:23 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Curiosity:  why do you want to do device DMA buffer 
> allocation from userland?

I need 256M memory for a graphics operation.  It's a requiremment,
can't change it. There will be other reasonably sized allocs in kernel 
space, this is a special case that will be done from userland. As 
discussed earlier in this thread, there's no good way of alloc()ing 
and pinning that much in DMA memory space, is there?

Gilad, I looked at mm/memory.c and map_user_kiobuf() lets me
map user memory into kernel memory and pins it down.  A scatter 
gatter mapping (say, pci_map_sg()) will create a seemingly 
contiguous buffer for DMA purposes.  Does that sound right to you?

Bhavana
