Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSDENif>; Fri, 5 Apr 2002 08:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312603AbSDENi0>; Fri, 5 Apr 2002 08:38:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49283 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312590AbSDENiP>; Fri, 5 Apr 2002 08:38:15 -0500
Date: Fri, 5 Apr 2002 08:39:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Arnvid Karstad <arnvid@karstad.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems rebooting from linux to windows...
In-Reply-To: <20020405130948.17108.qmail@nextgeneration.speedroad.net>
Message-ID: <Pine.LNX.3.95.1020405083239.21764A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Arnvid Karstad wrote:

> Hi, 
> 
> recently I've seen a few problems with several laptops and if one are so 
> unfortunate that one needs to reboot into Windows after a session in linux.
> Normal restart of windows never have a problem on the same machines, but if 
> you go from Linux to for instance Windows by shutdown -r or reboot it will 
> freeze half way into the booting process. 
> 
> A power cycle will hower fix this. 
> 
> Anyone got an idea about where to start looking? 
> 
> Best regards 
> 
> Arnvid Karstad

I have this same problem on my Compaq Presario. I think that this
is because the BIOS was shadowed and used some writable-RAM somewhere.
Linux seems to do a 'warm-boot'. The result being that some of the
stuff that the BIOS counts on was wiped out by Linux, i.e.,
stuff from E000:0000 -> E000:FFFF (the BIOS is normally at F000:0000).

My 'fix' is to cold-boot, i.e., processor reset during the shutdown.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

