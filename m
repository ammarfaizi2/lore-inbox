Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSGMIQ5>; Sat, 13 Jul 2002 04:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSGMIQ4>; Sat, 13 Jul 2002 04:16:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:16758 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318121AbSGMIQz>;
	Sat, 13 Jul 2002 04:16:55 -0400
Message-Id: <5.1.0.14.2.20020713093432.00b30a20@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 13 Jul 2002 10:17:20 +0200
To: Muli Ben-Yehuda <mulix@actcom.co.il>,
       Linus Torvalds <torvalds@transmeta.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: PATCH: compile the kernel with -Werror
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020713102615.H739@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:26 AM 7/13/2002 +0300, Muli Ben-Yehuda wrote:
>A full kernel compilation, especially when using the -j switch to
>make, can cause warnings to "fly off the screen" without the user
>noticing them. For example, wli's patch lazy_buddy.2.5.25-1 of today
>had a missing return statement in a function returning non void, which
>the compiler probably complained about but the warning got lost in the
>noise (a little birdie told me wli used -j64).
>
>The easiest safeguard agsinst this kind of problems is to compile with
>-Werror, so that wherever there's a warning, compilation
>stops. Compiling 2.5.25 with -Werror with my .config found only three
>warnings (quite impressive, IMHO), and patches for those were sent to
>trivial@rusty.

If you put -Werror in the stock flags, things like gcc warning that feature-foo
will go away someday becomes deadly.. bad idea IMO.

If people are building kernels (or anything else) and not making/checking
logs, they're wrong.

         -Mike 

