Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUGCNwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUGCNwB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 09:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUGCNwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 09:52:01 -0400
Received: from mail.tmr.com ([216.238.38.203]:30106 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S265093AbUGCNv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 09:51:57 -0400
Message-ID: <40E6BB39.4080405@tmr.com>
Date: Sat, 03 Jul 2004 09:57:13 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Siebenmann <cks@utcc.utoronto.ca>
CC: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux scheduler (scheduling) questions vs threads
References: <04Jul1.223441edt.41896@gpu.utcc.utoronto.ca>
In-Reply-To: <04Jul1.223441edt.41896@gpu.utcc.utoronto.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Siebenmann wrote:
> You write:
> | Ingo Molnar wrote:
> [...]
> | > so the normal Linux scheduling policy applies to 'threads' too. [...]
> [...]
> | On a multi-user machine this may result in undesirable behaviour, since 
> | each thread seems to compete for resources and the machine may get VERY 
> | slow if someone deos something anti-social.
> 
>  This is nothing unique to threads; the same problem appears if a
> program (or a user) uses a bunch of CPU-eating processes. I imagine
> that any real solution will have to be per-user 'beancounting' and
> limits, which have yet to make it into the Linux kernel.

Actually, yes it is. While students can be warned about the results of 
fork bombing a system, both in terms of what happens to the system and 
to their access, it's far less obvious that starting a program which 
does a lot of threads is equally bad behaviour.

The desirability for per-user scheduling is also shown by the student 
who build a large project with "-j4" as a make option and "-pipe" as a 
compile option. Yes, it makes the program complete sooner, and it 
generally is done with no malice.

Hopefully some form of this will appear in the 2.7 kernel, although past 
discussions in several places have resulted in more heat than light on 
the topic.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
