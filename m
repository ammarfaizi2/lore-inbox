Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWFZJ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWFZJ3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 05:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWFZJ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 05:29:42 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:57617 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751173AbWFZJ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 05:29:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IZdFa6zbRT/VEF2tS2CrimKFMzbf2TqPDTGAnVQ2ghiY88gs+yBP8XBjKA7t74fsu955roE7oZSfSNySQCztCu54wze8y9GXS8Of9ceOeWv8TjApZaJ1oqnEfdpzLIbyhtwO8DkQs/yeubIt434VGBqzYtOscVta1WR8BQ1IKuk=
Message-ID: <6bffcb0e0606260229i219d4f43m629986d5d3563ccb@mail.gmail.com>
Date: Mon, 26 Jun 2006 11:29:41 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [patch] 2.6.17: lockless pagecache
Cc: "Nick Piggin" <npiggin@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management List" <linux-mm@kvack.org>
In-Reply-To: <449F7857.4070806@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060625163930.GB3006@wotan.suse.de>
	 <6bffcb0e0606251026gbd121dam83c1b763b8cba02d@mail.gmail.com>
	 <449F7857.4070806@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Michal Piotrowski wrote:
> > Hi Nick,
> >
> > On 25/06/06, Nick Piggin <npiggin@suse.de> wrote:
> >
> >> Updated lockless pagecache patchset available here:
> >>
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.17/lockless.patch.gz
> >>
> >>
> >
> > "make O=/dir oldconfig" doesn't work.
> >
> > [michal@ltg01-fedora linux-work]$ LANG="C" make O=../linux-work-obj/
> > oldconfig
>
> Hmm, I can't see how I did that.
>
> npiggin@didi:~/x$ zcat lockless.patch.gz | diffstat
>   drivers/mtd/devices/block2mtd.c |    7 -
>   fs/buffer.c                     |    4
>   fs/inode.c                      |    2
>   include/asm-arm/cacheflush.h    |    4
>   include/asm-parisc/cacheflush.h |    4
>   include/linux/fs.h              |    2
>   include/linux/mm.h              |    6
>   include/linux/page-flags.h      |   26 ++--
>   include/linux/pagemap.h         |   74 ++++++++++++
>   include/linux/radix-tree.h      |   67 +++++++++++
>   include/linux/swap.h            |    1
>   lib/radix-tree.c                |  240 +++++++++++++++++++++++++++------------
>   mm/filemap.c                    |  242 ++++++++++++++++++++++++++++++----------
>   mm/hugetlb.c                    |    8 -
>   mm/migrate.c                    |   21 ++-
>   mm/page-writeback.c             |   40 ++----
>   mm/readahead.c                  |    7 -
>   mm/swap_state.c                 |   43 +++++--
>   mm/swapfile.c                   |    6
>   mm/truncate.c                   |    6
>   mm/vmscan.c                     |   20 ++-
>   21 files changed, 619 insertions(+), 211 deletions(-)
>
> I recall there was a bit of noise recently about problems building
> into an external working directory?

Sorry for noise - it's 2.6.17 problem. I didn't notice this.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
