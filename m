Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUHFI3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUHFI3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUHFI1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:27:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59088 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268046AbUHFI0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:26:16 -0400
Date: Fri, 6 Aug 2004 10:27:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, vda@port.imtp.ilyichevsk.odessa.ua,
       gene.heskett@verizon.net, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Possible dcache BUG
Message-ID: <20040806082728.GB8279@elte.hu>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org> <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org> <20040805180634.GA26732@elte.hu> <Pine.LNX.4.58.0408051144520.24588@ppc970.osdl.org> <20040806073739.GA6617@elte.hu> <20040806004231.143c8bd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806004231.143c8bd2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > [btw., it would be nice to dump
> >  instructions prior the crash point so that we could know precisely what
> >  prefetch instruction the kernel included.]
> 
> I've had a patch (from Keith) to do that in -mm for over a year, and
> ksymoops has supported it for that long.  But I think Linus has some
> problem-which-I-never-understood with the whole idea.

There were some more naive patches around previously i believe and those
problems are solved in this patch: the dump splits the pre-crash and
post-crash instruction stream decoding, so crash-EIP decoding is never
unreliable.

>  25-akpm/arch/i386/kernel/traps.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)

a strong ack from me.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
