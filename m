Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317477AbSGEPbf>; Fri, 5 Jul 2002 11:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317476AbSGEPbe>; Fri, 5 Jul 2002 11:31:34 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:15395 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S317475AbSGEPbe>; Fri, 5 Jul 2002 11:31:34 -0400
Message-ID: <3D25BC6B.8060308@users.sf.net>
Date: Fri, 05 Jul 2002 17:34:03 +0200
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 patch] remove obsolete disk statistics header from /proc/partitions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> Marcelos' BK repository (that will become 2.4.19-rc2) includes a patch to
> remove these statistics completely from /proc/partitions...

I certainly hope they move elsewhere; totally removing these is bad news 
for anyone running a server that does disk I/O.

If the bugginess of part of the data is a problem, remove that data for 
the time being. I can also imagine people feel it is bloated (blocks and 
KB/sec), and maybe it should be reorganized to move elsewhere.

But measurement is important - the saying here is "meten is weten" - and 
should not be removed from the kernel.

As for correcting: I can imagine a really dirty fix decrementing the 
number of running requests once a second, on top of the fix in 2.5 that 
prevents the number from going negative. The extra decrement makes disk 
performance appear about 1% higher than it should: not a big falsification.



Thomas


