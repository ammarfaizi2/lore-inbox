Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288900AbSAERt7>; Sat, 5 Jan 2002 12:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288901AbSAERtu>; Sat, 5 Jan 2002 12:49:50 -0500
Received: from gear.torque.net ([204.138.244.1]:6151 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S288900AbSAERtf>;
	Sat, 5 Jan 2002 12:49:35 -0500
Message-ID: <3C373D4C.417FF31E@torque.net>
Date: Sat, 05 Jan 2002 12:52:12 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steffen Persvold <sp@scali.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Short question about the mmap method 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold <sp@scali.no> wrote:

> I have a question regarding drivers implementing the
> mmap and nopage methods. In some references
> I've read that pages in kernel allocated memory (either 
> allocated with kmalloc, vmalloc or __get_free_pages) 
> should be set to reserved (mem_map_reserve or 
> set_bit(PG_reserved, page->flags) before they can be 
> mmap'ed to guarantee that they can't be swapped out. 
> Is this true ?

Steffen,
I recently implemented the mmap() call in the SCSI generic
(sg) driver. See that driver in lk 2.4.17 or go to
   http://www.torque.net/sg 
and download version 3.1.22 of the sg driver from the table.
It will run on any kernel in the 2.4 series. It should
answer most of your questions (at least about mmap-ing
memory obtained from __get_free_pages() which is a bit 
tricky).  

Doug Gilbert
