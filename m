Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbRGQSnr>; Tue, 17 Jul 2001 14:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbRGQSni>; Tue, 17 Jul 2001 14:43:38 -0400
Received: from joat.prv.ri.meganet.net ([209.213.80.2]:9909 "EHLO
	joat.prv.ri.meganet.net") by vger.kernel.org with ESMTP
	id <S266907AbRGQSnY>; Tue, 17 Jul 2001 14:43:24 -0400
Message-ID: <3B54878E.F1CC19FE@ueidaq.com>
Date: Tue, 17 Jul 2001 14:44:30 -0400
From: Alex Ivchenko <aivchenko@ueidaq.com>
Organization: UEI, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 possible problem
In-Reply-To: <Pine.LNX.3.95.1010717103652.1430A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well,

> funct()
> {
>     size_t ticks;
>     wait_queue_head_t wqhead;
>     init_waitqueue_head(&wqhead);
> 
>     ticks = 1 * HZ;        /* For 1 second */
>     while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
>                   ;
> }
Well, this works.

The question is: should I call init_waitqueue_head() every time I call
interruptible_sleep_on_timeout() or is it enough to call it once in init_module() ?

Another one: should I call wake_up_interruptible() to release pending request?


-- 
Regards,
Alex

--
Alex Ivchenko, Ph.D.
United Electronic Industries, Inc.
"The High-Performance Alternative (tm)"
--
10 Dexter Avenue
Watertown, Massachusetts 02472
Tel: (617) 924-1155 x 222 Fax: (617) 924-1441
http://www.ueidaq.com
