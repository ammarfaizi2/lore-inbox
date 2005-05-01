Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVEABm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVEABm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 21:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVEABm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 21:42:59 -0400
Received: from mail.dif.dk ([193.138.115.101]:6823 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261494AbVEABmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 21:42:54 -0400
Date: Sun, 1 May 2005 03:46:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: acme@ghostprotocols.net
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Jouni Malinen <jkmaline@cc.hut.fi>,
       James Morris <jmorris@intercode.com.au>,
       Pedro Roque <roque@di.fc.ul.pt>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Kunihiro Ishiguro <kunihiro@ipinfusion.com>,
       Mitsuru KANDA <mk@linux-ipv6.org>,
       lksctp-developers@lists.sourceforge.net,
       Andy Adamson <andros@umich.edu>, Bruce Fields <bfields@umich.edu>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, juhl-lkml@dif.dk
Subject: [PATCH 0/4] resource release cleanup in net/ (take 2)
In-Reply-To: <39e6f6c705043014264eb4c0c5@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0505010341560.2094@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
 <39e6f6c705043014264eb4c0c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Arnaldo Carvalho de Melo wrote:

> On 4/30/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > Hi David,
> > 
> > Since Andrew merged the patch that makes calling crypto_free_tfm() with a
> > NULL pointer safe into 2.6.12-rc3-mm1, I made a patch to remove checks for
> > NULL before calling that function, and while I was at it I removed similar
> > redundant checks before calls to kfree() and vfree() in the same files.
> > There are also a few tiny whitespace cleanups in there.
> 
> Jesper, I'd suggest that you left whitespaces for a separate patch, it
> is always,
> IMHO, better to have as small a patch as possible for reviewing.
> 
Sure thing. I've split the patches, and I believe that me going through 
them a second time did them good, there are a few tiny changes over the 
first version.

I split the patch in 4 parts (will send as replies to this mail) : 
	1) crypto_free_tfm related changes
	2) kfree related changes
	3) vfree related changes
	4) whitespace changes
The whitespace changes ended up fairly bigger than initially. I expanded 
the cleanup a bit. It's not a perfect, 100% complete cleanup, but it's IMO 
a lot better than the originals.

-- 
Jesper


