Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275357AbTHSGAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275365AbTHSGAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:00:16 -0400
Received: from anumail3.anu.edu.au ([150.203.2.43]:18862 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S275357AbTHSGAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:00:10 -0400
Message-ID: <3F41B8D0.8060709@cyberone.com.au>
Date: Tue, 19 Aug 2003 15:42:40 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: "Anthony R." <russo.lutions@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: cache limit
References: <3F41AA15.1020802@verizon.net>
In-Reply-To: <3F41AA15.1020802@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.9)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_03_05,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony R. wrote:

>Hi,
>  
>
>
>I would like to tune my kernel not to use as much memory for cache
>as it currently does. I have 2GB RAM, but when I am running one program
>that accesses a lot of files on my disk (like rsync), that program uses
>most of the cache, and other programs wind up swapping out. I'd prefer to
>have just rsync run slower because less of its data is cached, rather
>than have
>all my other programs run more slowly. rsync is not allocating memory,
>but the kernel is caching it at the expense of other programs.
>
>With 2GB on a system, I should never page out, but I consistently do and I
>need to tune the kernel to avoid that. Cache usage is around 1.4 GB!
>I never had this problem with earlier kernels. I've read a lot of comments
>where so-called experts poo-poo this problem, but it is real and
>repeatable and I am
>ready to take matters into my own hands to fix it. I am told the cache
>is replaced when
>another program needs more memory, so it shouldn't swap, but that is not
>the
>behaviour I am seeing.
>
>Can anyone help point me in the right direction?
>Do any kernel developers care about this?
>
>My kernel is stock 2.4.21, I run Redhat 9 on a 3GHz P4. I'd give you MB
>info but I've seen
>this behaviour on other motherboards as well.
>
>Thank you very much for your help.
>
>-- tony
>"Surrender to the Void." 
>-- John Lennon
>
>

Hi Anthony,
If you're up for a bit of work, give the "aa" series kernels a try, also
see how 2.6-test goes and be sure to report any problems you encounter.

The VM in stock 2.4 is slow to pick up updates due to being a stable series.
The problems definitely won't get poo-pooed here. Be sure you include a
good description of your workload and probably a log of vmstat 1 to start
with.



