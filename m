Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVI3QF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVI3QF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVI3QF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:05:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62964 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030356AbVI3QFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:05:23 -0400
Subject: Re: 2.6.14-rc2-rt7 - AMD64 runs GREAT! (threaded/non-threaded
	interrupts?)
From: Daniel Walker <dwalker@mvista.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0509300854o2f8ad7e9oa7736da916479458@mail.gmail.com>
References: <5bdc1c8b0509300854o2f8ad7e9oa7736da916479458@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 09:05:21 -0700
Message-Id: <1128096321.12850.16.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 08:54 -0700, Mark Knecht wrote:
> Hi,
>    I finally managed to find an acceptable set of config options last
> even that build correctly. The kernel came right up and is working
> wonderfully on my Gentoo system. I've been up for a few hours this
> morning with Jack going at 128/2. (<6mS latency) Music is streaming
> with no xruns, even while doing emerge sync/emerge world operations.
> 
> 
>    One question. In earlier rt kernels there was a way to set specific
> ISR routinges as threaded or non-threaded through
> /proc/irq/ISR#/DEVICE/threaded. Does anything like this exist anymore?

I think there was a way to select softirqd as thread or not. This
doesn't exist for interrupts because the ISR would need to be modified
at compile time to work correctly. So you can't simple select drivers to
run in interrupt context unless they are specifically written to do so.

Daniel 

