Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315393AbSEBTlC>; Thu, 2 May 2002 15:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315394AbSEBTlB>; Thu, 2 May 2002 15:41:01 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:5380 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315393AbSEBTk4>; Thu, 2 May 2002 15:40:56 -0400
Message-ID: <3CD19640.3B85BF76@linux-m68k.org>
Date: Thu, 02 May 2002 21:40:48 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E172yOR-00026G-00@starship> <3CD184BB.ED7F349F@linux-m68k.org> <E173LNK-00027F-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> Patching the kernel how, and where?

Check for example in asm-ppc/page.h the __va/__pa functions.

> > Anyway, I agree with Andrea, that another mapping isn't really needed.
> > Clever use of the mmu should give you almost the same result.
> 
> We *are* making clever use of the mmu in config_nonlinear, it is doing the
> nonlinear kernel virtual mapping for us.  Did you have something more clever
> in mind?

I mean to map the memory where you need it. The physical<->virtual
mapping won't be one to one, but you won't need another abstraction and
the current vm is already basically able to handle it.

bye, Roman
