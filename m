Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289687AbSAJV1n>; Thu, 10 Jan 2002 16:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289688AbSAJV1d>; Thu, 10 Jan 2002 16:27:33 -0500
Received: from web14906.mail.yahoo.com ([216.136.225.58]:37388 "HELO
	web14906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289687AbSAJV1U>; Thu, 10 Jan 2002 16:27:20 -0500
Message-ID: <20020110212718.41819.qmail@web14906.mail.yahoo.com>
Date: Thu, 10 Jan 2002 16:27:18 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: About block device request function.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a question of the block device request
function. I use the following sentences to change the
request function of a block device.

spin_lock_irq(&io_request_lock);

original_make_request_fn =
blk_dev[i].request_queue.make_request_fn;

blk_dev[i].request_queue.make_request_fn =
kti_make_request_fn;

spin_unlock_irq(&io_request_lock);

"i" is the major number of a block device.

You know blk_dev[] is the global block device array.
When I use those sentences to change the floppy block
device's request function, it works. The major number
of the floppy disk is 2. But when I use the same one
to change the hard disk's request function, it doesn't
work. I found that the
blk_dev[3].request_queue.make_request_fn is NULL. Does
that mean that the make_request_fn() of the hard disk
is NULL. I can't believe it. Can anyone give me an
answer?

Michael


______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
