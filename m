Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263946AbRFMOpO>; Wed, 13 Jun 2001 10:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263935AbRFMOoy>; Wed, 13 Jun 2001 10:44:54 -0400
Received: from ns.suse.de ([213.95.15.193]:11537 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263903AbRFMOop> convert rfc822-to-8bit;
	Wed, 13 Jun 2001 10:44:45 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
In-Reply-To: <15143.29246.712747.936864@pizda.ninka.net>
	<10322.992441398@ocs4.ocs-net>
	<15143.30453.762432.702411@pizda.ninka.net>
X-Yow: Vote for ME -- I'm well-tapered, half-cocked, ill-conceived and
 TAX-DEFERRED!
From: Andreas Schwab <schwab@suse.de>
Date: 13 Jun 2001 16:44:40 +0200
In-Reply-To: <15143.30453.762432.702411@pizda.ninka.net> ("David S. Miller"'s message of "Wed, 13 Jun 2001 07:21:41 -0700 (PDT)")
Message-ID: <jek82gjv6v.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

|> Keith Owens writes:
|>  > #define my_symbol       my_symbol_versioned
|>  > extern void my_symbol(void);
|>  > 
|>  > void foo(void) { __asm__("call %0" : : "i" (my_symbol)); }
|>  > 
|>  > # gcc -o x x.c
|>  > /tmp/cclWXduj.s: Assembler messages:
|>  > /tmp/cclWXduj.s:12: Error: suffix or operands invalid for `call'
|> 
|> I can't believe there is no reliable way to get rid of that
|> pesky "$" gcc is adding to the symbol.  Oh well...

Use %c0.  *Note Output Templates and Operand Substitution: (gcc)Output
Template.


Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
