Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319344AbSHVOBb>; Thu, 22 Aug 2002 10:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319346AbSHVOBa>; Thu, 22 Aug 2002 10:01:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:10116 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S319344AbSHVOB3>; Thu, 22 Aug 2002 10:01:29 -0400
Date: Thu, 22 Aug 2002 15:06:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
In-Reply-To: <200208221115.26458.marc.dietrich@physik.uni-giessen.de>
Message-ID: <Pine.LNX.4.44.0208221455490.1253-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Marc Dietrich wrote:
> On Wed, 21 Aug 2002, Hugh Dickins wrote:
> > 
> > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > just appropriate to that processor in other ways.
> 
> I used KNOPPIX on a 2 way Dell WS 530 (Xeon 2.0 GHz). This distribution has 
> CONFIG_M386 set (as most others also?) and HT was not enabled. I compiled the 
> kernel myself (same config as KNOPPIX but with CONFIG_MPENTIUM4) and HT gets 
> enabled. So is _does_ matter for which processor the kernel is optimized.

I'm surprised - perhaps the Knoppix distribution did not have SMP enabled
itself, but installed a config with CONFIG_SMP?  Or you built more recent
kernel sources (2.4.19 defaults to HT on) than the Knoppix distribution
(vanilla 2.4.18 defaults to HT off)?

It would be awkward for me to try CONFIG_M386 on our P4 Xeon, but I did
just try building a CONFIG_M586 CONFIG_SMP kernel for it, which behaved
as I expected: /proc/cpuinfo showed 4 cpus, but only 2 cpus when booted
with "noht".

Hugh

