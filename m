Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSK3UaL>; Sat, 30 Nov 2002 15:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSK3UaL>; Sat, 30 Nov 2002 15:30:11 -0500
Received: from p508B5AB3.dip.t-dialin.net ([80.139.90.179]:20932 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S267059AbSK3UaK>; Sat, 30 Nov 2002 15:30:10 -0500
Date: Sat, 30 Nov 2002 21:34:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andi Kleen <ak@muc.de>
Cc: davidm@hpl.hp.com, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       anton@samba.org, "David S. Miller" <davem@redhat.com>,
       schwidefsky@de.ibm.com, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021130213431.C27776@linux-mips.org>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au> <15844.31669.896101.983575@napali.hpl.hp.com> <20021127082918.GA5227@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021127082918.GA5227@averell>; from ak@muc.de on Wed, Nov 27, 2002 at 09:29:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 09:29:18AM +0100, Andi Kleen wrote:

> > That is not a safe assumption.  The ia64 ABI requires that a 32-bit
> > result is returned in the least-significant 32 bits only---the upper
> > 32 bits may contain garbage.  It should be safe to declare the syscall
> > return type always as "long", no?
> 
> But the 32bit user space surely doesn't care about any garbage in 
> the upper 32bits, no ?

It does.  With very few exceptions all 32-bit instructions on MIPS require
that all the register values are properly sign extended to 64-bit or the
operation of those instructions is undefined.

  Ralf
