Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268794AbTCDAUC>; Mon, 3 Mar 2003 19:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268857AbTCDAUC>; Mon, 3 Mar 2003 19:20:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15366 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268794AbTCDAUB>;
	Mon, 3 Mar 2003 19:20:01 -0500
Message-ID: <3E63F395.8080303@pobox.com>
Date: Mon, 03 Mar 2003 19:30:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: David Lang <david.lang@digitalinsight.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arador <diegocg@teleline.es>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com> <3E63ED14.5090809@pobox.com> <20030304001552.GU16918@dualathlon.random>
In-Reply-To: <20030304001552.GU16918@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Mar 03, 2003 at 07:02:28PM -0500, Jeff Garzik wrote:
> 
>>David Lang wrote:
>>
>>>On Mon, 3 Mar 2003, Andrea Arcangeli wrote:
>>>
>>>
>>>
>>>>Just curious, this also means that at least around the 80% of merges
>>>>in Linus's tree is submitted via a bitkeeper pull, right?
>>>>
>>>>Andrea
>>>
>>>
>>>remember how Linus works, all normal patches get copied into a single
>>>large patch file as he reads his mail then he runs patch to apply them to
>>>the tree. I think this would make the entire batch of messages look like
>>>one cset.
>>
>>
>>Not correct.  His commits properly separate the patches out into 
>>individual csets.
> 
> 
> and they're unusable as source to regenerate a tree. I had similar
> issues with the web too. to make use of the single csets you need to
> implement the internal bitkeeper branching knowledge too. Not to tell
> apparently the cset numbers changes all the time.


The "weave", or order of csets, certainly changes each time Linus does a 
'bk pull'.  I wonder if a 'cset_order' file would be useful -- an 
automated job uses BK to export the weave for a specific point in time. 
  One could use that to glue the csets together, perhaps?

WRT cset numbers, ignore them.  Each cset has a unique key.  When 
setting up the 2.5 snapshot cron job, Linus asked me to export this key 
so that the definitive top-of-tree may be identified, regardless of cset 
number.  Here is an example:
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.63-bk6.key

	Jeff



