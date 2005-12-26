Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVLZRPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLZRPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 12:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVLZRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 12:15:30 -0500
Received: from mail.gmx.net ([213.165.64.21]:58785 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932069AbVLZRP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 12:15:29 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20051226175652.00be31b8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 26 Dec 2005 18:15:17 +0100
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Cc: mingo@elte.hu, zippel@linux-m68k.org, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051226031128.13bbace9.akpm@osdl.org>
References: <1135593776.2935.5.camel@laptopd505.fenrus.org>
 <20051222114147.GA18878@elte.hu>
 <20051222153014.22f07e60.akpm@osdl.org>
 <20051222233416.GA14182@infradead.org>
 <200512251708.16483.zippel@linux-m68k.org>
 <20051225150445.0eae9dd7.akpm@osdl.org>
 <20051225232222.GA11828@elte.hu>
 <20051226023549.f46add77.akpm@osdl.org>
 <1135593776.2935.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0550-0, 12/10/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:11 AM 12/26/2005 -0800, Andrew Morton wrote:
>Arjan van de Ven <arjan@infradead.org> wrote:
> >
> >
> > > hm.  16 CPUs hitting the same semaphore at great arrival rates.  The cost
> > > of a short spin is much less than the cost of a sleep/wakeup.  The 
> machine
> > > was doing 100,000 - 200,000 context switches per second.
> >
> > interesting.. this might be a good indication that a "spin a bit first"
> > mutex slowpath for some locks might be worth implementing...
>
>If we see a workload which is triggering such high context switch rates,
>maybe.  But I don't think we've seen any such for a long time.

Hmm.  Is there a real workload where such a high context switch rate is 
necessary?  Every time I've seen a high (100,000 - 200,000 is beyond absurd 
on my little box, but...) context switch rate, it's been because something 
sucked.

         -Mike   

