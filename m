Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbQKBD1W>; Wed, 1 Nov 2000 22:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130527AbQKBD1L>; Wed, 1 Nov 2000 22:27:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:32270 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130487AbQKBD0x>;
	Wed, 1 Nov 2000 22:26:53 -0500
Message-ID: <3A00DEDC.634E46CE@mandrakesoft.com>
Date: Wed, 01 Nov 2000 22:26:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <E13r6lL-0000w4-00@the-village.bc.nu> <3A00BF7F.5C7CB1D7@mandrakesoft.com> <20001102034703.B766@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On Thu, 02 Nov 2000 02:12:31 Jeff Garzik wrote:
> >>
> > You're not changing 2.4.x to use kgcc, are you?  It seems to be working
> > fine under gcc 2.95.2+fixes...
> >
> 
> What means "using kgcc" ?

Alan has a script in 2.2.x which attempts to find the best compiler for
building your kernel.  It looks for kgcc first, IIRC.

Alan's message wasn't clear, but it seemed to imply that a patch to add
this script to 2.4.x would be submitted to Linus.  gcc 2.95.2 is a bit
smarter about some things, and I definitely prefer using that compiler. 
I also prefer fixing 2.4.x kernel<->compiler bugs rather than defaulting
people to an older compiler.


> Think of packages like ALSA drivers grepping or analizing the kernel Makefile
> to find that options are -fomit-frame-pointer -malign=xxxx and so on.
> And that options can change from version to version of gcc.
> Simpler: build a script (what kgcc is). An external module package, use kgcc.

This is a totally separate issue.  Choice of compiler is but one of many
variables.  We need the build system to export all these variables, and
ALSA and other external packages will then pick up those settings for
use in their own builds.  See for example
http://gtf.org/garzik/kernel/files/patches/2.4/2.4.0-test9/external-modules-2.4.0.9.8.patch.gz

	Jeff

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
