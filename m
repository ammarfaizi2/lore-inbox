Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129236AbQJ0TMl>; Fri, 27 Oct 2000 15:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQJ0TMc>; Fri, 27 Oct 2000 15:12:32 -0400
Received: from 64-60-56-3-cust.telepacific.net ([64.60.56.3]:5847 "EHLO
	ptieng.procom.com") by vger.kernel.org with ESMTP
	id <S129236AbQJ0TMR>; Fri, 27 Oct 2000 15:12:17 -0400
Date: Fri, 27 Oct 2000 12:07:38 -0700 (PDT)
From: chris parker <chrisp@procom.com>
To: linux-kernel@vger.kernel.org
cc: chris_parker@procom.com, hnguyen@procom.com
Subject: Question: multiple major numbers - one driver
Message-ID: <Pine.LNX.4.05.10010271201430.18801-100000@gemini.procom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a need for more than 256 minor numbers.  I could add some 
more major numbers, thus getting the number of majors * 256.
I would like to have only device driver loaded to handle the
multiple majors.
I thoought of the following things that would have to be changed: 

1) make the new device descriptors
2) add the new majors to the register_blkdev and unregister
   system calls
3) process multiple CURRENT q's when receiving a request 
   from the block device layer. Each unique major has
   a seperate incoming q.

   Does any know of anything else that would prevent me from doing 
   this ??

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
