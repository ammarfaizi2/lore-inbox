Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265111AbUFAQXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUFAQXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUFAQXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:23:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25820 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265111AbUFAQTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:19:48 -0400
Date: Tue, 1 Jun 2004 18:19:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eric BEGOT <eric_begot@yahoo.fr>, Chris Wedgwood <cw@f00f.org>
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601161940.GG25681@fs.tum.de>
References: <20040601021539.413a7ad7.akpm@osdl.org> <200406011351.10669@zodiac.zodiac.dnsalias.org> <40BC746F.8070501@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BC746F.8070501@yahoo.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:19:59PM +0200, Eric BEGOT wrote:
> On my x86, I've a problem durning the link edition :
> lib/built-in.o(.text+0x280): In function `qsort':
> lib/qsort.c:87: multiple definition of `qsort'
> fs/built-in.o(.text+0x12eac0):fs/xfs/support/qsort.c:79: first defined here
> ld: Warning: size of symbol `qsort' changed from 1721 in fs/built-in.o 
> to 1095 in lib/built-in.o
> ld: final link failed: Memory exhausted
> make: *** [.tmp_vmlinux1] Error 1
> 
> I don't understand why there are 2 qsorts files.
> I have disabled the support of xfs to resolve the problem. I didn't want 
> to change the name of the qsort implemented in fs/xfs/support/qsort.c or 
> to delete this file :)
> 
> I include the .config
>...

Thanks for this report.

Better workaround:
disable
    Library routines
      Quick Sort

@Andrew:
add-qsort-library-function depends on the XFS qsort patches you removed 
(and it's currently not used by anything else).


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

