Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUIWAB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUIWAB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUIWAB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:01:56 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:64880 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268121AbUIWABe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:01:34 -0400
Message-ID: <41521258.8000702@yahoo.com.au>
Date: Thu, 23 Sep 2004 10:01:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Habets <thomas@habets.pp.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
References: <200409230123.30858.thomas@habets.pp.se>
In-Reply-To: <200409230123.30858.thomas@habets.pp.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Habets wrote:
> Hello.
> 
> How about a sysctl that does "for the love of kbaek, don't ever kill these 
> processes when OOM. If nothing else can be killed, I'd rather you panic"?
> 
> Examples for this list would be /usr/bin/vlock and /usr/X11R6/bin/xlock. 
> I just got a very uncomfortable surprise when found my box unlocked thanks to 
> this.
> 
> After playing around a bit, I made the patch below, but it's almost completely 
> untested. I'm not even sure I take the binaries name from the right place. 
> And I don't know if the locking can race. If it's too ugly then it'd be great 
> if someone implemented it the right way. (iow: huge fucking disclaimer)
> 
> echo "/usr/bin/vlock /usr/X11R6/bin/xlock" > /proc/sys/vm/oom_pardon
> 

Hi,
Nice idea. It could probably made include-worthy if you just set a flag in the
task struct in question.

Also, use pid numbers instead of names, I think. (Or prctl? What is the
'preferred' way of setting random per-process flags?)

Nick
