Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284763AbRLXLuS>; Mon, 24 Dec 2001 06:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284766AbRLXLuH>; Mon, 24 Dec 2001 06:50:07 -0500
Received: from [212.84.226.66] ([212.84.226.66]:659 "EHLO master")
	by vger.kernel.org with ESMTP id <S284763AbRLXLtz>;
	Mon, 24 Dec 2001 06:49:55 -0500
Date: Mon, 24 Dec 2001 12:48:03 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Total system lockup with Alt-SysRQ-L
Message-ID: <20011224114803.GA23494@master.directfb.org>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20011223175846.B27993@flint.arm.linux.org.uk> <E16IKwX-0002U3-00@the-village.bc.nu> <20011224083752.A1181@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011224083752.A1181@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King (rmk@arm.linux.org.uk):
> On Mon, Dec 24, 2001 at 02:34:20AM +0000, Alan Cox wrote:
> > > When pid1 exits (maybe due to a kill signal), we lockup hard in (iirc)
> > > exit_notify.  I don't remember the details I'm afraid.
> > 
> > pid1 ends up trying to kill pid1 and it goes deeply down the toilet from
> > that point onwards. The Unix traditional world reboots when pid 1 dies.
> 
> The problem was definitely in the exit_notify code, where it manipulated
> the task links indefinitely.  (I think it was cptr never becomes null,
> so the loop never terminates).
> 
> However, if we're saying that "pid1 must not die" then maybe we should get
> rid of the 'killall' sysrq option since it serves no useful purpose, and
> add a suitable panic in the do_exit path?

Another annoying thing that happens sometimes is that I accidently
press 'L' or 'E' instead of 'K' or 'R', the mostly used SysRQs for me.

An additional modifier for the harmful actions would be useful, e.g. Shift.
So pressing Alt-SysRQ-E would do nothing until Shift is pressed, too.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

           convergence integrated media GmbH
