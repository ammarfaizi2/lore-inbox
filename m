Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280191AbRKSROO>; Mon, 19 Nov 2001 12:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280251AbRKSROE>; Mon, 19 Nov 2001 12:14:04 -0500
Received: from f150.law14.hotmail.com ([64.4.21.150]:48145 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280191AbRKSRNu>;
	Mon, 19 Nov 2001 12:13:50 -0500
X-Originating-IP: [203.94.89.36]
From: "Ishan Jayawardena" <ioshadij@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: missing function used in 2.4.14 loop.c
Date: Mon, 19 Nov 2001 17:13:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F150hjJ8uT6Ssuot0OU00001453@hotmail.com>
X-OriginalArrivalTime: 19 Nov 2001 17:13:44.0896 (UTC) FILETIME=[8B594C00:01C1711D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
        I _think_ I have done the right thing, but
would appreciate verification by a regular kernel-
hacker :-)
I searched the net for some reference to this problem,
but couldn't find anything so far.

(The presence of this function _would_ allow a user
to continue with the compilation _if_ loop blk dev support
was selected as a module, correct ? I've compiled loop blk-
dev support in to the kernel.)

****    Please, CC your comments to me.
ioshadij@hotmail.com
.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

