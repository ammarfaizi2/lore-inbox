Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUIIQgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUIIQgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUIIQf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:35:56 -0400
Received: from [69.25.196.29] ([69.25.196.29]:17887 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266249AbUIIQff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:35:35 -0400
Date: Thu, 9 Sep 2004 09:59:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  patch)
Message-ID: <20040909135945.GC6690@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	linux-kernel@vger.kernel.org
References: <20040909114747.GC30162@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909114747.GC30162@lkcl.net>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 12:47:47PM +0100, Luke Kenneth Casson Leighton wrote:
> dear linux kernel people,
> 
> i was staggered to find that swansmart (smlink.com) have a GPL
> driver for their smart usb 56k modem.
> 
> i trust that someone will download, check it, and if
> appropriate, incorporate it into the mainstream linux kernel.

It's mostly GPL'ed, but there are binary-only objects both in the
user-mode daemon (modem/dsplibs.o) and in the kernel driver
(drivers/amrlibs.o). 

The good news is that there a completely GPL'ed, source-complete
driver already in the 2.6 kernel, sound/pci/intel8x0m.c, which will
work with the user-mode daemon found in the smlink.com distribution.
This driver doesn't have all of the functionality of slamr driver
(which requires the propietary, binary-only object file) --- most
notably, ATM1 doesn't work when using the completely open-source
intl8x0m driver.  However, it does work just fine, and so as long as
you don't mind using the propietary object file in user-space, it's a
great solution.  I've been using the smlink daemon with both the
open-source and partial-propietary driver, and both work just fine on
my T40 laptop.

						- Ted
