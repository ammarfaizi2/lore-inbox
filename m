Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270849AbTGQS5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270848AbTGQS5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:57:14 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:4659 "EHLO
	mail-7.tiscali.it") by vger.kernel.org with ESMTP id S270539AbTGQS5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:57:07 -0400
Date: Thu, 17 Jul 2003 21:09:25 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
Subject: Re: [ACPI-sppt] Re: [2.5.75] S3 and S4
Message-ID: <20030717190925.GA6922@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
References: <20030711193611.GA824@dreamland.darkstar.lan> <20030711200053.GA402@elf.ucw.cz> <20030712164542.GA1157@dreamland.darkstar.lan> <20030712201256.GA446@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712201256.GA446@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Jul 12, 2003 at 10:12:56PM +0200, Pavel Machek ha scritto: 
> > > Unable to handle kernel paging request at virtual address 40107114
> > > >  printing eip:
> > > > 40107114
> > > > *pde = 2dbf6067
> > > > *pte = 00000000
> > > > Oops: 0004 [#1]
> > > > CPU:    0
> > > > EIP:    0073:[<40107114>]    Not tainted
> > > > EFLAGS: 00010202
> > > > EIP is at 0x40107114
> > > > eax: ffffffea   ebx: 00000001   ecx: 080d440c   edx: 00000002
> > > > esi: 00000002   edi: 080d440c   ebp: bffffae8   esp: bffffab8
> > > > ds: 007b   es: 007b   ss: 007b
> > > > Process bash (pid: 484, threadinfo=ed776000 task=ef1e40c0)
> > > >  <6>note: bash[484] exited with preempt_count 1
> > > > pdflush left refrigerator
> > > > e100: eth0 NIC Link is Up 10 Mbps Half duplex
> > > > 
> > > > ksymoops says:
> > > > 
> > > > Warning (Oops_read): Code line not seen, dumping what data is available
> > > > 
> > > > 
> > > > >>EIP; 40107114 Before first symbol   <=====
> > > > 
> > > > >>eax; ffffffea <__kernel_rt_sigreturn+1baa/????>
> > > 
> > > That's bad. Error outside of kernel. Not sure what is wrong.
> > 
> > Note that  if suspend after booting  with "single" (ie. with  only init,
> > agetty and bash running) the other warnings go away, but I still see the
> > above oops.
> 
> That's strange. It works here. I'm not sure whats wrong for you.
> 
> Also try to find out what you need to run if you want the warnings.


Bad news. I made a lot of  tests and warnings seem random... sometimes I
can  get  them  even with  init  +  agetty  +  bash. To make  them  100%
reproduceable I  just have to  run lots of  processes (15 -  20). I fear
that they are side effects of the Oops.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La teoria e` quando sappiamo come funzionano le cose ma non funzionano.
 La pratica e` quando le cose funzionano ma non sappiamo perche`.
 Abbiamo unito la teoria e la pratica: le cose non funzionano piu` e non
 sappiamo il perche`." -- A. Einstein
