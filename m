Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268129AbRHCKCz>; Fri, 3 Aug 2001 06:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268079AbRHCKCo>; Fri, 3 Aug 2001 06:02:44 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:18593 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268129AbRHCKC0>; Fri, 3 Aug 2001 06:02:26 -0400
Message-ID: <3B6A77CA.13159ED6@veritas.com>
Date: Fri, 03 Aug 2001 15:37:06 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Brent Baccala <baccala@freesoft.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel gdb for intel
In-Reply-To: <E15SJZk-0000hw-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > - doesn't support SMP, since I don't have an Intel SMP box.  I'd guess
> > what you'd want it to do is an smp_call_function that would halt all the
> > processors and put them into some tight little loop while gdb fiddles
> > things.  ideas?
> 
> With the old old stuff (pre 2.0) gdb stubs I ended up with two copies, one
> per cpu on two serial ports. I found that most useful since I could force
> events to happen.

I can't get this. How can two gdb stubs work correctly
on two serial ports? In absence of any globals, there won't be
any data corruption, though there are inherent assumptions in 
the kernel about progress on all cpus. If GKL, page cache lock etc
are held by one cpu, the other cpu will not be able to make
any/much progress.

Are two gdb stubs useful for debugging some particular kind
of problem? If they are I can think about how I can
add them to current x86 kgdb (kgdb.sourceforge.net).
-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
