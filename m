Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275013AbTHFXYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275016AbTHFXYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:24:54 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:10502 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275013AbTHFXYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:24:52 -0400
Message-ID: <3F319146.6080607@techsource.com>
Date: Wed, 06 Aug 2003 19:37:42 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Andrew Morton <akpm@osdl.org>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
References: <3F306858.1040202@mrs.umn.edu> <20030805224152.528f2244.akpm@osdl.org> <3F310B6D.6010608@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hans Reiser wrote:

> reiser4 cpu consumption is still dropping rapidly as others and I find 
> kruft in the code and remove it.  Major kruft remains still.


If a file system is getting greater throughput, that means the relevant 
code is being run more, which means more CPU will be used for the 
purpose of setting up DMA, etc.  That is, if a FS gets twice the 
throughput, it would not be unreasonable to expect it to use 2x the CPU 
time.

Furthermore, in order to achieve greater throughput, one has to write 
more intelligent code.  More intelligent code is probably going to 
require more computation time.

That is to say, if your FS is twice as fast, saying it has a problem 
purely on the basis that it's using more CPU ignores certain facts and 
basic logic.

Now, if you can manage to make it twice as fast while NOT increasing the 
CPU usage, well, then that's brilliant, but the fact that ReiserFS uses 
more CPU doesn't bother me in the least.

