Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283356AbRK2SEF>; Thu, 29 Nov 2001 13:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283359AbRK2SD4>; Thu, 29 Nov 2001 13:03:56 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:63754 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S283356AbRK2SDn>;
	Thu, 29 Nov 2001 13:03:43 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: jarmo kettunen <oh1mrr@nic.fi>
Date: Thu, 29 Nov 2001 19:02:55 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: My previous question about iwlib
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A9497EC5D6C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 01 at 16:49, jarmo kettunen wrote:
> 
> gcc -O2 -Wall -DGLIBC_HEADERS  -c iwlib.c
> In file included from iwlib.c:11:
> iwlib.h:91:8: warning: extra tokens at end of #endif directive
> iwlib.h:96:8: warning: extra tokens at end of #endif directive
> In file included from iwlib.h:42,
>                  from iwlib.c:11:
> /usr/include/linux/in.h:25: conflicting types for `IPPROTO_IP'
> /usr/include/netinet/in.h:32: previous declaration of `IPPROTO_IP'

iwlib.h (or any other userspace app) must not include <linux/*> and 
<asm/*> files. If it needs access to them for accessing ioctl API
(or anything else), maintainer must create stripped-down copy of
these headers, and distribute them with app - which is btw only
correct way, as otherwise you cannot create userspace app which
will support more than one API version (and iw used couple
of incompatible APIs in the past...).
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
