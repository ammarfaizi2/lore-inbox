Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281760AbRKQO7z>; Sat, 17 Nov 2001 09:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281761AbRKQO7o>; Sat, 17 Nov 2001 09:59:44 -0500
Received: from cogito.cam.org ([198.168.100.2]:1605 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S281760AbRKQO72>;
	Sat, 17 Nov 2001 09:59:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: Swap Usage with Kernel 2.4.14
Date: Sat, 17 Nov 2001 09:59:19 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011117145920.A08D2261@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I current use 4GB support, 1GB of ram, 2GB of swap.
> 
> Having 1GB, I thought I had enough memory for basic operations without
> the disk swapping like mad.

In 2.4.14 linux leave pages in swap when swaping in.  This is a win when
the page has not been changed and there is memory pressure.  This behavior
is maintained until swap is 50% full.  An this point linux starts releasing
swap pages at swapin.

In short linux keeps pages in swap and memory to perform better but starts
releasing swap pages when swap start filling.

Ed Tomlinson
 
