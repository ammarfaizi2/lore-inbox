Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRGNQri>; Sat, 14 Jul 2001 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbRGNQra>; Sat, 14 Jul 2001 12:47:30 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:16826 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263149AbRGNQrW>; Sat, 14 Jul 2001 12:47:22 -0400
Message-ID: <3B5077E6.19965DCC@uow.edu.au>
Date: Sun, 15 Jul 2001 02:48:38 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Neil Brown <neilb@cse.unsw.edu.au>, Mike Black <mblack@csihq.com>,
        lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: raid5d, page_launder and scheduling latency
In-Reply-To: <3B50765F.6ECF7B17@uow.edu.au> from "Andrew Morton" at Jul 15, 2001 02:42:07 AM <E15LSW7-0001QO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > - exit with 1,000 files open
> > - exit with half a million pages to be zapped
> >
> > And "fixing" copy_*_user is outright dumb.  Just fix the four
> > or five places where it matters.
> 
> Depends if you want to use Linux as a Windows 3.1 replacement or a real OS.
> In the latter case we need to fix the stupid cases too.

umm..  That's what I said :)

Hunt them down and fix them, but don't add hundreds of schedules
all over the tree.  gettimeofday(), for heavens sake.
