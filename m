Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277335AbRJEItz>; Fri, 5 Oct 2001 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277334AbRJEItp>; Fri, 5 Oct 2001 04:49:45 -0400
Received: from smtp-out.hamburg.pop.de ([195.222.210.86]:4 "EHLO
	smtp-out.hamburg.pop.de") by vger.kernel.org with ESMTP
	id <S277333AbRJEItY>; Fri, 5 Oct 2001 04:49:24 -0400
Message-Id: <3BBD742C.41163A6B@gmx.de>
Date: Fri, 05 Oct 2001 10:49:48 +0200
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: STN-Atlas Elektronik
X-Mailer: Mozilla 4.72 [en] (X11; I; OSF1 V4.0 alpha)
X-Accept-Language: German/Germany, de-DE, en
Mime-Version: 1.0
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <Pine.LNX.4.33.0110010732140.1792-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

The problem with mmapping a Kernel buffer to userspace is still there .

It appears that __get_free_pages(GFP_KERNEL, max_order) alone is not enough to request a reliable buffer. On Monday I already sent a message to
the list which you may have overseen.

In my driver I have now the normal method on minor 26 and Roman Zippel's method on minor 27. I have used minor 27 quite heavy already and it
appears stable. Using minor 26 makes the system instable quite instantly.

I would like you to try my driver either on my system via remote login or I could try to reproduce the effect without DMA accesses to the buffer
and modify the driver so that you can try it without hardware in your Computer.

Is one of these 2 ways possible for you?

Thanks,
-- 
Bernd Harries

bha@gmx.de            http://bharries.freeyellow.com
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40
