Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262249AbSJKAsC>; Thu, 10 Oct 2002 20:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJKAsC>; Thu, 10 Oct 2002 20:48:02 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:33776 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S262249AbSJKAsB>;
	Thu, 10 Oct 2002 20:48:01 -0400
Date: Thu, 10 Oct 2002 20:53:38 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Looking for testers with these NICs
Message-ID: <20021011005338.GA1067@www.kroptech.com>
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua> <20021009171452.GA9682@www.kroptech.com> <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 08:37:48PM -0200, Denis Vlasenko wrote:
> On 9 October 2002 15:14, Adam Kropelin wrote:
> > On Wed, Oct 09, 2002 at 07:31:17PM -0200, Denis Vlasenko wrote:
> > > ewrk3.c
> >
> > I've got a few of these laying around. Send whatever patches you want
> > tested and I'll give it a shot.
> 
> Please do your best in trying to break it, especially since you say you have
> more than one. Can you plug them all in one box?
> 
> I'd suggest SMP/preempt heavy IO. Is there stress test software for NICs?

I've finished beating the heck out of this driver. Over 12 hours of pounding
simultaneously on three NICs in a 2x SMP box running with preempt enabled and
not a single oops, BUG(), or deadlock. I'd say the driver is pretty solid at
this point; vda's locking patches seem to be safe. 

As a sidenote, the max throughput I was able to achieve across three cards was
about 1.4 MBytes/sec. A single card could do about 800 KBytes sec; 2 together
got to 1.2 MBytes/sec. Heavy CPU utilization the whole way, of course, since
these cards do not use DMA. 

--Adam

