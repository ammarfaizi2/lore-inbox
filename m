Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVD2Osi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVD2Osi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVD2Oqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:46:49 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:8916 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262755AbVD2Oo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:44:59 -0400
Date: Fri, 29 Apr 2005 16:44:14 +0200
To: Andi Kleen <ak@suse.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, coywolf@lovecn.org, coywolf@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429144414.GL18972@puettmann.net>
References: <20050427140342.GG10685@puettmann.net> <20050427152704.632a9317.rddunlap@osdl.org> <20050428090539.GA18972@puettmann.net> <20050428084313.1e69f59d.rddunlap@osdl.org> <2cd57c90050428093851785879@mail.gmail.com> <20050428094721.4499f861.rddunlap@osdl.org> <20050429142947.GD21080@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429142947.GD21080@wotan.suse.de>
User-Agent: Mutt/1.5.9i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1DRWj0-0002HB-00*nsy9MKxxIjU* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 04:29:47PM +0200, Andi Kleen wrote:
> 
> late_time_init is not in my tree. Someone else must have submitted it.
> iirc it was a workaround for some race in the NMI watchdog setup, but
> that has since then be properly fixed.
> 

It is in 2.6.11.7 :

root@dl380g3:[/mnt/kerneltest/linux-2.6.11.7] > grep -r late_time_init *
arch/mips/pmc-sierra/yosemite/setup.c:extern void
(*late_time_init)(void);
arch/mips/pmc-sierra/yosemite/setup.c:static void __init
py_late_time_init(void)
arch/mips/pmc-sierra/yosemite/setup.c:  late_time_init =
py_late_time_init;
arch/mips/vr41xx/nec-cmbvr4133/setup.c:extern void
(*late_time_init)(void);
arch/mips/vr41xx/nec-cmbvr4133/setup.c: late_time_init =
vr4133_serial_init;
arch/i386/kernel/time.c:extern void (*late_time_init)(void);
arch/i386/kernel/time.c:                late_time_init = hpet_time_init;
arch/ppc/platforms/sbc82xx.c:extern void (*late_time_init)(void);
arch/ppc/platforms/sbc82xx.c: * late_time_init() is call after paging
init.
arch/ppc/platforms/sbc82xx.c:   late_time_init          =
sbc82xx_time_init;
init/main.c:void (*late_time_init)(void);
init/main.c:    if (late_time_init)
init/main.c:            late_time_init();


                                Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
