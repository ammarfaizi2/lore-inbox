Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbQJ3XDM>; Mon, 30 Oct 2000 18:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129068AbQJ3XDC>; Mon, 30 Oct 2000 18:03:02 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25869 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129203AbQJ3XCr>;
	Mon, 30 Oct 2000 18:02:47 -0500
Message-ID: <39FDFE0A.BB9691E6@mandrakesoft.com>
Date: Mon, 30 Oct 2000 18:02:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Keith Owens <kaos@ocs.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
In-Reply-To: <Pine.LNX.4.10.10010301447490.1085-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 31 Oct 2000, Keith Owens wrote:
> >
> > obj-y is used together with export-objs to split objects into O_OBJS
> > (no export symbol) and OX_OBJS (export symbol).  If usbcore.o (multi)
> > is not replaced by its components then usb.o (in export-objs) is not
> > added to OX_OBJS so usb.c gets compiled with the wrong flags which
> > causes incorrect module symbols.  Multi's in obj-y have to replaced by
> > their components before being split into O_OBS and OX_OBJS.
> 
> Your honour, I object.
> 
> What would be wrong with just splitting it the other way, ie make OX_OBJS
> be the expanded (but not ordered) list?
> 
> That should take care of it, no?

As an aside:  remember you mentioned we should try to go 100% OX_OBJS
anyway, eliminating O_OBJS completely...

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
