Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSHGRos>; Wed, 7 Aug 2002 13:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318793AbSHGRor>; Wed, 7 Aug 2002 13:44:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11212 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318792AbSHGRor>;
	Wed, 7 Aug 2002 13:44:47 -0400
Date: Wed, 7 Aug 2002 19:46:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, Marcin Dalecki <dalecki@evision.ag>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
In-Reply-To: <UTC200208062227.g76MRk407059.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0208071942140.21766-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Aug 2002 Andries.Brouwer@cwi.nl wrote:

> > using 2.5.29 (vanilla or BK-curr) i cannot use /sbin/lilo anymore
> > to update the partition table.
> 
> > if i do it then the partition table gets corrupted and the system
> > does not boot - it stops at 'LI'.
> 
> The funny thing is, I removed some stuff here in 2.5.30,
> so I would understand things immediately if you reported this
> about 2.5.30. But for 2.5.29 I do not immediately see why
> you would see any changes.

2.5.30 breaks as well.

> Did you in the meantime find out what was wrong?

nope. I still keep working it around.

> Are things OK in 2.5.28 and wrong in vanilla 2.5.29
> with the same version of LILO? (which version?)

a fairly standard LILO from RH 7.3: linux-21.4.4-10.

> Do you use the linear or lba32 options? The fix-table option?

I use none of these options. I use a very simple setup, a proper /boot 
partition, nothing complex or unexpected.

> What corruption do you see in the partition table?

nothing in the descriptors that i can tell from looking at fdisk output -
but it would be pretty hard to recover the system via a pure rescue CD
otherwise.

> Do you use LVM?

nope. Plain old IDE, ext3fs, 

> What happens under 2.5.30?

the same 'LI' message.

I'll try Alan's suggestion of adding the 'linear' option.

	Ingo

