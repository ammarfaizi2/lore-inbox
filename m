Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143491AbRAHM5Q>; Mon, 8 Jan 2001 07:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143570AbRAHM5F>; Mon, 8 Jan 2001 07:57:05 -0500
Received: from colorfullife.com ([216.156.138.34]:2835 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S143491AbRAHM4z>;
	Mon, 8 Jan 2001 07:56:55 -0500
Message-ID: <3A59B8EB.6DA1D078@colorfullife.com>
Date: Mon, 08 Jan 2001 13:56:11 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mohammedazad@nestec.net
CC: linux-kernel@vger.kernel.org
Subject: [OT] Re: WaitForSingleObject in linux????..
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would try to:

* implement foo_poll() in the kernel driver.
* the user space app calls select() or poll().

WaitForSingleObject should be easy to replace.

WaitForMultipleObjects could be tricky if you wait for different events
(e.g. wait until either the kernel driver has new data, or another
process exits, or a pthread_mutex is released by another thread).

> I am porting a NT driver and app into linux...

Good luck, I hope you release the kernel driver under GPL

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
