Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRDWWdC>; Mon, 23 Apr 2001 18:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRDWWcn>; Mon, 23 Apr 2001 18:32:43 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:31244 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132479AbRDWWcO>; Mon, 23 Apr 2001 18:32:14 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200104232232.AAA12700@kufel.dom>
Subject: Re: Can't compile 2.4.3 with agcc
To: kufel!infradead.org!dwmw2@green.mif.pg.gda.pl (David Woodhouse)
Date: Tue, 24 Apr 2001 00:32:52 +0200 (CEST)
Cc: kufel!svgalib.org!matan@green.mif.pg.gda.pl (Matan Ziv-Av),
        kufel!arm.linux.org.uk!rmk@green.mif.pg.gda.pl (Russell King),
        kufel!csd.uoc.gr!papadako@green.mif.pg.gda.pl (mythos),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <2835.988060565@redhat.com> from "David Woodhouse" at kwi 23, 2001 10:16:05 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's known at compile time, but not at preprocessing time, so it can't be 
> done with #error. If you can come up with a way of doing it at compile time 
> such that:
> 
>  1. It's _guaranteed_ to work when the compiler does align the members 
> 	of the structure as we desire.
>  2. It gives a message sufficiently informative that it prevents further
> 	such reports getting to l-k.

So maybe make the original error message more informative ?
Just something like:

-             extern void __buggy_fxsr_alignment(void);
-             __buggy_fxsr_alignment();
+             extern void __BUG__task_struct__data_is_not_properly_alligned__Probably_your_compiler_is_buggy(void);
+             __BUG__task_struct__data_is_not_properly_alligned__Probably_your_compiler_is_buggy();

Andrzej
