Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSJOFqJ>; Tue, 15 Oct 2002 01:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJOFqJ>; Tue, 15 Oct 2002 01:46:09 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:31751 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262312AbSJOFqI>;
	Tue, 15 Oct 2002 01:46:08 -0400
Date: Mon, 14 Oct 2002 22:52:11 -0700
From: Greg KH <greg@kroah.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] 2.5.42 partial fix for older pl2303
Message-ID: <20021015055211.GA11524@kroah.com>
References: <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net> <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net> <20021013011644.GA12720@kroah.com> <20021013043008.GD10921@ip68-4-86-174.oc.oc.cox.net> <20021013202504.GA23533@kroah.com> <20021014024930.GE10921@ip68-4-86-174.oc.oc.cox.net> <20021014041756.GD17162@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014041756.GD17162@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 09:17:56PM -0700, Barry K. Nathan wrote:
> 
> followed by tons of these oopses (I think it's one per LCP echo
> request/reply pair on my PPP connection but I'm not sure):
> 
> Debug: sleeping function called from illegal context at
> include/asm/semaphore.h:119
> Call Trace:
>  [<c02095f7>] serial_write+0x77/0x170
>  [<c01da4e8>] ppp_async_push+0x138/0x1c0
>  [<c01da3a5>] ppp_async_send+0x45/0x50
>  [<c01d674e>] ppp_channel_push+0x7e/0x1a0
>  [<c01d548d>] ppp_write+0xfd/0x130
>  [<c013d67d>] vfs_write+0xcd/0x140
>  [<c013d78c>] sys_write+0x3c/0x60
>  [<c01075cb>] syscall_call+0x7/0xb

Heh, I didn't think that serial_write() would sleep, but I know the
pl2303 driver could have this problem.  But it's just a warning, I know
the usb-serial drivers have some issues regarding PPP.  Check the lkml
archives for a discussion about this only a week or so ago.

> Under 2.4.20-pre10 + my 2.4 fix, the device always gets ttyUSB0, and
> always works there.

Glad this is working.

thanks,

greg k-h
