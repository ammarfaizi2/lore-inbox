Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131168AbRAAAn3>; Sun, 31 Dec 2000 19:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbRAAAnK>; Sun, 31 Dec 2000 19:43:10 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:25384 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S130147AbRAAAmw>; Sun, 31 Dec 2000 19:42:52 -0500
Message-ID: <3A4FCB47.CBDA7CC0@xmission.com>
Date: Sun, 31 Dec 2000 17:11:51 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Hoyle <tmh@magenta-netlogic.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, J Sloan <jjs@pobox.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tdfx.o and -test13
In-Reply-To: <E14CrTQ-0000BD-00@the-village.bc.nu> <3A4FC3E6.47ECDA64@magenta-netlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle wrote:

> Alan Cox wrote:
> >
> > I see modversions.h being included properly on the command line
>
> Me too..
>
> make[3]: Entering directory `/usr/src/linux/drivers/char/drm'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linux/include/linux/modversions.h   -c -o agpsupport.o
> agpsupport.c
> In file included from agpsupport.c:1:
> /usr/src/linux/include/linux/modversions.h:3: warning: ignoring pragma:
> "Modversions included
>
> Modversions *is* being included... putting a message into the header
> file shows it to be correctly included at compile time.  However by the
> time the C file is processed it the symbols it has defined appear to no
> longer exist.  When you put the patch into drmP.h it never re-includes
> modversions (the pragma is not hit, because _LINUX_MODVERSIONS_H is
> already defined) *but* the macros within it suddenly become active.
>
> I'm confused!
>
> Preprocessor bug?  Demon possessed compiler?

No, the pre-y2k+1 bug of course.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
