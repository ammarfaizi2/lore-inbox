Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269205AbUINId3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269205AbUINId3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269243AbUINId3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:33:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34055 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269205AbUINIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:30:18 -0400
Date: Tue, 14 Sep 2004 09:29:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
Message-ID: <20040914092951.A15258@flint.arm.linux.org.uk>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <414551FD.4020701@kegel.com> <20040913091534.B27423@flint.arm.linux.org.uk> <4145BB30.60309@kegel.com> <20040913195119.B4658@flint.arm.linux.org.uk> <41464C8E.3060004@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41464C8E.3060004@kegel.com>; from dank@kegel.com on Mon, Sep 13, 2004 at 06:42:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 06:42:38PM -0700, Dan Kegel wrote:
> Russell King wrote:
> > If you want something that's guaranteed to work, use one of the
> > per-platform default configurations.  Nothing else carries any
> > guarantee what so ever on ARM.
> 
> I did give that a shot, but every one I tried seemed to be
> broken.  (I may have been using a too-new compiler, and I probably
> suffer from impatient newbie-itis.)  Can you suggest which commands
> to use to retrieve a working default configuration?

Obviously I can't comment on the problems you're seeing with those due
to the lack of details.  However, last time I built a pure bk-based
tree (4 days ago), the following worked:

- ebsa110
- netwinder
- imx
- integrator
- lubbock
- rpc
- s3c2410
- versatile

However, many of these have sub-classes of either cpus or machines,
and running allnoconfig against these will again generate invalid
configurations.

So:

$ make netwinder_defconfig
$ make

will build a working kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
