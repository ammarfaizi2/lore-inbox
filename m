Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280813AbRKUClj>; Tue, 20 Nov 2001 21:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281128AbRKUCl3>; Tue, 20 Nov 2001 21:41:29 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:51883 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S280813AbRKUClQ>;
	Tue, 20 Nov 2001 21:41:16 -0500
Message-ID: <3BFBBE98.68052D11@sltnet.lk>
Date: Wed, 21 Nov 2001 08:47:52 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.14-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 loopback blk dev compilation trouble
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.
        I've seen that the compilation of off-the-server
2.4.14 tree fails at the end of 'make bzImage' because
drivers/block/loop.c uses the deactivate_page() function,
which seems to have been removed from the source tree.
        By following the progress of the kernel through
2.4.12, 2.4.13, and 2.4.14 patches, I've seen that
page_cache_release() does the same things as
deactivate_page(). Both these functions are used in the
together twice in drivers/block/loop.c. I compiled
the 2.4.14 kernel by commenting out the references to
deactivate_page() but leaving page_cache_release(), and
loopback block devs work; but I do not have the resources
to  check it for memory leaks etc.
        I _think_ I've done the right thing, but
would appreciate verification by a regular kernel-
hacker :-)
I searched the net for some reference to this problem,
but couldn't find anything so far.

(I've compiled loop blk-dev support in to the kernel.)

ioshadi@sltnet.lk
ioshadij@hotmail.co
