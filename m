Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQK3HCB>; Thu, 30 Nov 2000 02:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQK3HBu>; Thu, 30 Nov 2000 02:01:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50449 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129507AbQK3HBe>;
        Thu, 30 Nov 2000 02:01:34 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011300036.eAU0aTc05028@flint.arm.linux.org.uk>
Subject: Re: PATCH  - kbuild documentation.
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Thu, 30 Nov 2000 00:36:28 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        linux-kbuild@torque.net
In-Reply-To: <14885.37565.611695.816426@notabene.cse.unsw.edu.au> from "Neil Brown" at Nov 30, 2000 10:35:25 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
> +	An example for libraries from drivers/acorn/scsi/Makefile:

This is no longer true; you'll have to find another example.

> +	As ordering is not so important in libraries, this still uses
> +	LX_OBJS and MX_OBJS, though (presumably) it could be changed to
> +	use MIX_OBJS as follows:
> +
> +		active-objs	:= $(sort $(obj-y) $(obj-m))
> +		L_OBJS		:= $(obj-y)
> +		M_OBJS		:= $(obj-m)
> +		MIX_OBJS	:= $(filter $(export-objs), $(active-objs))
> +
> +	which is clearly shorted and arguably clearer.

What if you have

obj-$(CONFIG_FOO) += foo.o foobar.o
obj-$(CONFIG_BAR) += bar.o foobar.o

and CONFIG_FOO=y and CONFIG_BAR=m?  What about CONFIG_FOO=y and
CONFIG_BAR=y?  Do we still support this method?  If not, what is the
recommended way of doing this sort of stuff?
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
