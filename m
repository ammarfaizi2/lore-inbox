Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWGSD4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWGSD4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 23:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWGSD4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 23:56:13 -0400
Received: from dsl081-085-109.lax1.dsl.speakeasy.net ([64.81.85.109]:64847
	"EHLO toro.mainphrame.com") by vger.kernel.org with ESMTP
	id S932485AbWGSD4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 23:56:12 -0400
Message-ID: <44BDAD5C.5020209@mainphrame.com>
Date: Tue, 18 Jul 2006 20:56:12 -0700
From: joel <joel@mainphrame.com>
Reply-To: joel@mainphrame.com
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: filesystem tuning hints?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please redirect me to an appropriate list if this is the wrong place -

This is perhaps a naive question, but please bear with me:

I recently had a chance to do some quick and dirty filesystem performance
comparisons on a server here before putting it into production. I tested
all the journaling filesystems available on stock suse linux enterprise
server v9, using bonnie, tiobench, iozone, and dbench, which all showed
similar trends - xfs tended to have steady performance and latency, jfs
had low performance but low cpu usage, reiserfs got the best numbers in
general, and ext3 results were all over the map. The dbench results are
fairly indicative of the results as a whole.

BTW - the mount options were basically "-noatime" on all filesystems.

I also tested ext2 just out of curiosity, and it thrashed all the others
by a large margin. Could I be doing something really really dumb here,
or is this just the cost of journalling?

Are there any dynamic kernel parameters which could bring any of the
journalled filesystems performance to a more respectable level?


Here are the dbench 3.04 results (MB/sec) plotted as nprocs vs fs type

n         ext2        ext3         jfs         reiser        xfs
-------------------------------------------------------------------
1        239.45      180.94       35.30       209.02       154.44
2        438.83      287.87       36.34       324.25       157.31
4        807.57      389.64       35.81       475.24       154.95
8       1018.24      398.31       30.66       396.14       146.62
16      1003.61      354.79       27.10       403.79       139.17
32      1006.60      180.83       25.40       330.46       120.81
64      1007.61      117.39       24.88       107.89        79.18
128     1010.10       67.70       18.60        43.62         6.41
256     1005.33       26.55        4.10        34.98         7.27
512      973.30       18.00        2.97        29.61         5.34
1024     613.40       17.64        4.36        27.16         4.79
2048      84.05       13.53       16.37        23.29         3.84


Thanks & Regards,

Joel
