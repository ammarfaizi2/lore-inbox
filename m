Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313604AbSDEVSJ>; Fri, 5 Apr 2002 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313606AbSDEVR7>; Fri, 5 Apr 2002 16:17:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313604AbSDEVRs>; Fri, 5 Apr 2002 16:17:48 -0500
Date: Fri, 5 Apr 2002 16:18:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: halfdead <halfdead@daphnes.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: weird IDT issue
In-Reply-To: <Pine.LNX.4.33.0204052332440.19204-100000@daphnes.ro>
Message-ID: <Pine.LNX.3.95.1020405161422.1512A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, halfdead wrote:

> first of all, i get the correct idt base. the problem is i cannot
> dereference it, to get the interrupt entry i`m interrested in. second, i
> have tried to get the right segment by pushl %ss / popl %ds . it has the
> same behaviour. i would apreciate if you`d be more clear .. thanks in
> advance for your help.
> 
> - halfdead

Well no. All addresses in the kernel are virtual addresses. You got
a number, which seemed like the correct place, but that number does
not represent the virtual address at which it can be accessed. For
starters, take that number and OR in PAGE_OFFSET. This is a way of
cheating, it is not the correct way, but you can then dereference
the resulting pointer (for experimental use only, standard disclaimers
apply).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

