Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292773AbSBZUFf>; Tue, 26 Feb 2002 15:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292768AbSBZUFX>; Tue, 26 Feb 2002 15:05:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6675 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292770AbSBZUFD>;
	Tue, 26 Feb 2002 15:05:03 -0500
Message-ID: <3C7BEA6F.97CB8AD4@mandrakesoft.com>
Date: Tue, 26 Feb 2002 15:05:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <Pine.LNX.3.95.1020226145622.5179A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> I just read on this list that:
> 
>     while(something)
>     {
>       current->policy |= SCHED_YIELD;
>       schedule();
>     }
> 
> Will no longer be allowed in a kernel module! If this is true, how
> do I loop, waiting for a bit in a port, without wasting CPU time?

Call yield() or better yet, schedule_timeout()

In 2.4, define the above to be yield() in some compatibility module...

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
