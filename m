Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSHLDLG>; Sun, 11 Aug 2002 23:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318649AbSHLDLG>; Sun, 11 Aug 2002 23:11:06 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:52937 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S318643AbSHLDLF>; Sun, 11 Aug 2002 23:11:05 -0400
X-Uptime: 12:09pm  up 63 days,  2:02,  1 user,  load average: 0.00, 0.00, 0.00
X-OS: Linux hazuki 2.4.17 #5 SMP Tue Feb 19 12:06:25 JST 2002 i686 unknown
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ryan.flanigan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <200208120233.TAA16322@adam.yggdrasil.com>
X-Organization: IOS
X-Disclaimer: My opinions do not necessarily represent anything ...err those of my employer
Content-Type: text/plain; charset=US-ASCII
From: ryan.flanigan@intel.com (Flanigan, Ryan)
Date: 12 Aug 2002 12:09:28 +0900
In-Reply-To: "Adam J. Richter"'s message of "Sun, 11 Aug 2002 19:33:44 -0700"
Message-ID: <87ofc8vklz.fsf@hazuki.jp.intel.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adam" == Adam J Richter <adam@yggdrasil.com> writes:

    Adam> 	Ryan, thanks for suggesting that, as it would have taken
    Adam> me a long time to narrow it down that far!

np. 

    Adam> 	It would help avoid duplication of effort if you could
    Adam> indicate how along you are with this problem.  If you or

just a "test" build w/ PREEMPT enabled is when i noticed it. it
was the only thing i changed in the .config. so ... 
i just wanted to isolate it a bit more before posting.

    Adam> someone else has nailed the problem and is preparing a
    Adam> patch, then there is no point in anyone else trying to
    Adam> duplicate that debugging effort.  On the other hand, if you

i have only put in a few hours on the problem thus far, and plan
to continue tonight by looking to the  "hold atomic kmaps across 
generic_file_read" and "Forward port of get_user_pages() change 
from 2.4" patch by Andrew Morton <akpm@zip.com.au>.  thats my best 
guess thus far.  others might think differently (and they're probably 
right).

    Adam> just noticed CONFIG_PREEMPT was the difference between your
    Adam> configuration and that of someone else who was running
    Adam> 2.5.31 successfully and are not actively debugging the
    Adam> problem, then I'll try to poke at it some more.

please do. im still _slow_ when dealing with these things.

    Adam> 	I already know that the error that trips insmod occurs at
    Adam> in modules.c, line 831, when qm_symbols gets an error from
    Adam> copy_to_user():

agreed and thanks for the info!
                                        
