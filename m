Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVHHGjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVHHGjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 02:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVHHGjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 02:39:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25219 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750722AbVHHGjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 02:39:51 -0400
Date: Mon, 8 Aug 2005 08:39:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: lab liscs <liscs.lab@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it a process?
In-Reply-To: <1123255059.18332.54.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0508080838260.18088@yvahk01.tjqt.qr>
References: <1132fcd6050805060216a03fb6@mail.gmail.com>
 <1123255059.18332.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> when linux kernel receives a packet from the netcard and the forwards it .
>> the process can be viewed as a kernel process ?
>> and if this process can be interrupted ?
>
>When a packet is received from the kernel, this is first done by an
>interrupt handler to just get the packet. Then the rest (forwarding) is

Do you mean forwarding from NIC to kernel space, or already the iptables 
FORWARD chain? What about packets destined for the local machine that just hit 
INPUT?

>done by a tasklet. This tasklet can be run either by the softirqd (a
>kernel thread) or at certain locations in the kernel. So this is not a

What is the name of this tasklet? ksoftirqd shows up in "ps", but no childs 
for it.


Jan Engelhardt
-- 
