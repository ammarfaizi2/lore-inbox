Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSLTR5N>; Fri, 20 Dec 2002 12:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSLTR5N>; Fri, 20 Dec 2002 12:57:13 -0500
Received: from nan-smtp-08.noos.net ([212.198.2.77]:14104 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S263280AbSLTR5L>;
	Fri, 20 Dec 2002 12:57:11 -0500
Message-ID: <3E035BD4.9000304@free.fr>
Date: Fri, 20 Dec 2002 19:05:08 +0100
From: Christian Gennerat <xgen@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
CC: jt@hpl.hp.com, James McKenzie <james@fishsoup.dhs.org>,
       Christian Gennerat <christian.gennerat@polytechnique.org>,
       Martin Lucina <mato@kotelna.sk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] : donauboe IrDA driver (resend)
References: <20021219024632.GB1746@bougret.hpl.hp.com>	 <1040310314.1225.9.camel@localhost.localdomain>	 <20021219185630.GC6703@bougret.hpl.hp.com> <1040381739.1084.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I am not on LKML, I have not seen your
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0212.2/0900.html
only Jean's reply.

Your problem is the same as Martin Lucina had, and I can reply the same as
Martin Lucina a écrit:

> kern.log:Oct 25 20:06:12 localhost kernel: 
> TSTST<3>toshoboeprobe(1152000) failed filter test
>
> That's an almost 50/50 failure rate, by a completely unscientific
> estimate.
> Is the self test actually neccessary for the chip to function? If not,
> is there much point in having it enabled, at least as far as 2.4.x is
> concerned?
>
>  
>
The test shows that there is a deep misunderstanding of how works
MIR mode, and chaining blocks for optimization at MIR mode.
some people say "MIR works" . That is good for them.
I would prefer to have "#undef USE_MIR"

So, test is not necessary for every day use. Just put
options donauboe do_probe=0
in your /etc/modules.conf





