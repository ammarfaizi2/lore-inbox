Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264644AbTIDEKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbTIDEKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:10:23 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:13187 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264644AbTIDEKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:10:17 -0400
Date: Wed, 3 Sep 2003 21:37:55 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Jamie Lokier <jamie@shareable.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030903132932.GA21530@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie,
	Just wondered if the store buffer is snooped in some 
architectures. In that case I believe the OS need not do anything for 
serialization (except for aliases, if they do not hit the same cache line). 
In x86 store buffer is not snooped which leads to all these serialization 
issues (other CPUs looking at stale value of data which is in the store 
buffer of some other CPU).
Pl correct me if I have got anything wrong/

Thanx,
tomar



 On Wed, 3 Sep 2003, Jamie Lokier wrote:

> Geert Uytterhoeven wrote:
> > > BTW the 020/030 caches are VIVT (and also only writethrough), the
> 040/060 
> > > caches are PIPT.
> > 
> > That explains a bit. But the '060 stores are coherent, while the '040
> stores
> > aren't.
> 
> The L1 cache is coherent on the '040 according to the results.  It's
> the store buffer snooping which fails.  Presumably the CPU core is
> looking ahead at recent writes comparing just virtual addresses.
> 
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

