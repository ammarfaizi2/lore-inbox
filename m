Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTKFJPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTKFJPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:15:39 -0500
Received: from bay4-f40.bay4.hotmail.com ([65.54.171.40]:59916 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263464AbTKFJPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:15:38 -0500
X-Originating-IP: [202.172.55.22]
X-Originating-Email: [slashboy84@msn.com]
From: "Wee Teck Neo" <slashboy84@msn.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
Date: Thu, 06 Nov 2003 17:15:33 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY4-F40qelZScM4qcI00005e31@hotmail.com>
X-OriginalArrivalTime: 06 Nov 2003 09:15:33.0226 (UTC) FILETIME=[87F6A4A0:01C3A446]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   procs                      memory      swap          io     system      
cpu
r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id
1  0  0  92744   9640  20240 801644    0    0     3    10   17     0 25  2 
10


This one will be wierd.

I'm having 4 program running at background using 50MB each (got it from 
"top")
Total up to about 200MB.

The system is having 1GB ram and currently using 92MB as swap. Why does the 
system use the slower swap when there are still memory available (as cache). 
Anyway to "force" the system to use more ram instead of putting into swap 
memory?



----Original Message Follows----
From: Helge Hafting <helgehaf@aitel.hist.no>
To: Wee Teck Neo <slashboy84@msn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
Date: Thu, 06 Nov 2003 10:11:50 +0100

Wee Teck Neo wrote:
>My system having 1GB ram and this is the output of vmstat
>
>   procs                      memory      swap          io     system      
>cpu
>r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
>id
>0  0  0   5640  21224 121512 797832    0    0     6     9    3    17  0  0  
>6
>
>
>It seems that 797MB is used for caching... thats a high number. Anyway to 
>set a lower cache size?

Yes - _use_ the memory for something else. 1. All unused memory will be put 
to good use as cache.
2. Memory is taken from the cache whenever you need it for
   something else, so (1) is not a problem at all.

Helge Hafting

_________________________________________________________________
Take a break! Find destinations on MSN Travel. http://www.msn.com.sg/travel/

