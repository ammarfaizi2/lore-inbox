Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSHHS6i>; Thu, 8 Aug 2002 14:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSHHS6i>; Thu, 8 Aug 2002 14:58:38 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:18953 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317862AbSHHS6h>;
	Thu, 8 Aug 2002 14:58:37 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Thu, 8 Aug 2002 21:01:36 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Part 2: Re: [PATCH] pdc20265 problem.
CC: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
X-mailer: Pegasus Mail v3.50
Message-ID: <17337971375@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 02 at 11:43, Andre Hedrick wrote:
> On Thu, 8 Aug 2002, Petr Vandrovec wrote:
> > On  8 Aug 02 at 10:41, Andre Hedrick wrote:
> > 
> > > ide0 at 0xdfe0-0xdfe7,0xdfae on irq 31
> > > ide1 at 0xdfa0-0xdfa7,0xdfaa on irq 31
> > > ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
> > 
> > This is definitely bug. It should assigned ide0 to the port
> > in legacy mode, as far as I can tell.
> 
> Again you have no experience in the logic!
> 
> This boots with Promise first because of BIOS Logic with INT19 hooks.
> IE, that which I referenced in the documents that I know you did not read
> but come back and state it has nothing to do with the issues.

> Electrons wasted :-/

Yes, exactly. If you really believe that ide# (or even hd#) numbering 
should change according to the BIOS boot order, then there is certainly 
nothing we can agree on. And if I boot from floppy or SCSI, should IDE
code skip ide0/hda at all?

Maybe you did not notice that Linux can boot of /dev/hde, it does not 
have to boot from /dev/hda. Just tell to LILO where /dev/hde lives (and 
there are patches for EDD support, but adding two lines into /etc/lilo.conf 
is easier than patching support for EDD structure, which is broken in 50% 
of BIOSes I know anyway).
                                                    Petr
                                                    
