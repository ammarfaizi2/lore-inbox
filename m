Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319046AbSH1XLX>; Wed, 28 Aug 2002 19:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319047AbSH1XLX>; Wed, 28 Aug 2002 19:11:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41720 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319046AbSH1XLW>; Wed, 28 Aug 2002 19:11:22 -0400
Subject: Re: [PATCH] M386 flush_one_tlb invlpg
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208282059390.2079-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208282059390.2079-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 00:17:58 +0100
Message-Id: <1030576678.7190.80.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 21:30, Hugh Dickins wrote:
> New patch below defines cpu_has_invlpg as (boot_cpu_data.x86 > 3).
> But I do feel safer with that original cpu_has_pge test, which was
> using a decent capability flag, and only changed behaviour of the
> CONFIG_M386 __flush_tlb_one when it's necessary.
> 
> Isn't CONFIG_M386 about maximum safe applicability, rather than speed?
> Am I imagining it, or were there a few i386 + i486 SMP machines built?
> Or might there be some i486 clone which didn't really implement invlpg,
> which could be used with a CONFIG_M386 kernel before this change,
> but not after?  But perhaps I'm just dreaming up excuses for my
> senselessness - your call.

To answer that

There are no SMP i386 boxes that support Intel MP 1.1
There are a few SMP 486 boxes using MP 1.1

The nx586 processor is a '586' class CPU that has neither wp nor invlpg
by default. I believe however that it reports family '3' if it has the
hypercode loaded which lacks invlpg

