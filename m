Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSEVNZX>; Wed, 22 May 2002 09:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSEVNZW>; Wed, 22 May 2002 09:25:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34576 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313242AbSEVNZV>; Wed, 22 May 2002 09:25:21 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 22 May 2002 13:44:17 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        davem@redhat.com (David S. Miller), paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020522122617.B16934@flint.arm.linux.org.uk> from "Russell King" at May 22, 2002 12:26:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AVTV-0001Vw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm waiting on Phil Blundell to notice - I think /dev/port may get used
> on ARM to emulate inb() and outb() from userspace; I don't look after
> glibc so shrug.
> 
> I agree however that /dev/port is a rotten interface that needs to go.

The /dev/port interface is used by various apps and its a traditional
x86 in paticular unix thing. For platforms like ARM its poorly implemented
since it ought to turn into a fraction of /dev/mem and support mmap for
speedier user space in/out emulation..
