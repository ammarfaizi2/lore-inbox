Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263255AbVCKJzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbVCKJzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVCKJzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:55:50 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:64122 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263240AbVCKJz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:55:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gnJoX7soplCLa4SZ13Zocx4N2Umvjr8JRGFolortVAxE12us9YhcNVNeZ9h60OIWGTmp+CfKn93E59ZG0L/GSdJX7xuJpc4IlHEda5Hd10sRV2DsCQNNro9tPy47FTM1qdDCIVA/+1XWHs0sYjRBwrHfUuTXz823FdAzq5oC4Pc=
Message-ID: <5a2cf1f6050311015525194792@mail.gmail.com>
Date: Fri, 11 Mar 2005 10:55:24 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: oops / 2.6.11 / run_timer_softirq (mountvirtfs)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050310205943.794b8efd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5a2cf1f6050310161085f2da6@mail.gmail.com>
	 <20050310205943.794b8efd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 20:59:43 -0800, Andrew Morton <akpm@osdl.org> wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
> >
> > On an VIA EPIA board, I got this single oops at boot. Wasn't stored on
> > file so I had to take a screenshot with a digital camera. Basicallly
> > goes along those lines:
> >
> > Process: S36mountvirtfs
> >
> > Call trace:
> >      run_timer_softirq+0x16f/0x200
> >      __do_softirq
> >      do_softirq
> >      irq_exit
> >      do_IRQ
> >      common_interrupt
> >
> > Process is found here on my system:
> >
> > lrwxr-xr-x  1 root root 21 Mar  1 00:29 /etc/rcS.d/S36mountvirtfs ->
> > ../init.d/mountvirtfs
> >
> > The exact screenshot (500k) can be found here:
> >
> > http://coffeebreaks.dyndns.org/~jerome/static/images/linux/oops_2.6.11_run_timer_softirq_boot.jpg
> >
> 
> An oops in cascade() is tricky.  Normally it means that some piece of code
> has done something bad with a kernel timer.  Later, a clock tick happens
> and the kernel falls over.  We're left with no hints as to which part of
> the kernel misbehaved.
> 
> Please try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC and see if
> that reveals any additional info.

Question; the thing happened once at boot time (out of hundreds) so it
will probably be hard to reproduce.

I you may have seen on the pictures, the screen was completely filled
up with the oops information. How will the new CONFIG_ options help if
I don't have more information on the screen when it oopses?

> Apart from that, you have a lot of modules configured there.  Please try
> disabling them all, see if the oops goes away.  If it does then try
> re-enabling them, see if you can narrow it down to the one which is causing
> the timer list corruption.

If the problem reappears I will see what I can do.

Jerome

> Thanks.

Pareillement

J
