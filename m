Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUEJIsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUEJIsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 04:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbUEJIsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 04:48:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48139 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264569AbUEJIsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 04:48:21 -0400
Date: Mon, 10 May 2004 09:48:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6
Message-ID: <20040510094814.B27524@flint.arm.linux.org.uk>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org> <20040510083905.GA18603@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510083905.GA18603@suse.de>; from olh@suse.de on Mon, May 10, 2004 at 10:39:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 10:39:05AM +0200, Olaf Hering wrote:
>  On Sun, May 09, Linus Torvalds wrote:
> > Holler if I missed anything,
> 
> add 'chmod -Rf a+rX,o-w,g-w .' to your release scripts.

That's not really a fix.  These need to be reported as they occur
since it's BK which stores the permissions.

Maybe we can add a BK trigger to correct/fix/warn of this problem
on checkin ?

Meanwhile I'll fix up the following six:

> cp: cannot open `linux-2.6.6/arch/arm/mm/proc-v6.S' for reading: Permission denied
> cp: cannot open `linux-2.6.6/arch/arm/mm/cache-v6.S' for reading: Permission denied
> cp: cannot open `linux-2.6.6/arch/arm/mm/abort-ev6.S' for reading: Permission denied
> cp: cannot open `linux-2.6.6/arch/arm/mm/copypage-v6.c' for reading: Permission denied
> cp: cannot open `linux-2.6.6/arch/arm/mm/tlb-v6.S' for reading: Permission denied
> cp: cannot open `linux-2.6.6/arch/arm/mm/blockops.c' for reading: Permission denied

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
