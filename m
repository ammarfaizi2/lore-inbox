Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSF1X6l>; Fri, 28 Jun 2002 19:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317485AbSF1X6k>; Fri, 28 Jun 2002 19:58:40 -0400
Received: from quechua.inka.de ([212.227.14.2]:31758 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S317462AbSF1X6j>;
	Fri, 28 Jun 2002 19:58:39 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: raid1 performance
In-Reply-To: <20020502183758.Q31556@unthought.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17O5fg-0004wl-00@sites.inka.de>
Date: Sat, 29 Jun 2002 02:01:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020502183758.Q31556@unthought.net> you wrote:
>> No, you just distribute the ready round robin, this means each disk has only
>> half the seeks it had before. 

> No, this is the way it was done a long time ago.

> It turns out to be an incredibly bad idea.  In fact, it is the most CPU-efficient
> way of guaranteeing the largest average seek times on your disks  ;)

> The RAID-1 code now looks at which disk worked closest to the wanted position
> last, and picks that disk for the seek.

Thats right, it is done on the distance in sector numbers. Thats a simple
compare, not sure if one could do that better.

raid1.c:raid1_read_balance()

Greetings
Bernd
