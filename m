Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277408AbRJJU23>; Wed, 10 Oct 2001 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277418AbRJJU2T>; Wed, 10 Oct 2001 16:28:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35969 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277408AbRJJU2A>; Wed, 10 Oct 2001 16:28:00 -0400
Date: Wed, 10 Oct 2001 16:28:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Torri <storri@ameritech.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory free report error (kernel-2.4.10-ac10)
In-Reply-To: <Pine.LNX.4.33.0110101605120.733-100000@base.torri.linux>
Message-ID: <Pine.LNX.3.95.1011010162500.21306A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Stephen Torri wrote:

> 
> I have installed and used kernel-2.4.10-ac10 on a SMP system (Dual P3)
> using 768 MB Ram. Yet on startup of the system (RedHat 7.0), the system
> resources are almost all used. Here are the files started:
> 

> Here is the report of the memory (free -m):
>              total       used       free     shared    buffers     cached
> Mem:           751        662         89          0        564         18
> -/+ buffers/cache:         78        672
> Swap:          133          0        133
> 

Yep. It's fine. Memory that's not used is wasted. Therefore anything
that is "spare" is used for buffers, usually to cache the file-system
to make your hard-disk run as fast as a RAM disk.

When your task needs memory, the kernel will give some of it to you,
but not before you actually need it. That's the way virtual memory
systems work.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


