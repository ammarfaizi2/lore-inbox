Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVBAKyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVBAKyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVBAKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:54:47 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:47529 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261954AbVBAKym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:54:42 -0500
Date: Tue, 1 Feb 2005 12:54:39 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Strange vmstat output. 2.6.10 Scheduler?
In-Reply-To: <20050201104949.GM4137@suse.de>
Message-ID: <Pine.LNX.4.62.0502011253390.26221@webhosting.rdsbv.ro>
References: <Pine.LNX.4.62.0502011217320.26221@webhosting.rdsbv.ro>
 <20050201102638.GJ4137@suse.de> <Pine.LNX.4.62.0502011236100.26221@webhosting.rdsbv.ro>
 <20050201104214.GK4137@suse.de> <Pine.LNX.4.62.0502011243270.26221@webhosting.rdsbv.ro>
 <20050201104949.GM4137@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The vmstat you showed had bi and bo at the same time, so it's not so
> surprising if bi often suffers if it is seeking all over the map to
> write out the big chunk submitted.

I understand.

> How does it look with write cache enabled?
Seems that almost the same:
  0  1  12416   6068   6908 816292    0    0  1744   156 1276  1327 16  2  0 82
  0  1  12416   6028   6908 816324    0    0     0     0 1270  1237  8  2  0 90
  0  1  12416   5988   6908 816324    0    0     0     0 1255   454  2  2  0 96
  0  2  12416   5956   6952 816324    0    0     0    80 1277   348  2  1  0 97
  0  2  12416   5944   6952 816324    0    0     0     0 1257   322  2  2  0 96
  0  2  12416   5960   6952 816324    0    0     0     0 1256   380  2  2  0 96
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  1  2  12416   5960   6952 816324    0    0     0     0 1262   337  2  1 0 97
  0  1  12416   4936   6952 817676    0    0  3400   180 1293  5466 31  6 0 63
  0  1  12416   5276   6896 817180    0    0  5600  8288 1329  1622 15  4 0 81
  0  1  12416   5212   6896 817228    0    0     0     0 1245  1237  7  2 0 91
  0  1  12416   5148   6896 817252    0    0     0     0 1250  1313  7  3 0 90
  0  1  12416   5152   6896 817284    0    0     0     0 1264  1243  7  2 0 91
  0  2  12416   5152   6944 817284    0    0     0   104 1257   377  1  4 0 95
  0  2  12416   5160   6944 817284    0    0     0    44 1250   407  2  1 0 97
  0  2  12416   5160   6944 817284    0    0     0     0 1265   287  2  0 0 98
  0  2  12416   5928   6940 816508    0    0   344   336 1272   384  2  3 0 95
  0  1  12416   5608   6892 817088    0    0  4440   140 1246  5390 24  7 0 69
  0  1  12416   5584   6848 817140    0    0  7436   612 1268  1707 16  3 0 81
  0  1  12416   5960   6848 816480    0    0  5900  8156 1300  1428  9  5 0 86
  0  1  12416   5632   6844 816824    0    0  1528   196 1271  1402 15  3 0 82

> Not surprising, there's not much the io scheduler can do for you here.
>
> -- 
> Jens Axboe
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
