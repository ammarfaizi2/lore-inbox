Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRAKUkC>; Thu, 11 Jan 2001 15:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130571AbRAKUjx>; Thu, 11 Jan 2001 15:39:53 -0500
Received: from web119.mail.yahoo.com ([205.180.60.120]:38663 "HELO
	web119.yahoomail.com") by vger.kernel.org with SMTP
	id <S130335AbRAKUjf>; Thu, 11 Jan 2001 15:39:35 -0500
Message-ID: <20010111203933.17385.qmail@web119.yahoomail.com>
Date: Thu, 11 Jan 2001 12:39:33 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: Linux driver:  __get_free_pages()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our driver is trying to allocate a DMA buffer to flash
an adapter's firmware.  This can require as much as
512K ( of contiguous DMA memory ). We are using the
function __get_free_pages( GFP_KERNEL | GFP_DMA, order
) .  The call is failing if 'order' is greater than 6.
The problem is seen on systems with system memory of
only 64MB.  It works fine on systems with more memory.
 Does it make sense that a system with 64MB would not
have 512K ( contiguous ) available?  The most that can
be allocated successfully on the 64MB system appears
to be 256K.  (Nothing else is running that would eat
up 64MB of memory).

Does this make sense and/or is there another way that
the DMA memory could be allocated successfully?


__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
