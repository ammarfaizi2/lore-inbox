Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132200AbRCYUvX>; Sun, 25 Mar 2001 15:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132201AbRCYUvN>; Sun, 25 Mar 2001 15:51:13 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:34872 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S132200AbRCYUu4>; Sun, 25 Mar 2001 15:50:56 -0500
Message-Id: <4.3.2.7.2.20010325123201.00be27d0@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 25 Mar 2001 12:47:11 -0800
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABE0F32.5255DF30@evision-ventures.com>
In-Reply-To: <E14gVQf-00056B-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:30 PM 3/25/01 +0200, you wrote:
> > Ultra reliable systems dont contain memory allocators. There are good 
> reasons
> > for this but the design trade offs are rather hard to make in a real world
> > environment
>
>I esp. they run on CPU's without a stack or what?

No dynamic memory allocation AT ALL.  That includes the prohibition of a 
stack.  I've seen avionics-loop systems that abstract a stack but the 
"allocators" are part of the application and are designed to fall over 
gracefully when they become full -- but getting this past a project manager 
is hard, as it should be.

Then there are those systems with rather interesting watchdog timers.  If 
you don't tickle them just right, they fire and force a restart.  The 
nastiest of these required that you send four specific values to a specific 
I/O port, and the hardware looked to see if the values violated certain 
timing guidelines.  If you sent the code too early or too late, or if the 
value in the sequence was incorrect, BAM.  The hardware was designed by a 
guy with some rather interesting experiences with software "engineers" 
dealing with watchdog timers...

Satch
   

