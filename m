Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319354AbSHVOdH>; Thu, 22 Aug 2002 10:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319355AbSHVOdG>; Thu, 22 Aug 2002 10:33:06 -0400
Received: from hermes.hrz.uni-giessen.de ([134.176.2.15]:52220 "EHLO
	hermes.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id <S319354AbSHVOdG> convert rfc822-to-8bit; Thu, 22 Aug 2002 10:33:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Hyperthreading
Date: Thu, 22 Aug 2002 16:36:54 +0200
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44.0208221455490.1253-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0208221455490.1253-100000@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208221636.54108.marc.dietrich@physik.uni-giessen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 22. August 2002 :06 schrieben Sie:
> On Thu, 22 Aug 2002, Marc Dietrich wrote:
> > On Wed, 21 Aug 2002, Hugh Dickins wrote:
> > > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > > just appropriate to that processor in other ways.
> >
> > I used KNOPPIX on a 2 way Dell WS 530 (Xeon 2.0 GHz). This distribution
> > has CONFIG_M386 set (as most others also?) and HT was not enabled. I
> > compiled the kernel myself (same config as KNOPPIX but with
> > CONFIG_MPENTIUM4) and HT gets enabled. So is _does_ matter for which
> > processor the kernel is optimized.
>
> I'm surprised - perhaps the Knoppix distribution did not have SMP enabled
> itself, but installed a config with CONFIG_SMP?  Or you built more recent
> kernel sources (2.4.19 defaults to HT on) than the Knoppix distribution
> (vanilla 2.4.18 defaults to HT off)?

I don't think so. Original kernel gives me 2 penguins and cpuinfo shows 2 
cpu's. Kernel is 2.4.19 with xfs patches and there is no "noht" option. I 
attached a dmesg file of this one. Btw, setting the processor also sets some 
other options (CMPXCHG, TCS, PGE, ...).

> It would be awkward for me to try CONFIG_M386 on our P4 Xeon, but I did
> just try building a CONFIG_M586 CONFIG_SMP kernel for it, which behaved
> as I expected: /proc/cpuinfo showed 4 cpus, but only 2 cpus when booted
> with "noht".

Give it a try. A dual Xeon won't take to much time to compile a new kernel ;)

Greetings

Marc

-- 
Marc Dietrich

