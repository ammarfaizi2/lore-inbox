Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbSKOWwm>; Fri, 15 Nov 2002 17:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbSKOWwm>; Fri, 15 Nov 2002 17:52:42 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:22225 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S266865AbSKOWwk>; Fri, 15 Nov 2002 17:52:40 -0500
Date: Fri, 15 Nov 2002 23:59:32 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021115225932.GC1877@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <3DD57A5F.87119CB4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD57A5F.87119CB4@digeo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 02:51:11PM -0800, Andrew Morton wrote:

> > Using USB instead of the serial line or the network card would be
> > the best IMHO, because:
> 
> Here is the kgdb stub's "send a byte" function:
> 
> static void
> write_char(int chr)
> {
>        while (!(inb(gdb_port + UART_LSR) & UART_LSR_THRE)) ;
> 
>        outb(chr, gdb_port + UART_TX);
> }
> 
> Need I say more?

I already know that, but this is not the point. The point is that
more and more boxes have no serial (or paralel) ports. 

But even on those boxes, sometimes I'd just love to be able to use
kgdb. And I can't.

Ok, it will have to be at a higher level than the inb/outb serial
transport implementation (with possible bad effects on what can
and what cannot be debugged), but still, I feel there is a need
for that.

USB (with USB-to-serial adapter), network, ieee1394 would be 
acceptable replacements for me.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
