Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318078AbSGZTVV>; Fri, 26 Jul 2002 15:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSGZTVV>; Fri, 26 Jul 2002 15:21:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21632 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318078AbSGZTVU>; Fri, 26 Jul 2002 15:21:20 -0400
Date: Fri, 26 Jul 2002 15:25:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell Lewis <spamhole-2001-07-16@deming-os.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
In-Reply-To: <3D418DFD.8000007@deming-os.org>
Message-ID: <Pine.LNX.3.95.1020726151940.3338A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Russell Lewis wrote:

> I have spent some time working on AIX, which pages its kernel memory. 
>  It pins the interrupt handler functions, and any data that they access, 
> but does not pin the other code.
> 
> I'm looking for links as to why (unless I'm mistaken) Linux doesn't do 
> this, so I can better understand the system.
> 
> Thanks, and sorry for the broadcast message.  My web search turned up 
> nothing.
> 
> Russ Lewis

You'll probably get a zillion replies on this.
Paging is expensive. The fastest kernel will not be paged.
Also, the kernel is very small, you gain a few pages, maybe
80 to 90 at the expense of paging CPU cycles. 85 * 4096 = 348,160
1/3 megabyte gained, hardly worth the cost.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

