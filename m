Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbTIHWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTIHWj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:39:56 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:18707 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263688AbTIHWju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:39:50 -0400
Message-ID: <3F5D0A41.9090807@techsource.com>
Date: Mon, 08 Sep 2003 19:01:21 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of AI for process scheduling
References: <3F5CD863.4020605@techsource.com> <1063060111.1224.2.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe Alfaro Solana wrote:
> On Mon, 2003-09-08 at 21:28, Timothy Miller wrote:
> 
> 
>>Basically, we need to write and install into the kernel an AI engine
>>which uses user feedback about the "feel" of the system to adjust
>>heuristics dynamically.  For instance, if the user sees that the system
>>is misbehaving, they can pause the system in the kernel debugger,
>>examine process priorities, and indicate what "outputs" from the AI
>>engine are wrong.  It then learns from that.  Heuristics can be tweaked
>>until things run as desired.  At that point, scheduler developers trade
>>emails in the AI heuristic language.
> 
> 
> I'm no kernel expert but I think that doing what you suggest would take
> an enormous amount of time and resources to do. Also, the scheduler must
> be a real-time piece of software, and needs to take decisions as fast
> and as accurately as possible. I think that implementing an IA-like
> engine would take an great deal of resources. By the time the IA-like
> scheduler has taken its decision, the whole world could have changed
> since.

The AI scheduler is only used for _development_.

For deployment, the rules learned from the AI scheduler are converted to 
C code (or compiled directly to machine language) and used in real-time. 
  I don't expect the rules to be so complex that the C version would use 
much more CPU than the current interactive schedulers being worked on by 
Con, Ingo, and Nick.

During development, the AI scheduler would be used in real-time, and 
that would have a significant effect on the performance of the system. 
But since it's a constant, the relative interactive behavior should be 
about the same between AI and deployed versions, even though the AI 
version uses a lot more CPU time in the kernel.  That is, if the system 
works well with the AI scheduler, it'll work even BETTER with the 
compiled version.

