Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262301AbRERLcp>; Fri, 18 May 2001 07:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbRERLcf>; Fri, 18 May 2001 07:32:35 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:45024 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S262294AbRERLcX>;
	Fri, 18 May 2001 07:32:23 -0400
Date: Fri, 18 May 2001 13:31:56 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ted Gervais <ve1drg@ve1drg.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 - kernel 2.4.3
In-Reply-To: <Pine.LNX.4.21.0105172254060.7428-100000@ve1drg.com>
Message-ID: <Pine.LNX.4.21.0105181328560.11038-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Ted Gervais wrote:

> 
> I get the following when ftping from one workstation to another.
> Using kernel 2.4.3 and Redhat7.1:
> 
> Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> eth0: Out-of-sync dirty pointer, 456 vs. 462.
> Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> Assertion failed! tp->tx_info[entry].skb == NULL,8139too.c,rtl8139_start_xmit,line=1676
> Assertion failed! tp->tx_info[entry].mapping == 0,8139too.c,rtl8139_start_xmit,line=1677
> 
> 
> Is there a fix for this?  Kernel 2.4.4 is worse. It gives me a 'kernel
> panic'..  doing the same ftp transfer between workstations.

I think I suffer from the same problem. The machine was stable with
2.4.2-ac6 until I started playing with smbfs and hit a bug in that. 
So I upgraded to 2.4.4 and since then the machine has been very unstable.
Maximum uptime so far is 4 days and then it fell over.
And I'm using an rtl8139 card too.

I don't have a monitor attached to the machine but I'm compiling
2.4.4-ac10 (afraid of the LVM changes in -ac11) with the kmsgdump patch so
I'll probably get a stackdump sometime later today.

/Martin

