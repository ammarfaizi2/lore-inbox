Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbRGICtz>; Sun, 8 Jul 2001 22:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266988AbRGICto>; Sun, 8 Jul 2001 22:49:44 -0400
Received: from smarty.smart.net ([207.176.80.102]:20231 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S266972AbRGICtc>;
	Sun, 8 Jul 2001 22:49:32 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107090303.XAA20213@smarty.smart.net>
Subject: Re: Why Plan 9 C compilers don't have asm("")
To: linux-kernel@vger.kernel.org
Date: Sun, 8 Jul 2001 23:03:05 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Victor Yodaiken <yodaiken@fsmlabs.com>
>
>I think anywhere that you have inner loop or often used operations
>that are short assembler sequences, inline asm is a win - it's easy to
>show for example, that the Linux asm x86  macro semaphore down
>is three times as fast as
>a called version. I wish, however
>that GCC did not use a horrible overly complex lisplike syntax and
>that there was a way to inline functions written in .S files.

If you can loop faster in asm, and you surely can on x86/Gcc in many
cases, that's a win, and probably quite a worthwhile one, but that's
independant of inline in terms of "not a C call". I think that distinction
may be prone to being overlooked. The longer your average loop, the less
asm("") matters, i.e. the less of a proportional hit a C stack ceremony
is. You can loop in asm and still not need asm(""), if you pay for the
stack frame. Plan 9 has about 4 string functions that are hand-coded, but
they are C-called, from what I can tell, and have been told.

Rick Hohensee
		www.clienux.com


