Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135978AbRA1Ahd>; Sat, 27 Jan 2001 19:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136040AbRA1AhX>; Sat, 27 Jan 2001 19:37:23 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:46761 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135978AbRA1AhI>; Sat, 27 Jan 2001 19:37:08 -0500
Message-ID: <3A736B76.214D4193@uow.edu.au>
Date: Sun, 28 Jan 2001 11:44:38 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Stefani Seibold <stefani@seibold.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.0 disable printk
In-Reply-To: <01012723313500.01190@deepthought.seibold.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefani Seibold wrote:
> 
> Second, i had change the macro so it calls now a inline funciton
> printk_inline which always return 0. So it should be now compatibel to the
> standard printk funciton.

A #define is better.

You see, even if printk is a null inline function,

	printk("foo");

will still cause "foo" to appear in your output. Apparently
very recent versions of gcc have fixed this.

BTW: Graham Stoney prepared a similar patch for 2.2 last year.
You may be able to borrow some ideas from that work, and the
followup discussion.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0709.html

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
