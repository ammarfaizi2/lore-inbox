Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRISS6D>; Wed, 19 Sep 2001 14:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272873AbRISS5x>; Wed, 19 Sep 2001 14:57:53 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:20997 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S272773AbRISS5q>;
	Wed, 19 Sep 2001 14:57:46 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dan Hollis <goemon@anime.net>
Date: Wed, 19 Sep 2001 20:57:59 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
CC: <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.40
Message-ID: <3ED700D6987@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 01 at 11:43, Dan Hollis wrote:
> On Wed, 19 Sep 2001, Linus Torvalds wrote:
> > It is _probably_ an undocumented performance thing, and clearing that
> > bit may slow something down. But it might also change some behaviour,
> > and knowing _what_ the behaviour is might be very useful for figuring
> > out what it is that triggers the problem.
> 
> AFAIK noone has even tested it yet to see what it does to performance! Eg
> it might slow down memory access so that athlon-optimized memcopy is now
> slower than non-athlon-optimized memcopy. And if it turns out to be the
> case, we might as well just use the non-athlon-optimized memcopy instead
> of twiddling undocumented northbridge bits...

No, we cannot. On boxes which do not work with athlon optimized kernels
any user can execute athlon's fast_page_copy from userspace, causing
corruption on completely unrelated pages, eventually leading to
kernel crash... So you cannot allow untrusted users on such machine.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
