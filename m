Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUDEPu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 11:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUDEPu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 11:50:28 -0400
Received: from ip68-230-241-33.sd.sd.cox.net ([68.230.241.33]:57266 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262882AbUDEPuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 11:50:24 -0400
Date: Mon, 5 Apr 2004 08:50:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian Kujau <evil@g-house.de>
Cc: Sven Hartge <hartge@ds9.gnuu.de>, linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
Message-ID: <20040405155022.GL31152@smtp.west.cox.net>
References: <20040329151515.GD2895@smtp.west.cox.net> <Pine.GSO.4.44.0403301430180.12030-100000@math.ut.ee> <E1B8OEW-0006Jb-BX@ds9.argh.org> <40704743.3000909@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40704743.3000909@g-house.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 07:34:59PM +0200, Christian Kujau wrote:

> [ cc'ing linuxppc-dev ]
> 
> Sven Hartge wrote:
> | Meelis Roos <mroos@linux.ee> wrote:
> |
> |
> |>>Ok.  Can both of you try the following patch on top of the version
> |>>which fails?
> |
> |
> |>Tried it on top of fresh 2.6.5-rc3, no changes, it still hangs.
> |
> |
> | Same here, still totally dead after tftp.
> 
> not so dead here. 2.6.4 is ok, 2.6.5-rc1|2|3 are loaded within the OF
> menu, but no bootprompt appears. but: i can hear the scsi disk
> initalizing, short after this, the atkbd is recognized and the LEDs on
> my keyboard are flashing. then again my nfs-root is supposed to be
> mounted, but my PReP still locks up completely upon network-init. (last
> working is still 2.5.30).

OK, hmm.  I've got some better ideas then.  It sounds like the code to
have puts show up on VGA isn't selected/compiled in.  Or, there's still
some other problem wrt the OF transition code.  Just having a serial
console selected still doesn't give output however, right?

> another issue here: i was finally able to cross-compile 2.5.x / 2.6.x
> kernels (on x86). i tried to compile kernels from 2.5.21 on with
> "allnoconfig" (was introduced in 2.5.21). only 2.5.30 can be built, all
> other attempts to build "zImage" fail...(still compiling 2.5.6x)...
> (full logs of builds available...)

The simple answer is, don't use allnoconfig :).  Do a 'make
common_defconfig' and then from there turn off stuff you don't need.

-- 
Tom Rini
http://gate.crashing.org/~trini/
