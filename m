Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTIIAMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTIIAMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:12:45 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:48900 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263765AbTIIAMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:12:43 -0400
Message-ID: <3F5D2007.5030500@techsource.com>
Date: Mon, 08 Sep 2003 20:34:15 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of AI for process scheduling
References: <Pine.LNX.4.44.0309081651220.22562-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:

> 
> the scheduler is by definition a real-time entity, if it takes twice as
> long to make a decision that in itself alters what the correct decision
> should be.
> 


My idea is to have the AI work in real-time just like the expert system 
would.  And I realize that this alters the situation, but it alters the 
situation in a constant way.  For a given number of context switches, 
the same number of scheduling decisions will be made.  That means that 
if the scheduler takes 100 times as long to decide, then all it will do 
is affect both the throughput and the latency in a constant way.

The only time it really matters is when the scheduler decision time 
makes something which would APPEAR to be interactive in the compiled 
case appear to be non-interactive in the AI case.  But that is no 
different from using a slower CPU.  There are LOTS of things that will 
feel smoother on a faster CPU.

So, if we can get a good interactive feel out of the AI case, then you 
will only get better results out of the compiled case.  Furthermore, 
good interactive results out of a fast CPU with the AI would imply good 
results out of a slower CPU in the compiled case.

I do realize that the balance is shifted.  The proportion of scheduler 
computation to user computation is thrown off.  (Still, same as using a 
slower CPU.)  But I don't think it matters.  If the scheduler were 100 
times slower, it would still require far far less than timeslice 
granularity to compute!

