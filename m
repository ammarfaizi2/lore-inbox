Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSEDNl3>; Sat, 4 May 2002 09:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSEDNl2>; Sat, 4 May 2002 09:41:28 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:9463 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312962AbSEDNl1>; Sat, 4 May 2002 09:41:27 -0400
Message-ID: <3CD3E505.A688C20A@eyal.emu.id.au>
Date: Sat, 04 May 2002 23:41:25 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: unresolved kmap_pagetable
In-Reply-To: <20020503203738.E1396@dualathlon.random> <3CD339B7.5BEB2DB4@eyal.emu.id.au> <20020504092531.L1396@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sat, May 04, 2002 at 11:30:31AM +1000, Eyal Lebedinsky wrote:
> > Andrea Arcangeli wrote:
> > >
> > > Full patchkit:
> > > http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz
> >
> > This is a new symbol introduced in -aa1. It ends up in drivers through
> > new header definitions rather than by direct use.
> >
> > Should be exported?
> 
> You should #include <linux/highmem.h> in those drivers .c files, then it
> will compile, but that's not the right fix, you'd need to add the
> pte_kunmap too or it would deadlock with highmem. The right fix is to
> convert those drivers to vmalloc_to_page, then they will work flawlessy.

Well, this may be a problem for NVdriver (a mostly binary only driver)
which I use.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
