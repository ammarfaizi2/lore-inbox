Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263903AbRFMOpe>; Wed, 13 Jun 2001 10:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263948AbRFMOpZ>; Wed, 13 Jun 2001 10:45:25 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:50890 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263903AbRFMOpI>; Wed, 13 Jun 2001 10:45:08 -0400
Message-ID: <3B277A9A.E158910E@uow.edu.au>
Date: Thu, 14 Jun 2001 00:37:14 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
In-Reply-To: <10322.992441398@ocs4.ocs-net>,
		<15143.29246.712747.936864@pizda.ninka.net>
		<10322.992441398@ocs4.ocs-net> <15143.30453.762432.702411@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Keith Owens writes:
>  > #define my_symbol       my_symbol_versioned
>  > extern void my_symbol(void);
>  >
>  > void foo(void) { __asm__("call %0" : : "i" (my_symbol)); }
>  >
>  > # gcc -o x x.c
>  > /tmp/cclWXduj.s: Assembler messages:
>  > /tmp/cclWXduj.s:12: Error: suffix or operands invalid for `call'
> 
> I can't believe there is no reliable way to get rid of that
> pesky "$" gcc is adding to the symbol.  Oh well...

void foo(void) { __asm__("call %c0" : : "i" (my_symbol)); }
                               ^^^

-
