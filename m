Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRGSKzb>; Thu, 19 Jul 2001 06:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbRGSKzV>; Thu, 19 Jul 2001 06:55:21 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:62728 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S267520AbRGSKzQ>;
	Thu, 19 Jul 2001 06:55:16 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 19 Jul 2001 12:54:43 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: bitops.h ifdef __KERNEL__ cleanup.
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.40
Message-ID: <911753F4952@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 18 Jul 01 at 23:54, David Woodhouse wrote:

> Not all architectures put clear_bit et al in asm/bitops.h in a form which 
> is usable from userspace. Yet because it happens to work on a PeeCee, 
> people do it anyway. 

Please do not do this. At least ncpfs checks for usability of these
ops from its configure script, and if they are not available/usable, 
it reverts to pthread mutex based implementation, which is slower 
dozen of times. Same applies for atomic_* functions.

I think that you should complain to userspace authors who do not
check for bitops existence and not force other to distrbute 8+ versions
of bitops.h with their application, together with infrastructure for
selecting correct version...

Just my 0.02c.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
