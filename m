Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268117AbTAJDIZ>; Thu, 9 Jan 2003 22:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268119AbTAJDIZ>; Thu, 9 Jan 2003 22:08:25 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:20276 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S268117AbTAJDIY>; Thu, 9 Jan 2003 22:08:24 -0500
Message-ID: <3E1E3B64.5040803@emageon.com>
Date: Thu, 09 Jan 2003 21:17:56 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>>At some point in the past, I wrote:
 >>> Either pollwait tables (invisible in 2.4 and 2.5), kernel stacks of
 >>> threads (which don't get pae_pgd's and are hence invisible in 2.4
 >>> and 2.5), or pagecache, with a much higher likelihood of pagecache.

 >>On Thu, Jan 09, 2003 at 06:44:10PM -0600, Brian Tinsley wrote:
 >> The "kernel stacks of threads" may have some bearing on my incarnation
 >> of this problem. We have several heavily threaded Java applications
 >> running at the time the live-locks occur. At our most problematic site,
 >> one application has a bug that can cause hundreds of timer threads (I
 >> mean like 800 or so!) to be "accidentally" created. This site is
 >> scheduled for an upgrade either tonight or tomorrow, so I will leave the
 >> system as it is and see if I can still cause the live-lock to manifest
 >> itself after the upgrade.

 >There is no extant implementation of paged stacks yet.

For the most part, this is probably a boundary condition, right? Anyone 
that intentionally has 800+ threads in a single application probably 
needs to reevaluate their design :)

 >I'm working on a different problem (mem_map on 64GB on 2.5.x). I probably
 > won't have time to implement it in the near future, I probably won't 
be doing it
 >vs. 2.4.x, and I won't have to if someone else does it first.

Is that a hint to someone in particular?



-- 

-[========================]-
-[      Brian Tinsley     ]-
-[ Chief Systems Engineer ]-
-[        Emageon         ]-
-[========================]-


