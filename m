Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSIZPJF>; Thu, 26 Sep 2002 11:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSIZPJF>; Thu, 26 Sep 2002 11:09:05 -0400
Received: from 62-190-218-132.pdu.pipex.net ([62.190.218.132]:6661 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261368AbSIZPJD>; Thu, 26 Sep 2002 11:09:03 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209261522.g8QFMRs1001756@darkstar.example.net>
Subject: Re: A newbie's question
To: immortal1015@52mail.com (immortal1015)
Date: Thu, 26 Sep 2002 16:22:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020926144558Z261317-8740+1711@vger.kernel.org> from "immortal1015" at Sep 26, 2002 10:52:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, all. I am a newbie to Linuxe Kernel. I am reading the kernel source about bootstrap in Linux.
> I was confused by the boot.s:
> /////////////////////////////
>    	mov	ax,#BOOTSEG
> 	mov	ds,ax
> 	mov	ax,#INITSEG
> 	mov	es,ax
> 	mov	cx,#256
> 	sub	si,si
> 	sub	di,di
> 	rep
> 	movw
> 	jmpi	go,INITSEG
> /////////////////////////////
> 1. What assembly language used in boot.s? Intel Asm or AT&T?
> 2. Where is the definition of operand movw and jmpi? I cant find it in the Intel Manual.
> 
> Please give me some adivices.

I could be totally wrong here, but my understanding of the situtation is that the bootstrap was originally compiled with as86, not gas, and therefore was in the Intel format, (the standard for gas being AT&T, although Gas can also compile Intel format using the .intel_syntax pseudo-op).  I assume that the bootloader has stayed in Intel format for historical reasons.

However, I could be totally wrong.  The last assembler coding I did was on a Z80 :-).

John.
