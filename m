Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbRGTETp>; Fri, 20 Jul 2001 00:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266557AbRGTETf>; Fri, 20 Jul 2001 00:19:35 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:9735
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S266546AbRGTETX>; Fri, 20 Jul 2001 00:19:23 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200107200406.f6K46xf19982@www.hockin.org>
Subject: Re: MTD compiling error
To: kiwiunix@ihug.co.nz (Matthew Gardiner)
Date: Thu, 19 Jul 2001 21:06:59 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01072015593400.19180@kiwiunix.ihug.co.nz> from "Matthew Gardiner" at Jul 20, 2001 03:59:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> /usr/src/linux-2.4.6/include/linux/mtd/cfi.h: In function `cfi_spin_unlock':
> /usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: `do_softirq' undeclared 
> (first use in this function)
> /usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: (Each undeclared identifier 
> is reported only once
> /usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: for each function it 
> appears in.)
> make[3]: *** [cfi_probe.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd/chips'
> make[2]: *** [_modsubdir_chips] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd'
> make[1]: *** [_modsubdir_mtd] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.6/drivers'
> make: *** [_mod_drivers] Error 2
> [root@kiwiunix linux]#
> 
> After adding #include <spinlock.h> in the CFI.h header file, the result was 
> that there is a undeclared identifier. Since I don't know C (Only java, BBC 
> Basic, and COBOL), I don't know how to correct the problem.


include <linux/interrupt.h> I believe.  It is fixed in MTD's CVS

