Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUINCCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUINCCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUINCCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:02:34 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:30904 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269104AbUINCC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:02:26 -0400
Message-ID: <4146512E.3000607@yahoo.com.au>
Date: Tue, 14 Sep 2004 12:02:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
References: <20040913015003.5406abae.akpm@osdl.org> <20040913110611.0ce875cf.pj@sgi.com> <200409131110.17588.jbarnes@engr.sgi.com> <200409131430.30499.jbarnes@engr.sgi.com>
In-Reply-To: <200409131430.30499.jbarnes@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------070009070002090403080403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070009070002090403080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jesse Barnes wrote:
> On Monday, September 13, 2004 11:10 am, Jesse Barnes wrote:
> 
>>On Monday, September 13, 2004 11:06 am, Paul Jackson wrote:
>>
>>>Jesse wrote:
>>>
>>>>I'll send out a more complete one later (unless
>>>>Paul beat me to it,

Sorry, I actually did read your mail about the SD_NODE_INIT thing. It
slipped my mind :(

>>>
>>>See my patch posted a few hours ago:
>>>
>>>  [Patch] Fix sched make domain setup overridable
>>
>>Yeah, I saw that, thanks.  I meant a more complete dmesg (i.e. one for a
>>bigger system).  I've got a 32p reserved for later today.
> 
> 
> Here's one from a 32p, 16 node machine (captured while scsi was still coming 
> up, but you probably don't care about that).
> 

OK, in that case you'll also need the attached patch.
Sigh. We'll get there one day.

--------------070009070002090403080403
Content-Type: text/x-patch;
 name="ia64-make-node-balance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ia64-make-node-balance.patch"




---

 linux-2.6-npiggin/include/asm-ia64/processor.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN include/asm-ia64/processor.h~ia64-make-node-balance include/asm-ia64/processor.h
--- linux-2.6/include/asm-ia64/processor.h~ia64-make-node-balance	2004-09-14 11:57:05.000000000 +1000
+++ linux-2.6-npiggin/include/asm-ia64/processor.h	2004-09-14 11:57:38.000000000 +1000
@@ -349,7 +349,8 @@ struct task_struct;
 	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
-	.flags			= SD_BALANCE_EXEC	\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_EXEC	\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 10,			\

_

--------------070009070002090403080403--
