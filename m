Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbTJGMkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 08:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTJGMkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 08:40:13 -0400
Received: from pier.botik.ru ([193.232.174.1]:31143 "EHLO pier.botik.ru")
	by vger.kernel.org with ESMTP id S262314AbTJGMkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 08:40:07 -0400
Message-ID: <3F82B4C6.707221A@namesys.com>
Date: Tue, 07 Oct 2003 16:42:46 +0400
From: "E. Gryaznova" <grev@namesys.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.22-badblocks i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can dbench be used for benchmarking fs?
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I use dbench for benchmarking the file systems and some results are
suspicious for me.

I run 10 times dbench on ext3 and i have the following :

Throughput 16.6754 MB/sec (NB=20.8443 MB/sec  166.754 MBit/sec)
Throughput 22.9772 MB/sec (NB=28.7216 MB/sec  229.772 MBit/sec)
Throughput 22.3698 MB/sec (NB=27.9623 MB/sec  223.698 MBit/sec)
Throughput 19.0533 MB/sec (NB=23.8167 MB/sec  190.533 MBit/sec)
Throughput 21.9662 MB/sec (NB=27.4577 MB/sec  219.662 MBit/sec)
Throughput 23.4062 MB/sec (NB=29.2578 MB/sec  234.062 MBit/sec)
Throughput 21.4233 MB/sec (NB=26.7791 MB/sec  214.233 MBit/sec)
Throughput 20.6202 MB/sec (NB=25.7753 MB/sec  206.202 MBit/sec)
Throughput 15.7005 MB/sec (NB=19.6256 MB/sec  157.005 MBit/sec)
Throughput 19.9631 MB/sec (NB=24.9538 MB/sec  199.631 MBit/sec)

As you can see
the average Throughput value is equal  20.4155 MB/sec
the max  value                         23.4062 MB/sec and
the min  value                         15.7005 MB/sec

As the result: the measuring deviation is equal = 23.4062 - 15.7005 =
7.7057 or about ~38% from average value.

I have dbench-1.1.tar.gz

I run dbench by the following way :
mke2fs -j /dev/xxx
mount /dev/xxx /mnt
cp dbench /mnt/.
cp clients.txt /mnt/.
cd /mnt
for x 1, 2, ... 10
do
    ./dbench 8 >>results
done

So, I have 2 questions :
1. Is there a way to avoid such big deviations on measuring a file
systems throughput and to get more stable results?
2. Can dbench be used for benchmarking the file systems and if it is so
-- what is the predictable error on the measuring?

Thank you very much for helping.
Lena.



