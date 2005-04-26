Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVDZCcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVDZCcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 22:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVDZCcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 22:32:14 -0400
Received: from mail.timesys.com ([65.117.135.102]:20433 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261283AbVDZCcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 22:32:05 -0400
Message-ID: <426DA7B5.2080204@timesys.com>
Date: Mon, 25 Apr 2005 19:30:13 -0700
From: Mike Taht <mike.taht@timesys.com>
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2005 02:27:03.0109 (UTC) FILETIME=[6E9F5750:01C54A07]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 > On Mon, 25 Apr 2005, Matt Mackall wrote:
 >
 >>Here are the results of checking in the first 12 releases of Linux 2.6
 >>into empty repositories for Mercurial v0.3 (hg) and git-pasky-0.7.
 >>This is on my 512M Pentium M laptop. Times are in seconds.

One difference is probably - mercurial appears to be using zlib's 
*default* compression of 6....

using zlib compression of 9 really impacts git...

as per http://www.gelato.unsw.edu.au/archives/git/0504/1988.html

 >On a 700MHz p3, UDMA33, freebsd 5.3, ffs (soft updates) I get:

 >compressor | levels (size, time to compress, time to uncompress)
 >-----------+-------------------------------------------------------------------
 >gzip       | 9 (28M, 1:19, 30), 6 (28M, 31.7, 30), 3 (30M, 26.1,28.7)
 >           | 1 (31M, 23.6, 29.8)
 >bzip2      | 9 (27M, 2:14, 37.4) 6 (27M, 2:11, 38.8) 3 (27M, 2:10,38.3)
 >lzop       | 9 (32M, 2:15, 35.4) 7 (32M, 57.9, 40.3) 3 (39M, 36.0,44.4)

as per setting GIT_COMPRESSION 3 rather than Z_BEST_COMPRESSION

http://www.gelato.unsw.edu.au/archives/git/0504/1478.html


>>
>>                 user         system       real        du -sh
>>ver    files   hg    git    hg    git    hg    git    hg   git
>>
>>2.6.0  15007 19.949 35.526 3.171 2.264 25.138 87.994 145M   89M
>>2.6.1    998  5.906  4.018 0.573 0.464 10.267  5.937 146M   99M
>>2.6.2   2370  9.696 13.051 0.752 0.652 12.970 15.167 150M  117M
>>2.6.3   1906 10.528 11.509 0.816 0.639 18.406 14.318 152M  135M
>>2.6.4   3185 11.140  7.380 0.997 0.731 15.265 12.412 156M  158M
>>2.6.5   2261 10.961  6.939 0.843 0.640 20.564  8.522 158M  177M
>>2.6.6   2642 11.803 10.043 0.870 0.678 22.360 11.515 162M  197M
>>2.6.7   3772 18.411 15.243 1.189 0.915 32.397 21.498 165M  227M
>>2.6.8   4604 20.922 16.054 1.406 1.041 39.622 25.056 172M  262M
>>2.6.9   4712 19.306 12.145 1.421 1.102 35.663 24.958 179M  297M
>>2.6.10  5384 23.022 18.154 1.393 1.182 40.947 32.085 186M  338M
>>2.6.11  5662 27.211 19.138 1.791 1.253 42.605 31.902 193M  379M


-- 

Mike Taht


   "Imagination is more important than knowledge.
	-- Albert Einstein"
