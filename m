Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287109AbSABWkF>; Wed, 2 Jan 2002 17:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287116AbSABWkA>; Wed, 2 Jan 2002 17:40:00 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:14475 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S287109AbSABWjU>; Wed, 2 Jan 2002 17:39:20 -0500
From: Joe Buck <jbuck@synopsys.COM>
Message-Id: <200201022239.OAA21717@atrus.synopsys.com>
Subject: Re: [PATCH] C undefined behavior fix
To: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 2 Jan 2002 14:39:13 -0800 (PST)
Cc: VANDROVE@vc.cvut.cz (Petr Vandrovec), pkoning@equallogic.com (Paul Koning),
        trini@kernel.crashing.org, velco@fadata.bg,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <21991.1010010254@redhat.com> from "David Woodhouse" at Jan 02, 2002 10:24:14 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VANDROVE@vc.cvut.cz said:
> > (and for CONSTANT < 5 it of course generated correct code to fill dst
> > with string contents; and yes, I know that code will sigsegv on run
> > because of dst is not initialized - but it should die at runtime, not
> > at compile time). 
> 
> An ICE, while it's not quite what was expected and it'll probably get fixed,
> is nonetheless a perfectly valid implementation of 'undefined behaviour'.

Not for GCC it isn't.  Our standards say that a compiler crash, for any
input whatsoever, no matter how invalid (even if you feed in line noise),
is a bug.  Other than that we shouldn't make promises, though the old gcc1
behavior of trying to launch a game of rogue or hack when encountering a
#pragma was cute.


