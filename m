Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUAXIvU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 03:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUAXIvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 03:51:20 -0500
Received: from aibo.runbox.com ([193.71.199.94]:36487 "EHLO aibo.runbox.com")
	by vger.kernel.org with ESMTP id S266893AbUAXIvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 03:51:19 -0500
Date: Tue, 6 Jan 1970 04:01:53 +0300
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: 2.6.1 + XFS wierdness
From: Igor <ivi@runbox.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8D2C6B0D-21C8-11B2-9DDD-000A958B60EE@runbox.com>
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, as advised I'm reporting what happened to my system:
I run Kernel 2.6.1 with XFS on a laptop, I forgot to send it to "sleep"
and battery died, so there was unclean unmount (This is, what I believe 
was the cause),
at some point after I restarted my system many of the files couldn't be 
executed:
"binary file can't be executed reported", However the system was 
functional and I could boot it.
So I hexopened some of the problematic files and found that although 
the size of the file is maintained, there was no data, every byte was 
replaced by 0, I guess it was lucking reference on a hard drive or 
maybe something else. The reason I think the root of the problem is 
filesystem + kernel because the "corrupted" files have nothing in 
common, e.g:
/usr/bin/file
/etc/init.d/cron
/usr/bin/lynx
and that only happened when I updated kernel to 2.6.1
Regards.

If you reply, please cc to ivi@runbox.com

