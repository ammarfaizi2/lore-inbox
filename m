Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267586AbRGZCSb>; Wed, 25 Jul 2001 22:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbRGZCSU>; Wed, 25 Jul 2001 22:18:20 -0400
Received: from stine.vestdata.no ([195.204.68.10]:51218 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S267552AbRGZCSO>; Wed, 25 Jul 2001 22:18:14 -0400
Date: Thu, 26 Jul 2001 04:18:21 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010726041821.C19238@vestdata.no>
In-Reply-To: <20010703065312.J4841@vestdata.no> <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com>; from Ben LaHaise on Tue, Jul 03, 2001 at 10:19:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 03, 2001 at 10:19:36PM -0400, Ben LaHaise wrote:
> Here's the [completely untested] generic scsi fixup, but I'm told that
> some controllers will break with it.  Give it a whirl and let me know how
> many pieces you're left holding. =)  Please note that msdos partitions do
> *not* work on devices larger than 2TB, so you'll have to use the scsi disk
> directly.  This patch applies on top of v2.4.6-pre8-largeblock4.diff.

I just trid this, but when I can't load the md modules becuase of
missing symbols for __divdi3 and __umoddi3. 

Theese are the messages from make install:
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.6-pre8;
fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre8/kernel/drivers/md/linear.o
depmod: 	__udivdi3
depmod: 	__umoddi3
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre8/kernel/drivers/md/lvm-mod.o
depmod: 	__udivdi3
depmod: 	__umoddi3
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre8/kernel/drivers/md/md.o
depmod: 	__udivdi3
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre8/kernel/drivers/md/raid0.o
depmod: 	__udivdi3
depmod: 	__umoddi3
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-pre8/kernel/drivers/md/raid5.o
depmod: 	__udivdi3
depmod: 	__umoddi3


Did you forget something in your patch, or was it not supposed to work
on ia32?

This is kind of urgent, because I will temporarely be without testing
equipment pretty soon. Tips are appreciated!



-- 
Ragnar Kjorstad
Big Storage
