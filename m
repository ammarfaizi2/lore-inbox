Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129620AbRAaXMx>; Wed, 31 Jan 2001 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129642AbRAaXMm>; Wed, 31 Jan 2001 18:12:42 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:21605 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129620AbRAaXMi>; Wed, 31 Jan 2001 18:12:38 -0500
Message-ID: <3A789BE0.2727B585@linux.com>
Date: Wed, 31 Jan 2001 15:12:32 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
In-Reply-To: <Pine.GSO.3.96.1010131181206.16241A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:

> On Wed, 31 Jan 2001, Alan Cox wrote:
>
> > > Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> > > 4/5 systems I have now overflow the buffer during boot before init is
> > > even launched.
> >
> > Thats just an indication that 2.4.x is currently printking too much crap on
> > boot
>
>  We could probably get rid of much of the crap for i386 by #undef
> APIC_DEBUG in include/asm-i386/apic.h.  Too bad broken SMP systems get
> reported every now and then and the crap proves useful in getting what
> actually is wrong.

The largest bodies of text come from scsi, irda, usb, and udf.

The LP/parport could stand being trimmed too.

The fatfs barfs out bogus cluster size messages when I don't have any FAT type
filesystems.

Question is, If I submit patches to tidy up the boot messages, when will(can)
they be applied?  2.4 or 2.5?

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
