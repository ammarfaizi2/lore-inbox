Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSIOQKb>; Sun, 15 Sep 2002 12:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSIOQKb>; Sun, 15 Sep 2002 12:10:31 -0400
Received: from dsl-213-023-039-078.arcor-ip.net ([213.23.39.78]:11905 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318067AbSIOQKa>;
	Sun, 15 Sep 2002 12:10:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [2.5] DAC960
Date: Sun, 15 Sep 2002 18:18:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <20020915131920.GR935@suse.de> <E17qbEj-0000BP-00@starship>
In-Reply-To: <E17qbEj-0000BP-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qc6F-0000Cw-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 17:23, Daniel Phillips wrote:
> On Sunday 15 September 2002 15:19, Jens Axboe wrote:
> Well, you're looking at the situation from the block IO maintainer's
> point of view.  We also need certain scsi-style functionality available
> across all disk systems, such as barriers in a form usable by
> filesystems.  Maybe you *can* suck all that functionality into the
> block layer, but maybe it needs higher level support as well.  I'll
> bet on the latter, and I won't have to speculate, pretty soon.

Oops, sorry, this is inverted, the block layer is the higher of the
two.  Anyway, that's what you get for making a VM hacker fix the
driver you broke ;-)

The Q of this signal will start increasing pretty soon (got to move
some cables and boxes around next.  Got to fix up Theo's PAM breakage
so ssh works again.  Got to point LXR at bio.)

Anybody interested in working through this learning curve along with
me:

   http://lxr.linux.no/source/drivers/block/DAC960.c?v=2.5.31
   (The DAC960 driver in all 6921 lines of funky glory)

   http://lxr.linux.no/source/include/linux/bio.h?v=2.5.31#L60
   (the bio struct)

   http://lxr.linux.no/ident?v=2.5.31;i=bio
   (everwhere it's used)

   http://lxr.linux.no/source/Documentation/block/biodoc.txt?v=2.5.31
   (Suparna's excellent bio writeup)

By the way, the gentlemanly thing to do would be to put Suparna first in
the list of authors of the writeup since 90% of the text is hers.  On
the other hand, you're being a little too humble calling this a "bio
rewrite" - it's not, it's a new animal, or at least, it's a wholesale
block layer replacement.

-- 
Daniel
