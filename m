Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSCXSCK>; Sun, 24 Mar 2002 13:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311642AbSCXSCA>; Sun, 24 Mar 2002 13:02:00 -0500
Received: from quechua.inka.de ([212.227.14.2]:11123 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S311641AbSCXSBx>;
	Sun, 24 Mar 2002 13:01:53 -0500
From: Bernd Eckenfels <ecki-news2002-03@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with serial.c introduced in 2.4.15
In-Reply-To: <E16pBIs-00024N-00@mrvdom03.kundenserver.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16pCJU-0002oO-00@sites.inka.de>
Date: Sun, 24 Mar 2002 19:01:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16pBIs-00024N-00@mrvdom03.kundenserver.de> you wrote:
> The #if 0 and #endif was removed in 2.4.15 and somehow that breaks 
> gpm/genitizer. Having added the "commenting out through $if 0" the 
> tablet works fine again and deactivating the appropriate line in 2.4.18 
> also works.

Probably stty CREAD < /dev/ttyS0  will help (or whatever your tty is) Looks
like a bug in gpm, which is not setting the cread flag.

Greetings
Bernd
