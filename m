Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131768AbQJ2Oz2>; Sun, 29 Oct 2000 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbQJ2OzT>; Sun, 29 Oct 2000 09:55:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3368 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131768AbQJ2OzL>; Sun, 29 Oct 2000 09:55:11 -0500
Subject: Re: guarantee_memory() syscall?
To: moth@magenta.com (Raul Miller)
Date: Sun, 29 Oct 2000 14:56:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <972824256.eb26eb5e@magenta.com> from "Raul Miller" at Oct 29, 2000 08:03:35 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13ptsj-000677-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anyone tell me about the viability of a guarantee_memory() syscall?
> [I'm thinking: it would either kill the process, or allocate all virtual
> memory needed for its shared libraries, buffers, allocated memory, etc.
> Furthermore, it would render this process immune to the OOM killer,
> unless it allocated further memory.]

Hack mode on:

Allocate an array of pages the required size and attach them to a process via
a device and mmap(). Basically you are just wanting to do private unswappable
pages so grab free pages in kernel memory and mmap them


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
