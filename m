Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTI3Lkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 07:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTI3Lkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 07:40:33 -0400
Received: from mail1.kth.se ([130.237.32.62]:14026 "EHLO mail1.kth.se")
	by vger.kernel.org with ESMTP id S261347AbTI3Lk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 07:40:26 -0400
Message-ID: <3F796B6B.8070505@kth.se>
Date: Tue, 30 Sep 2003 13:39:23 +0200
From: Christoph Klocker <cklocker@kth.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: datatransfer slow down with 1TB files
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I am developing a system to stream large uncompressed videofiles which 
are about 1,5TB.
I need a bandwith of 195MB/s (HD-SDI)
my system is now:
RH8 - kernel: 2.4.18
xeon 2,4GHz
1GB RAM
3ware escalade controller 12 s-ata harddisks (seagate barracuda 7200.7 - 
120GB - SCSI)

when I do different tests with bonnie++ I get very good results for a 
2GB file, sequential input 236mb/s,
but when the files get larger the speed is going down significantly.
at 10GB - 216MB/s
at 100GB - 187MB/s
at 1TB - 161MB/s
the sequential output stays at 183MB/s any time, up to 1TB.
As my harddisks have a sustained rate of 32-50 MB/s each it should not 
be the
case that they influence the results. I also tested the raid full up to 
1,2TB and there was no difference in the results.
Best filesystem performance I tested was on XFS or EXT2
I applied min-readahead to 128 and max-readahead to 256

I tested also with lmdd with the O_DIRECT option, and get lower results.
lmdd if=internal of=fred bs=2m count=1000 fsync=1 direct=1
2097.1520 MB in 12.5588 secs, 166.9860 MB/sec

the driver for the videocard I use don't support 2.6
please reply personally
thanks
christoph



