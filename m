Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266507AbRGTDkW>; Thu, 19 Jul 2001 23:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbRGTDkM>; Thu, 19 Jul 2001 23:40:12 -0400
Received: from ppp-167.62.triton.net ([216.65.167.62]:14725 "HELO
	tabris.domedata.com") by vger.kernel.org with SMTP
	id <S266507AbRGTDkC>; Thu, 19 Jul 2001 23:40:02 -0400
Message-ID: <3B57A811.9030408@lycosmail.com>
Date: Thu, 19 Jul 2001 23:40:01 -0400
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Loop broken again (2.4.6-ac4)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jens,

Remember several weeks ago when I mentioned a problem w/ ridicyulous 
mod-use counts w/ loop.o???
Well, it's back again 2.4.5-ac19 (IIRC) worked fine.

Basically, the result of attempting sudo losetup -d /dev/loop0 is the 
following

ioctl LOOP_CLR_FD Device or resource busy

strace shows EBUSY

lsmod shows a use count of 563.

