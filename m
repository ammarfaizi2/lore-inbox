Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265905AbRF2PVp>; Fri, 29 Jun 2001 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265891AbRF2PVZ>; Fri, 29 Jun 2001 11:21:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55815 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265905AbRF2PVN>; Fri, 29 Jun 2001 11:21:13 -0400
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 29 Jun 2001 16:19:46 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), adam@yggdrasil.com (Adam J. Richter),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010629153036.A10196@flint.arm.linux.org.uk> from "Russell King" at Jun 29, 2001 03:30:36 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15G03e-0000Ti-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > mainline configs will be much more readable.  It also guarantees that
> > any future tests on $CONFIG_ARCH_somearch will work, even if the code
> > does not use if statements.
> 
> I'd rather that we fixed dep_* so that undefined symbols were treated as
> 'n', just like the makefiles treat undefined symbols.

That isnt a simple change. dep_tristate is used both to express 'need this'
and also 'conflicts with'. Those are ambiguous. You'd need to extend the
syntax say by adding  ${FOO:N} syntax 

