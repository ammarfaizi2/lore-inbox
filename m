Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129264AbQJ3WCE>; Mon, 30 Oct 2000 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbQJ3WBx>; Mon, 30 Oct 2000 17:01:53 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17163 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129264AbQJ3WBe>;
	Mon, 30 Oct 2000 17:01:34 -0500
Message-ID: <39FDEFB0.B99B7E68@mandrakesoft.com>
Date: Mon, 30 Oct 2000 17:01:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
In-Reply-To: <10135.972941843@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 30 Oct 2000 11:32:33 -0800 (PST),
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > - pre7:
> >    - Randy Dunlap, USB: printer.c, usb-storage, usb identification and
> >      memory leak fixes
> 
> USB still gets unresolved symbols when part is in kernel, part is in
> modules and modversions are set.  Patch against 2.4.0-test10-pre7, only
> affects drivers/usb/Makefile.

Or instead of all that, you could simply call the core init function
from init/main.c...

Ya know, sorting those lists causes this problem, too...  usb.o is
listed first in the various lists, as is usbcore.o.  Is it possible to
avoid sorting?  Doing so will fix this, and also any other link order
breakage like this that exists, too.

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
