Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277414AbRJOLs7>; Mon, 15 Oct 2001 07:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277423AbRJOLst>; Mon, 15 Oct 2001 07:48:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277414AbRJOLse>; Mon, 15 Oct 2001 07:48:34 -0400
Subject: Re: [RFC] "Text file busy" when overwriting libraries
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 15 Oct 2001 12:54:19 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <m1d73pp60n.fsf@frodo.biederman.org> from "Eric W. Biederman" at Oct 15, 2001 04:11:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15t6K3-0001tK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just to reiterate I see this as a solution to two problems
> 1) It adds an additional safety check that shared libraries won't
>    mutate under you.

Which prevents a user with rights doing so deliberately. 

> 2) It allows user space access to the security policy information
>    regarding executables.  Allowing ld-linux.so to refust to
>    execute binaries, and shared libaries on a filesystem mounted
>    noexec.

Which is mostly useless anyway since anyone can write an ld-linux that
doesn't check providing the binary is readable. noexec is basically a weird
ancient unixism that is usless.

> My biggest unresolved issue is which numbers to choose for O_EXEC on
> every platform.  As the DENYWRITE code is cleaner in open than in mmap.

And the fact that open has side effects.

Alan
