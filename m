Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSFGF6c>; Fri, 7 Jun 2002 01:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSFGF6b>; Fri, 7 Jun 2002 01:58:31 -0400
Received: from quechua.inka.de ([212.227.14.2]:5903 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S293203AbSFGF6b>;
	Fri, 7 Jun 2002 01:58:31 -0400
From: Bernd Eckenfels <ecki-news2002-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove suser()
In-Reply-To: <Pine.LNX.4.44.0206062330480.16968-100000@sharra.ivimey.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17GClb-00072n-00@sites.inka.de>
Date: Fri, 7 Jun 2002 07:58:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0206062330480.16968-100000@sharra.ivimey.org> you wrote:
>>> +++ linux/include/linux/compatmac.h  Tue Jun  4 13:57:33 2002
>>> -#define capable(x)                   suser()

> Why? The file being changed is in a particular kernel, not in, say, glibc; to 
> require compatibilty btw. a file in kernel X and another in kernel Y seems 
> stupid... but perhaps I misunderstand.


I must admit, I do not understand why this is needed in new kernels, too.
But the suser() call which actually should be removed is in
/usr/src/linux/include/linux/sched.h. Same is true for fsuser().

It is a good idea to remove it from the code, so everybody is forced to use
a sane api everywhere.

Greetings
Bernd
