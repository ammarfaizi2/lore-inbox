Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310252AbSCLA6c>; Mon, 11 Mar 2002 19:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310254AbSCLA6W>; Mon, 11 Mar 2002 19:58:22 -0500
Received: from mms2.broadcom.com ([63.70.210.59]:28942 "HELO mms2.broadcom.com")
	by vger.kernel.org with SMTP id <S310252AbSCLA6F>;
	Mon, 11 Mar 2002 19:58:05 -0500
X-Server-Uuid: 2a12fa22-b688-11d4-a6a1-00508bfc9626
From: "Timothy Ngo" <tngo@broadcom.com>
To: linux-kernel@vger.kernel.org
cc: tngo@broadcom.com, gignatin@broadcom.com, gyoung@broadcom.com
Subject: Re: [BETA] First test release of Tigon3 driver
Date: Mon, 11 Mar 2002 16:57:44 -0800
Message-ID: <030801c1c960$ed24f470$f665030a@lt-ir002050.broadcom.com>
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
X-WSS-ID: 10938DC22525079-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This statement is a response to the recent negative comments about the
Broadcom Gigabit
ethernet driver by the Linux community.

Our Gigabit ethernet driver was written as a GPL'ed open source driver to
support various 2.2.x and 2.4.x Linux kernels. The primary objectives were
to support Intel
i386 and ia64 platforms and provide high performance especially in server
type
applications. The driver was also written in a way that proprietary
information about the hardware would not be unnecessarily disclosed. This is
necessary to protect our intellectual property and to keep a competitive
edge in the highly competitive Gigabit NIC marketplace.

We don't claim to be Linux experts but no one knows about our hardware more
than we do. At this point, we cannot support the Linux open source community
to write their
own driver. Doing so would require us to disclose too much proprietary
information about
our hardware and put us in a competitive disadvantage in the Gigabit
marketplace. We stronly
believe our driver is solid and provides high performance for our customers.
In one
benchmark test, we've achieved better than 1.8 Gigabit total throughput
using jumbo frames. While
our emphasis has been on Intel i386 and ia64 platforms, our recent versions
of the driver are also
known to work on PowerPC, Sparc, and alpha platforms. While we welcome any
constructive suggestions on improving our driver in anyway, we want to point
out that there are
different styles to writing a device driver, not just the style advocated by
a couple of
arrogant Linux people.

Here more details comments to the Dave Miller's email on Broadcom Driver.

> >It is meant to replace Broadcom's driver because frankly their driver
> > is junk and would never be accepted into the tree.  For an example of
> > why their driver is junk, note that the resulting object file from our
> > driver is less than half the size of Broadcom's.  That kind of bloat
> > is simply unacceptable.

[BRCM] Our driver is 117K, Intel's driver is 82K, the Altima driver is 82K.
It has
a lot of features and carries all backward compatible for all chips
including
firmware.

> > Next, Broadcom's driver is still way
> > non-portable, ioremap() pointers are still dereferenced directly among
> > other things.

[BRCM] The driver was changed to use readl/writel macro in version 2.0.31 on
12/14/01 when we started testing on other non-Intel platforms and added
big-endian support. Prior to that we only supported Intel platforms and
direct access is not a problem on Intel platforms.

> > Finally, their driver is just plain buggy, they have
> > code which tries to use page_address() on pages which are potentially
> > in highmem and that is guarenteed to oops.

[BRCM] It is true that the driver uses page_address() in one subroutine that
is
used to workaround a problem on the very early 5700 chip. But this routine
is not used at all, it was there intially to support early rev of the
silicon.
It was removed in later version of the Broadcom driver.

Regards,

Timothy Ngo



