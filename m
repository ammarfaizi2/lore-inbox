Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265904AbRF3MLM>; Sat, 30 Jun 2001 08:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265906AbRF3MLC>; Sat, 30 Jun 2001 08:11:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34057 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265904AbRF3MKx>;
	Sat, 30 Jun 2001 08:10:53 -0400
Date: Sat, 30 Jun 2001 13:10:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010630131050.D12788@flint.arm.linux.org.uk>
In-Reply-To: <20010630102024.A12009@flint.arm.linux.org.uk> <3465.993901530@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3465.993901530@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Jun 30, 2001 at 09:45:30PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 09:45:30PM +1000, Keith Owens wrote:
> CONFIG_bar can be undefined, not 'n'.  While that can cause problems,
> it is also valid config code.  If I interpret AC's cryptic comments
> correctly, there may be code which assumes that undefined variables are
> just that, undefined.  Setting all variables to 'n' initially by Adam's
> script will break such code.

Agreed.   The person who should know for sure how the configuration system
works is ESR.

> I still think this is the best approach, against 2.4.5-ac22.

One small concern - does it work properly with xconfig and menuconfig?
I seem to remember that they re-evaluate choices, and I have this feeling
that I've seen unselectable symbols caused by define_bool SYM n type stuff.

Note also that we in the ARM port currently have 43 such symbols in either
Linus' or my tree, and there are getting on for 90 such symbols in existence
throughout the ARM trees.  (There are around 90 registered ARM machine types
at the moment, each one has their own CONFIG symbol).

Your config.in file could get very large. ;)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

