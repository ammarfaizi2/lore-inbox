Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275911AbSIUNQr>; Sat, 21 Sep 2002 09:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275912AbSIUNQr>; Sat, 21 Sep 2002 09:16:47 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:7671 "EHLO fed1mtao04.cox.net")
	by vger.kernel.org with ESMTP id <S275911AbSIUNQr>;
	Sat, 21 Sep 2002 09:16:47 -0400
Date: Sat, 21 Sep 2002 06:45:04 -0700
From: Matt Porter <porter@cox.net>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: can we drop early_serial_setup()?
Message-ID: <20020921064504.A31995@home.com>
References: <200209200459.g8K4xJcW011057@napali.hpl.hp.com> <20020920163357.A30546@home.com> <15755.44527.146016.975532@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15755.44527.146016.975532@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Fri, Sep 20, 2002 at 04:23:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 04:23:27PM -0700, David Mosberger wrote:
> >>>>> On Fri, 20 Sep 2002 16:33:57 -0700, Matt Porter <porter@cox.net> said:
> 
>   Matt> serial8250_ports and serial8250_pops are not static structs
>   Matt> in your tree?
> 
> It is.  The new routine (early_register_port) goes into 8250.c, so that's
> fine.

That will be fine then.  I misconstrued your first statements as
indicating that we should duplicate this code in each arch (which
I didn't like).  As far as PPC is concerned, go ahead and wipe
out early_serial_setup when you bring in early_register_port.

FWIW, there's actually been more PPC platforms than ev64260 using
early_serial_setup. They had abandoned it temporarily for a less
flexible approach due to the breakage.

Thanks,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
