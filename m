Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSE1MTL>; Tue, 28 May 2002 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSE1MTK>; Tue, 28 May 2002 08:19:10 -0400
Received: from buffy.commerce.uk.net ([213.219.35.201]:62955 "EHLO
	buffy.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S314277AbSE1MTK>; Tue, 28 May 2002 08:19:10 -0400
Date: Tue, 28 May 2002 13:19:08 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: <linux-kernel@vger.kernel.org>
Subject: bluesmoke, machine check exception, reboot
Message-ID: <Pine.LNX.4.33L2.0205281301440.27799-100000@buffy.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I have a Dual PIII-1000 running 2.4.18, and am occasionally getting the
following error:

> CPU 1: Machine Check Exception: 000000000000000004
> Bank 1: f200000000000115
> Kernel panic: CPU context corrupt

This results in a hard lock (unable to use magic SysRQ key to sync or
reboot, etc). I located these errors in arch/i386/kernel/bluesmoke.c in
the function intel_machine_check(). From what I have read on lkml it is
probably a result of the processor overheating and causing errors.

I intend to add another fan to stop this from happening, but in the
meantime is there anything I can do to get the machine to reboot after the
panic? After the last time that this happened, I set
/proc/sys/kernel/panic to 10, but it hasn't happened since then so I can't
tell whether it will work. The error listed above is the entire error
before the machine fails - there is no register dump or anything after
that.

Do you think it will manage to reboot with a hopelessly confused
processor?

Thanks,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        |
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/


