Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSJWLy6>; Wed, 23 Oct 2002 07:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSJWLy5>; Wed, 23 Oct 2002 07:54:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:902 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264844AbSJWLy4>; Wed, 23 Oct 2002 07:54:56 -0400
Date: Wed, 23 Oct 2002 08:02:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Grothe <dave@gcom.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I386 cli
In-Reply-To: <5.1.0.14.2.20021022145759.02861ec8@localhost>
Message-ID: <Pine.LNX.3.95.1021023075834.11763A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, David Grothe wrote:

> In 2.5.41every architecture except Intel 386 has a "#define cli 
> <something>" in its asm-arch/system.h file.  Is there supposed to be such a 
> define in asm-i386/system.h?  If not, where does the "official" definition 
> of cli() live for Intel?  Or what is the include file that one needs to 
> pick it up?  I can't find it.
> Thanks,
> Dave

Grep for 'spin_lock'.  You can't just use `cli` alone. It won't protect
the critical section. You probably need:

	spin_lock_irqsave(&lock, flags);
        //.... critical section
	spin_unlock_irqrestore(&lock, flags);


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


