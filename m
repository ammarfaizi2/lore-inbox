Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSE0JYp>; Mon, 27 May 2002 05:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316471AbSE0JYo>; Mon, 27 May 2002 05:24:44 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:7428 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315720AbSE0JYm>; Mon, 27 May 2002 05:24:42 -0400
Date: Mon, 27 May 2002 11:24:08 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Cc: tcallawa@redhat.com, colin@gibbs.dhs.org, sparclinux@vger.kernel.org,
        aurora-sparc-devel@linuxpower.org
Subject: 2.4 SRMMU bug revisited
Message-ID: <20020527092408.GD345@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 10 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	From: Tomas Szepe <szepe@pinerecords.com>
>	Date: Thu, 23 May 2002 09:02:44 +0200
> 
>	> > 2. What is the "proper" fix for the patch collision between the raid
>	> > patch and the ext3 patch in /include/linux/fs.h? 
>	> 
>	> Use 2.4.
>	
>	Impossible on sparc32 on account of the lurking SRMMU bug.
>	(See yesterday's post by Joris Braakman <jorisb@nl.euro.net>.)
>
> There have been several patches posted to deal with that
> problem, you can apply them yourself or grab Marcelo's
> current 2.4.x BK tree.

I finally got round to trying the patches out and --

unfortunately, things got even worse. While before the machine would
oops (still allowing one to ssh in and reboot) under heavy loads, now
it doesn't bother to log the slightest notice that something might
have broken, and freezes entirely (it can be pinged, though).

I can't say I like these fixes much.


T.
