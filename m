Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277861AbRJaAWf>; Tue, 30 Oct 2001 19:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277976AbRJaAW0>; Tue, 30 Oct 2001 19:22:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:37124 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277861AbRJaAWG>; Tue, 30 Oct 2001 19:22:06 -0500
Message-ID: <3BDF4326.2E6CDFF@zip.com.au>
Date: Tue, 30 Oct 2001 16:17:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Kuebel <kuebelr@email.uc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too thread termination
In-Reply-To: <20011029232508.A305@cartman>,
		<20011029232508.A305@cartman> <20011030191152.A898@cartman>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kuebel wrote:
> 
> ok, i am wondering if i have made a mistake.  this patch will make the
> kernel thread die when tp->time_to_die is true.  tp is kmalloc()'ed
> inside of alloc_etherdev.  i didn't initialize time_to_die to 0, but
> this patch has been working perfectly for me.  am i just lucky or are
> kmalloc()'ed regions zero'ed out?  i know there is stuff like
> get_zeroed_page(), but i don't think that applies here.  i guess it
> doesn't hurt to set the flag to zero myself.
> 

alloc_etherdev->alloc_netdev->memset(dev, 0, alloc_size);

It was zeroed for you.
