Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267302AbSKPQQ5>; Sat, 16 Nov 2002 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbSKPQQ5>; Sat, 16 Nov 2002 11:16:57 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:18091 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S267302AbSKPQQz>;
	Sat, 16 Nov 2002 11:16:55 -0500
Date: Sat, 16 Nov 2002 09:23:41 -0700
From: yodaiken@fsmlabs.com
To: Stelian Pop <stelian.pop@fr.alcove.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021116092341.A30010@hq.fsmlabs.com>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <3DD57A5F.87119CB4@digeo.com> <20021115225932.GC1877@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115225932.GC1877@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Fri, Nov 15, 2002 at 11:59:32PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:59:32PM +0100, Stelian Pop wrote:
> On Fri, Nov 15, 2002 at 02:51:11PM -0800, Andrew Morton wrote:
> 
> > > Using USB instead of the serial line or the network card would be
> > > the best IMHO, because:
> > 
> > Here is the kgdb stub's "send a byte" function:
> > 
> > static void
> > write_char(int chr)
> > {
> >        while (!(inb(gdb_port + UART_LSR) & UART_LSR_THRE)) ;
> > 
> >        outb(chr, gdb_port + UART_TX);
> > }
> > 
> > Need I say more?
> 
> I already know that, but this is not the point. The point is that
> more and more boxes have no serial (or paralel) ports. 
> 
> But even on those boxes, sometimes I'd just love to be able to use
> kgdb. And I can't.
> 
> Ok, it will have to be at a higher level than the inb/outb serial
> transport implementation (with possible bad effects on what can
> and what cannot be debugged), but still, I feel there is a need
> for that.

> USB (with USB-to-serial adapter), network, ieee1394 would be 
> acceptable replacements for me.

Have you ever looked at a USB or 1394 driver? The nice thing about
serial is that the software to make it work is trivial. A debugger that 
relies on a 5000 line driver is quite suspect.

> 

> 
> Stelian.
> -- 
> Stelian Pop <stelian.pop@fr.alcove.com>
> Alcove - http://www.alcove.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

