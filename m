Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbTBUTOi>; Fri, 21 Feb 2003 14:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTBUTOi>; Fri, 21 Feb 2003 14:14:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267639AbTBUTOh>; Fri, 21 Feb 2003 14:14:37 -0500
Date: Fri, 21 Feb 2003 14:25:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: nataraja kumar <hainattu@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A question on kernel stack 
In-Reply-To: <20030221180508.18214.qmail@web20206.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1030221141901.1623A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2003, nataraja kumar wrote:

> hi,
> my apologies if i am wrong. please let me know
> why does kernel use kernel stack when process jumps
> from user mode to kernel mode. why can't user stack
> be used ?
> 
> nattu.

Because if a user-stack was used, any user could crash the kernel
and take down the system.

main()
{
    __asm__ __volatile__("movl	$0x08, %esp\n");
                     /* Only enough stack to push 0 and call exit() */

    exit(0);     /* Ultimately a sys-call */
}



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


