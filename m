Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265778AbUFYIwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUFYIwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUFYIwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:52:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:51467 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265778AbUFYIwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:52:32 -0400
Message-ID: <40DBE853.4050707@hist.no>
Date: Fri, 25 Jun 2004 10:54:43 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware - memory problem?
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua> <20040624202626.GS728@washoe.rutgers.edu> <200406242358.55782.vda@port.imtp.ilyichevsk.odessa.ua> <20040624212600.GW728@washoe.rutgers.edu> <20040624215856.GA728@washoe.rutgers.edu> <20040625000102.GI728@washoe.rutgers.edu>
In-Reply-To: <20040625000102.GI728@washoe.rutgers.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko wrote:

>because slow down seems to be linked to memory: brk(0) takes on average
>0.5-1.5 second, I've decided to run silly memtest...
>I have around 1GB total on that beast, I turned off swap and did memtest
>1G
>  
>
Memory.  Could it be the good old MTRR problem?
Try "cat /proc/mtrr" and check that _all_ ordinary memory
is covered by a write-back mtrr.

Having most of the memory covered lacking a little at the top only
is not good enough - you'll see a major slowdown as linux tend to
use the topmost memory most and that will be very slow without
a MTRR.

If it indeed is a mtrr problem, confirm it by booting with mem=<low number>
and see that the machine is faster when not using the "slow" memory.
After that, get a bios upgrade or echo something useable
into /proc/mtrr

Helge Hafting
