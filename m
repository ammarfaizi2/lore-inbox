Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbQKQReM>; Fri, 17 Nov 2000 12:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129578AbQKQReC>; Fri, 17 Nov 2000 12:34:02 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2314 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129529AbQKQRdy>;
	Fri, 17 Nov 2000 12:33:54 -0500
Message-ID: <3A1564D9.2AC70F6F@mandrakesoft.com>
Date: Fri, 17 Nov 2000 12:03:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171658.QAA01331@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Jeff Garzik writes:
> > If XFree86 not fbdev is using the hardware, you can always have a stub
> > driver that does nothing but reserve the ports.  Remember, too, that the
> > ports claimed depend on register settings in the video card and PCI
> > config space..
> 
> I wish.  Unfortunately, ones of this nature tend to be rather fixed.  No amount
> of config space twiddling will move them.  However, as someone else pointed out,
> x86 gets around this problem by only allowing IO ports to be allocated in the
> (addr & 0x0300) == 0 range, thereby avoiding the problem.

Dig through the video card docs, even older ISA video cards let you
disable I/O decoding on all but a few ports, and/or relocate the ports
it does use to other areas.  Different with every video card, of course,
but most of them can do this to a greater or lesser extent.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
