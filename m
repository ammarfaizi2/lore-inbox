Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSAZVlJ>; Sat, 26 Jan 2002 16:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287106AbSAZVk7>; Sat, 26 Jan 2002 16:40:59 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17427 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287045AbSAZVku>;
	Sat, 26 Jan 2002 16:40:50 -0500
Date: Sat, 26 Jan 2002 19:40:34 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hartmut Holz <hartmut.holz@arcor.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uptime again?
In-Reply-To: <3C532063.3090709@arcor.de>
Message-ID: <Pine.LNX.4.33L.0201261935330.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2002, Hartmut Holz wrote:
> Rik van Riel wrote:
>  > On Sat, 26 Jan 2002, Hartmut Holz wrote:

>  > Interesting. Could you test 2.4 -aa and 2.4 -rmap too if you
>  > have the time ? ;)
>  >
>  > (you can get -rmap and -aa from http://surriel.com/patches and
>  > kernel.org, respectively)
>
> rmap12a about 15 minutes. As far as I can remember, I tested 2.4.6,
> 2.4.14/15/16/17/18pre7, rmap11c
>
> It looks like memory corruption. lavrec stops or makes a segmentation
> fault (With a oops). After that every apps starts with a oops till the
> kernel is dead.

You're right.  While the bug is detected in the VM, chances
are it's cause is somewhere else.

The fact that lavrec crashes the machine while Xawtv works
suggests a device driver may be corrupting memory somewhere.

>  >>EIP; c013004a <rmqueue+1fa/240>   <=====
> Trace; c01301df <__alloc_pages+5f/2c0>
> Trace; c0129f4a <generic_file_write+42a/720>
> Trace; c01365a6 <sys_write+96/d0>
> Trace; c0111c8f <smp_apic_timer_interrupt+ef/120>
> Trace; c0106f3b <system_call+33/38>

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

