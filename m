Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUAXAtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbUAXAtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:49:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266820AbUAXAsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:48:51 -0500
Date: Sat, 24 Jan 2004 00:48:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stef van der Made <svdmade@planet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95.3
Message-ID: <20040124004848.C25466@flint.arm.linux.org.uk>
Mail-Followup-To: Stef van der Made <svdmade@planet.nl>,
	linux-kernel@vger.kernel.org
References: <20040123145048.B1082@beton.cybernet.src> <20040123100035.73bee41f.jeremy@kerneltrap.org> <20040123151340.B1130@beton.cybernet.src> <001b01c3e1ca$26101f20$1e00000a@black> <20040123163008.B1237@beton.cybernet.src> <1074882836.20723.4.camel@minerva> <4011AC22.8050903@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4011AC22.8050903@planet.nl>; from svdmade@planet.nl on Sat, Jan 24, 2004 at 12:20:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 12:20:02AM +0100, Stef van der Made wrote:
> Same here. I've been using gcc3.2.0 and beyond currently 3.3.2 since the 
> day they were released and never had any big issues. I would recomend 
> using gcc 3.3.2 since it improves performance when using optimizations 
> quite a bit as far as I can remember the statistics.

On ARM at least, gcc 3.2.x seems buggy.  It's along the lines of this:

 3.2.0: incorrect function argument offset calculation.
 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
        (http://gcc.gnu.org/PR8896) and incorrect structure
        initialisation in fs/jffs2/erase.c

I suspect that the fs/jffs2/erase.c problem is not ARM-specific, though
I'm no compiler expert.

However, gcc 3.3 seems table on ARM, and I'm not aware of any problems
with any further 3.3.x releases.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
