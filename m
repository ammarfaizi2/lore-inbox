Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262379AbREXWDn>; Thu, 24 May 2001 18:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbREXWDd>; Thu, 24 May 2001 18:03:33 -0400
Received: from t2.redhat.com ([199.183.24.243]:43765 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262379AbREXWDZ>; Thu, 24 May 2001 18:03:25 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200105242107.OAA29730@csl.Stanford.EDU> 
In-Reply-To: <200105242107.OAA29730@csl.Stanford.EDU> 
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU, arjanv@redhat.com
Subject: Re: [CHECKER] error path memory leaks in 2.4.4 and 2.4.4-ac8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 May 2001 23:02:45 +0100
Message-ID: <10347.990741765@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


engler@csl.Stanford.EDU said:
> 1	|	drivers/mtd/mtdchar.c 
> 1	|	fs/jffs/jffs_fm.c 
> 2	|	fs/jffs/intrep.c
> 1	|	drivers/mtd/slram.c
> 1	|	drivers/mtd/ftl.c
> 1	|	drivers/mtd/mtdram.c

These are all now either fixed or obsoleted in my tree, and I will send a 
patch to Linus shortly. Thankyou. 

Do you find it useful to get a response such as this? Are you keeping track
of the bugs you find? (Or is it simply reassuring to confirm that someone's
paying attention? :)

engler@csl.Stanford.EDU said:
> Here are 37 errors where variables >= 1024 bytes are allocated on a
> function's stack.
> 2	|	fs/jffs2/compr_rtime.c

	int positions[256];

I believe we can make that a short. Arjan?

--
dwmw2


