Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSEAVXX>; Wed, 1 May 2002 17:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSEAVXW>; Wed, 1 May 2002 17:23:22 -0400
Received: from quechua.inka.de ([212.227.14.2]:15163 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S314056AbSEAVXW>;
	Wed, 1 May 2002 17:23:22 -0400
From: Bernd Eckenfels <ecki-news2002-04@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: raid1 performance
In-Reply-To: <20020501130127.A10936@borg.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E1731ZL-0005Bl-00@sites.inka.de>
Date: Wed, 1 May 2002 23:23:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020501130127.A10936@borg.org> you wrote:
>  1. Does the OS even know where the heads are in a modern IDE disk?

>  2. Is "closer" any more finely grained than a binary
>     positioned/not-positioned?

> And I guess another question: How much does RAID 1 help and under what
> kinds of usage?

No, you just distribute the ready round robin, this means each disk has only
half the seeks it had before. As long as you do not spread continous blocks
(readahead) stats are good you actually reduce overall seeks. This helps
actually even if no seek is involved because of the fact that you need to
wait for the begin of a track to read it.

Greetings
Bernd
