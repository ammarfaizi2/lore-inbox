Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268961AbRG0UCj>; Fri, 27 Jul 2001 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbRG0UC3>; Fri, 27 Jul 2001 16:02:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268959AbRG0UCK>;
	Fri, 27 Jul 2001 16:02:10 -0400
Date: Fri, 27 Jul 2001 21:02:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Hai Xu <xhai@clemson.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about libc.a libgcc.a
Message-ID: <20010727210215.B10072@flint.arm.linux.org.uk>
In-Reply-To: <000901c116cd$c67b4a40$3cac7f82@crb50>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000901c116cd$c67b4a40$3cac7f82@crb50>; from xhai@CLEMSON.EDU on Fri, Jul 27, 2001 at 02:55:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 02:55:59PM -0400, Hai Xu wrote:
> The following are my link libraries.
> #LIBS    =
> $(MATLAB_ROOT)/rtw/c/lib/$(ARCH)/lrtwLib.a -L/usr/lib/gcc-lib/i386-redhat-li
> nux/2.96 -lgcc -L/usr/lib -lm -lc $(EXT_LIB) $(S_FUNCTIONS_LIB)
> $(INSTRUMENT_LIBS)

Umm, if you're linking a kernel module, you can't:

1. link libm
2. link libc
3. use floating point in kernel

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

