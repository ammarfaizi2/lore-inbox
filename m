Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSGBH7G>; Tue, 2 Jul 2002 03:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSGBH7F>; Tue, 2 Jul 2002 03:59:05 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:13580 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S316672AbSGBH7E>; Tue, 2 Jul 2002 03:59:04 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 (and maybe earlier versions) can't see my IDE disks where 2.2 can
References: <Pine.LNX.4.10.10207010048040.10213-100000@master.linux-ide.org>
X-Emacs: if it payed rent for disk space, you'd be rich.
From: Nix <nix@esperi.demon.co.uk>
Date: 02 Jul 2002 08:50:24 +0100
In-Reply-To: <Pine.LNX.4.10.10207010048040.10213-100000@master.linux-ide.org>
Message-ID: <87vg7yr2kf.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Economic Science)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Andre Hedrick spake:
> Lemme guess PDC5030 or 4030

I've just tried with that driver and append="ide0=dc4030". No joy:
identical output to the `normal' ide.c case (i.e. controller found, but
no drives found), and no mention of `Promise caching controller'
anywhere in the output. I guess my ancient Promise isn't one of those
after all. (Again, not *all* that surprising: this disk controller is
older than Linux...)

:(

I'll scatter a bunch of printk's through the code in 2.2 and 2.4
ide-probe.c and see what happens in 2.2 versus 2.4 probing; it'll be
tomorrow before that's doable though because I can only reboot the
machine in the early morning when nobody else is around.

(The code in ide-probe.c is very divergent anyway, but this might give
me, or someone else, *some* clue.)

-- 
`What happened?'
                 `Nick shipped buggy code!'
                                             `Oh, no dinner for him...'
