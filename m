Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130472AbRCDK6O>; Sun, 4 Mar 2001 05:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130475AbRCDK6F>; Sun, 4 Mar 2001 05:58:05 -0500
Received: from colorfullife.com ([216.156.138.34]:62983 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130472AbRCDK5u>;
	Sun, 4 Mar 2001 05:57:50 -0500
Message-ID: <3AA21FA5.BA370402@colorfullife.com>
Date: Sun, 04 Mar 2001 11:57:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: andrewm@uow.edu.au
CC: linux-kernel@vger.kernel.org
Subject: Re: [prepatches] removal of console_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Major revamp of printk(). The approach taken in printk() is to try 
>   to acquire the (new) console_sem. If we succeed, the output is 
>   placed into the log buffer and is printed to the consoles. If we fail 
>   to acquire the semaphore we just buffer the output in the log buffer 
>   and the current holder of the console_sem will do the printing for us 
>   prior to releasing console_sem. 

Is down_trylock reliable under load?

I remember 2 or 3 bug reports than disappeared after down_trylock was
removed.
The last one was this week.

http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg31919.html

--
	Manfred
