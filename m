Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268965AbRHGPqT>; Tue, 7 Aug 2001 11:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRHGPqL>; Tue, 7 Aug 2001 11:46:11 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20296 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S268838AbRHGPp6>; Tue, 7 Aug 2001 11:45:58 -0400
Date: Tue, 7 Aug 2001 11:45:45 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032330450.1193-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108071143080.30280-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Linus Torvalds wrote:

> Does it work reasonably under your loads?

I didn't try pre4.  pre5 is absolutely horrible. vmstat stops responding
for long periods of time and it looks like the vm isn't being throttled at
all, so the system goes nuts trying to swap data out while it should just
wait a bit for io to complete.

		-ben

 1  2  1      0 993520   4376 2981648   0   0     4 56700  616    22   0  42  58
 1  1  1      0 863768   4492 3102032   0   0     0 69376  627    29   0  45  55
 1  0  1      0 739320   4620 3230408   0   0     0 56184  617    20   0  41  59
 1  0  1      0 611832   4740 3354952   0   0     0 63080  622    19   0  45  55
 1  0  1      0 481664   4860 3477320   0   0     0 67812  614    17   0  44  55
 1  0  1      0 354024   4984 3604156   0   0     0 60868  622    26   0  43  57
 0  2  1      0 266856   5072 3692556   0   0     4 59636  617    23   0  37  63
 0  2  1      0 195384   5136 3759408   0   0     0 66288  624    26   0  35  64
 1  1  1      0 147016   5192 3818968   0   0     4 51008  637    74   0  29  71
 0  3  1      0  95912   5248 3875684   0   0     4 56256  625    38   0  30  70
 1  1  1      0  31256   5312 3939796   0   0     8 62420  627    32   0  33  66
 1  1  2      0  14860   5352 3968976   0   0     0 49664  624  2600   0  56  44
 1  0  2      0   5476   5380 3983880   0   0    76 29988  434  2156   0  81  19
 1  0  2      0   3608   5396 3984212   0   0     0  1516  104   458   0  79  21
 1  0  2      0   3608   5396 3984212   0   0     0     0  103    92   0  75  25
 1  0  2      0   6908   5432 3987980   0   0     8 44280 1315  1394   0  95   5
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  2      0   3692   5444 3988452   0   0     0  2736  104  2363   0  79  21
 1  0  2      0   3692   5444 3988452   0   0     0     0  107    17   0  78  22
 5  1  3      0   6524   5444 3988516   0   0     8  7628  580   326   0  97   3
 2  1  3      0   5268   5472 3995208   0   0     8 11376  742   622   0 100   0
 1  0  2      0   5272   5472 3995208   0   0     0     0  105    13   0  75  25
 1  0  3      0   4476   5484 3995324   0   0     0 11780  757  6174   0  91   9
 2  0  3      0   4620   6268 3988588   0   0    76 803788 38730 117827   0  99   1
 3  1  4      0   5212   6268 3988056   0   0     4  3036  714   415   0 100   0
 1  1  3      0   4424   6268 3988036   0   0    40 33508  544  1362   0 100   0
 3  0  2      0   5948   6268 3988016   0   0     0 11532  299   792   0  99   1
 1  1  2      0   6356   6268 3987860   0   0     0  8568  360   258   0  94   6
 1  1  3      0   4452   6268 3987528   0   0     4 63604 1008 16081   0  91   9
 0  1  3      0   3652   6268 3987396   0   0     0 44796  624  3539   0  98   2


