Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271717AbRHUOr4>; Tue, 21 Aug 2001 10:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271713AbRHUOrl>; Tue, 21 Aug 2001 10:47:41 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:31758 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271719AbRHUOrK>; Tue, 21 Aug 2001 10:47:10 -0400
Message-ID: <3B82743E.C442CF74@namesys.com>
Date: Tue, 21 Aug 2001 18:46:22 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Corin Hartland-Swann <cdhs@commerce.uk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: sync hanging
In-Reply-To: <Pine.LNX.4.21.0108211122550.11035-100000@willow.commerce.uk.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corin Hartland-Swann wrote:
> 
> Hi Hans,
> 
> On Tue, 21 Aug 2001, Hans Reiser wrote:
> > Corin Hartland-Swann wrote:
> > > I'm using kernel 2.4.8-ac2 on a Dual PIII-1000 with 4096M RAM, and a
> > > reiserfs filesystem on a RAID-1 mirror of two 76GB UDMA disks, and I'm
> > > experiencing a strange problem after the machine has been running for a
> > > while.
> > >
> > > Every now and again, running sync(1) (i.e. the program) seems to hang and
> > > end up in state D (uninterruptible sleep). There is no way to kill it
> > > (even with SIGKILL but I assume that this is typical for state D
> > > processes.
> > >
> > > Does anyone have any idea what may be causing this? I have searched the
> > > archives and couldn't find anything similar.
> >
> > turn off highmem, known bug, I don't know if it is solved yet.
> 
> Is 2G RAM OK (by manually changing __PAGE_OFFSET ?)
> 

surf through lkm postings for more info on this bug, it is not in my area of
expertise.

> Is this directly related to reiserfs (i.e. will it go away if I go back to
> using ext2 or switch to xfs?)

it is completely unrelated to reiserfs.

> 
> How serious is the problem? Can I get away with using it as is (with
> highmem) on a production server or will that cause serious repercussions?

you will be screwed if you use it on a production server, as best I understand
it.

> 
> Thanks,
> 
> Corin
> 
> /------------------------+-------------------------------------\
> | Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
> | Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
> | 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        |
> | Gilbert Street         |                                     |
> | Mayfair                |    Web: http://www.commerce.uk.net/ |
> | London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
> \------------------------+-------------------------------------/
