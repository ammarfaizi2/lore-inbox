Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262251AbRETWIN>; Sun, 20 May 2001 18:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262252AbRETWID>; Sun, 20 May 2001 18:08:03 -0400
Received: from mail1.mail.iol.ie ([194.125.2.192]:26125 "EHLO mail.iol.ie")
	by vger.kernel.org with ESMTP id <S262251AbRETWH4>;
	Sun, 20 May 2001 18:07:56 -0400
Date: Sun, 20 May 2001 23:07:47 +0100
From: Kenn Humborg <kenn@linux.ie>
To: linux-vax@mithra.physics.montana.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LV] start_thread question...
Message-ID: <20010520230747.B19847@excalibur.research.wombat.ie>
In-Reply-To: <Pine.LNX.4.32.0105201717100.29656-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.32.0105201717100.29656-100000@skynet>; from airlied@skynet.ie on Sun, May 20, 2001 at 05:24:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 05:24:48PM +0100, Dave Airlie wrote:
> 
> I'm implementing start_thread for the VAX port and am wondering does
> start_thread have to return to load_elf_binary? I'm working on the init
> thread and what is happening is it is returning the whole way back to the
> execve caller .. which I know shouldn't happen.....
> 
> so I suppose what I'm looking for is the point where the user space code
> gets control... is it when the registers are set in the start_thread? if
> so how does start_thread return....
> 
> On the VAX we have to call a return from interrupt to get to user space
> and I'm trying to figure out where this should happen...

I haven't got time to look at this in detail, but you could
probably do it by frobbing the saved registers that will be
restored by the ret_from_syscall in entry.S.  Do you have
a pt_regs *regs function argument at the right point?  If
so, it should point to these saved registers.

Later,
Kenn

