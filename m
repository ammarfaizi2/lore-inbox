Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280949AbRKGTsR>; Wed, 7 Nov 2001 14:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280943AbRKGTsI>; Wed, 7 Nov 2001 14:48:08 -0500
Received: from pop.gmx.de ([213.165.64.20]:54965 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S280939AbRKGTsC>;
	Wed, 7 Nov 2001 14:48:02 -0500
Date: Wed, 7 Nov 2001 20:48:00 +0100
From: Jonas Diemer <diemer@gmx.de>
To: Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686 timer bugfix incomplete
Message-Id: <20011107204800.70b91985.diemer@gmx.de>
In-Reply-To: <20011107202546.A1939@suse.cz>
In-Reply-To: <20011107125012.6b1fbdc3.diemer@gmx.de>
	<E161RcS-0003x8-00@the-village.bc.nu>
	<20011107202546.A1939@suse.cz>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001 20:25:46 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

...
> The bug #2 can trigger the test for #1, because the timer is read just
> after the timer interrupt happens and thus the value is usually around
> 11920, which, plus 256 is larger than 11920.
> 

so why don't you simply add a new option to the config file, that says "work
around Via 686a bug"? that way, only ppl who have the bug need the fix.

...
> Only timer.c and apic.c do proper locking.
> 

well, but as I said, the workaround in arch/i386/kernel/time.c is incomplete, at
least in linus' kernel tree!

> The problem is how to work around the bugs 1) and 2) reliably and
> without too much performance impact. I haven't found a feasible way to
> do that yet.

well, just use the option described above. that way, ppl that need the fix can
choose to use it (at a cost of performance), others simply don't need checking.

-jonas

PS: CC me in your answers plz, I am not subscribed to the list.
