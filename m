Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314385AbSD0Syt>; Sat, 27 Apr 2002 14:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314392AbSD0Sys>; Sat, 27 Apr 2002 14:54:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16146 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314385AbSD0Syr>; Sat, 27 Apr 2002 14:54:47 -0400
Subject: Re: spinlocking between user context / tasklet / tophalf question
To: george@mvista.com (george anzinger)
Date: Sat, 27 Apr 2002 20:13:26 +0100 (BST)
Cc: emmanuel_michon@realmagic.fr (Emmanuel Michon),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CC9816B.88C080A3@mvista.com> from "george anzinger" at Apr 26, 2002 09:33:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171XdO-0000Nv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tasklets are run in interrupt context.  You need the irq versions of the

Not always. Ksoftirqd...


> spinlock in kernel space.  In tasklet space a simple spinlock should be
> enough as the tasklet can not be reentered.

That depends what you are locking against.
