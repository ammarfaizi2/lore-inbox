Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265120AbRGGOfr>; Sat, 7 Jul 2001 10:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266325AbRGGOfh>; Sat, 7 Jul 2001 10:35:37 -0400
Received: from [213.128.193.148] ([213.128.193.148]:18957 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S265120AbRGGOf3>;
	Sat, 7 Jul 2001 10:35:29 -0400
Date: Sat, 7 Jul 2001 18:30:33 +0400
Message-Id: <200107071430.f67EUXq07488@linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
To: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.6 PCMCIA NET modular build breakage
In-Reply-To: <Pine.LNX.4.33.0107071520250.1054-100000@vaio>
X-Newsgroups: linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.6 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>> Seems like its something that appeared between 2.4.5 and 2.4.6.  Anyone
>> know the correct fix, other than reversing the change?
KG> It should be fine.
It is not.

>> Since all net cards are modules, object list for pcmcia_net.o is empty and
>> kernel can't be linked.
KG> Could you reproduce this? (I don't think you can)
Sure, I can. First thing I did was in fact to try and reproduce that.

KG> Rules.make takes care of an empty $(obj-y) and builds an empty $(O_TARGET) 
KG> file in this case, so linking this in should work fine.
Hmm....
(examining Makefile...)
I see. So there cannot be usual targets before including Rules.make,
and my copy of the tree have these. And if I move them after inclusion,
everything builds just fine.
Perhaps it should be documented somewhere.

Well. So at the end it seems to be not a vanilla kernel problem. That's good.

Bye,
    Oleg
