Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131436AbRAWQyV>; Tue, 23 Jan 2001 11:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRAWQyL>; Tue, 23 Jan 2001 11:54:11 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:12272 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131465AbRAWQxx>; Tue, 23 Jan 2001 11:53:53 -0500
Date: Tue, 23 Jan 2001 10:53:51 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A6D5D28.C132D416@sangate.com>
Subject: Re: ioremap_nocache problem?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010123165401Z131465-18594+610@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Mark Mokryn <mark@sangate.com> on Tue, 23 Jan 2001
12:30:00 +0200


> Does this mean ioremap_nocache() may not do the job?

Good luck trying to get an answer.  I've been asking questions on ioremap for
months, but no one's ever been able to tell me anything.

According to the comments, mem.c provides /dev/zero support, whatever that is.
It doesn't appear to be connected to ioremap in any way, so I understand your
question.

I can tell you that I have written a driver that depends on ioremap_nocache,
and it does work, so it appears that ioremap_nocache is doing something.

My problem is that it's very easy to map memory with ioremap_nocache, but if
you use iounmap() the un-map it, the entire system will crash.  No one has been
able to explain that one to me, either.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
