Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270608AbTGURsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270673AbTGURrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:47:10 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:59300 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270650AbTGURos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:44:48 -0400
Message-ID: <3F1C0DBD.9060507@cornell.edu>
Date: Mon, 21 Jul 2003 11:58:53 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: TCQ problems in 2.6.0-test1: the summary
References: <3F19C838.8040301@cornell.edu> <20030721123334.GF10781@suse.de>
In-Reply-To: <20030721123334.GF10781@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is really strange. The only difference between using 8 or 32 tags
> is when ide-disk stops attempting to queue. Are you getting any errors
> in dmesg when this happens? Reading the start io path for this, it looks
> correct to me. I'll have to try and reproduce when I get back.

I get filesystem errors.
Well, reiserfs refuses to pass the filesystem check every time with a 
queue of depth 8. The one time that I decied to bypass it to look for 
errors, I got a bunch:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1307.html

XFS will boot, but corrupts the fs after a while, and I got an oops there:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/2583.html

Other than that - no messages.


> If it's an ide tcq bug, it isn't very interesting. You can safely fry
> that partition.

Already done.



