Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbVJGTHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVJGTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVJGTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:07:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15112 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030468AbVJGTHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:07:24 -0400
Date: Fri, 7 Oct 2005 20:07:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jiri Slaby <lnx4us@gmail.com>
Cc: David Vrabel <dvrabel@cantab.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] yenta: fix YENTA && !CARDBUS build
Message-ID: <20051007190710.GA22608@flint.arm.linux.org.uk>
Mail-Followup-To: Jiri Slaby <lnx4us@gmail.com>,
	David Vrabel <dvrabel@cantab.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <43414BFB.3090206@arcom.com> <43467B7A.2000903@cantab.net> <3888a5cd0510070934x39288f31m368c58e1dd59d699@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3888a5cd0510070934x39288f31m368c58e1dd59d699@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 06:34:15PM +0200, Jiri Slaby wrote:
> On 10/7/05, David Vrabel <dvrabel@cantab.net> wrote:
> > (Previous patch left a warning.)
> >
> > yenta_socket no longer builds if CONFIG_CARDBUS is disabled.  It doesn't
> > look like ene_tune_bridge is relevant in the !CARDBUS configuration so
> > I've just disabled it.
> >
> >
> > yenta: fix build if YENTA && !CARDBUS
> >
> > (struct pcmcia_socket).tune_bridge only exists if CONFIG_CARDBUS is set but
> > building yenta_socket without CardBus is valid.
> >
> This is a multi-part message in MIME format.
> 
> Are you really sure, that you have read Documentation/SubmittingPatches and
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
> Nobody wants MIMEs. Include it as plain text

You're providing misleading advice.  mimes are acceptable provided
each part is text/plain.  And some folk need to attach rather than
inline patches to prevent white space damage from broken mailers.

And indeed David's were text/plain so there isn't a problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
