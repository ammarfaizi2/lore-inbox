Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSJMBCA>; Sat, 12 Oct 2002 21:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJMBCA>; Sat, 12 Oct 2002 21:02:00 -0400
Received: from packet.digeo.com ([12.110.80.53]:32903 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261406AbSJMBB5>;
	Sat, 12 Oct 2002 21:01:57 -0400
Message-ID: <3DA8C75C.C38F840B@digeo.com>
Date: Sat, 12 Oct 2002 18:07:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Structure clobbering causes timer oopses
References: <3DA8C585.1030600@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 01:07:40.0707 (UTC) FILETIME=[ED7DF730:01C27254]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> ...
> timer magic check failed timer:__run_timers():351
> begin: 0xc035fbc8 end:0xc035fbe8

Can you look these up in System.map?

> ..
> 
> BTW, I found lots of users who aren't using init_timer().  Should I
> publicly humiliate them?

If they're initially using add_timer(), that works out
OK.  It they start out using mod_timer() (or del_timer) then bug.

I assume you tried all the memory debugging options?
