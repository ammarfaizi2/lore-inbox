Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSFRPIj>; Tue, 18 Jun 2002 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317445AbSFRPIi>; Tue, 18 Jun 2002 11:08:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56704 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317444AbSFRPIh>; Tue, 18 Jun 2002 11:08:37 -0400
Date: Tue, 18 Jun 2002 11:10:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: VMM - freeing up swap space
In-Reply-To: <EE83E551E08D1D43AD52D50B9F5110927E7A9E@ntserver2>
Message-ID: <Pine.LNX.3.95.1020618110445.3808A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Gregory Giguashvili wrote:

> Hello,
> 
> Running an application allocating huge amounts of memory would push some
> data from RAM to swap area. After the application terminates, swap area is
> usually still occupied. 
> 
> Is there any way to clean up the swap area by pushing the data back to RAM?
> 
> Thanks in advance
> Giga

Sure. Execute `swapoff -a`, followed by `swapon -a`. This is no joke.
What didn't get 'pushed' back to RAM is the data from sleeping tasks
that may never wake up for days or years like the daemons that are
awaiting network connections that never happen, or getties that never
get to log-in. So, their data stays on the swap device(s) and their
RAM is freed for use. If you insist in putting this data back into
RAM, thereby wasting RAM, you can do as shown.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

