Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRBBPUj>; Fri, 2 Feb 2001 10:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129804AbRBBPU3>; Fri, 2 Feb 2001 10:20:29 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:45828 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129660AbRBBPUQ>; Fri, 2 Feb 2001 10:20:16 -0500
Date: Fri, 02 Feb 2001 10:16:29 -0500
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@redhat.com>, Hans Reiser <reiser@namesys.com>
cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <595250000.981126989@tiny>
In-Reply-To: <E14OfIl-0006P1-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday, February 02, 2001 12:26:52 PM +0000 Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> This is why our next patch will detect the use of gcc 2.96, and
>> complain, in the reiserfs Makefile.
> 
> What makes you think its gcc 2.96 ?
> 

We have had many reports of exactly this symlink problem, and each time it
was a redhat user with a gcc 2.96, and switching to kgcc fixed it.  We have
one report (now two with Alan's) that 2.96-69 does not show this crash.

Hans, decisions about proper compilers should not be made in each
individual part of the kernel.  If unpatched gcc 2.96 is getting reiserfs
wrong, it is compiling other parts of the kernel wrong as well.  l-k has
discussed this at length already ;-)

> If the person concerned can clarify what they built with (2.96-69 or
> egcs-1.1.2 (kgcc)), that would be useful.
> 
> I've certainly done the Reiserfs testing I did with gcc 2.96-69 with no
> problems at all. Reiserfsck was having _bad_ problems but I saw those with
> egcs-1.1.2 too and I understand there is a new reiserfsck about to appear
> or just out which is much better.
> 

Yes.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
