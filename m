Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130839AbQKQR3W>; Fri, 17 Nov 2000 12:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130890AbQKQR3M>; Fri, 17 Nov 2000 12:29:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9491 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130839AbQKQR3A>;
	Fri, 17 Nov 2000 12:29:00 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171658.QAA01331@raistlin.arm.linux.org.uk>
Subject: Re: VGA PCI IO port reservations
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Fri, 17 Nov 2000 16:58:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mj@suse.cz
In-Reply-To: <3A15623E.5F21E230@mandrakesoft.com> from "Jeff Garzik" at Nov 17, 2000 11:52:14 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Russell King wrote:
> > Jeff Garzik writes:
> > > > For example, S3 cards typically use:
> > > >
> > > >  0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
> > > >  0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
> > > >  0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8,
> > > >  0xff00 - 0xff44
>
> If XFree86 not fbdev is using the hardware, you can always have a stub
> driver that does nothing but reserve the ports.  Remember, too, that the
> ports claimed depend on register settings in the video card and PCI
> config space..

I wish.  Unfortunately, ones of this nature tend to be rather fixed.  No amount
of config space twiddling will move them.  However, as someone else pointed out,
x86 gets around this problem by only allowing IO ports to be allocated in the
(addr & 0x0300) == 0 range, thereby avoiding the problem.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
