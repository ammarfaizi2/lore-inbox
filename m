Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRGNRnl>; Sat, 14 Jul 2001 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264489AbRGNRna>; Sat, 14 Jul 2001 13:43:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24077 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264447AbRGNRn3>; Sat, 14 Jul 2001 13:43:29 -0400
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 14 Jul 2001 18:44:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <3B5083AE.71515696@mandrakesoft.com> from "Jeff Garzik" at Jul 14, 2001 01:38:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LTSu-0001Vy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is a flag day change so it generates [a lot of] work once... it has
> always been policy that userspace shouldn't be including kernel
> headers.  uClibc and now dietlibc are following this policy.
> 
> IMHO we have made an exception for glibc for long enough...

Glibc includes a copy of the kernel headers it wants to get the kernel side
ABI structures not to export them to user space. Thats quite different and
attempting to maintain that seperately as well will just lead to an ever
increasing number of stupid ABI coping errors and weird bugs.

The kernel headers define syscall interfaces for the libraries. They don't
define user app interfaces. Two different things and we need __KERNEL__ to make
the former (sane) use work

