Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUDECMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 22:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUDECMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 22:12:42 -0400
Received: from mail.tmr.com ([216.238.38.203]:57100 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263015AbUDECMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 22:12:39 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
Date: Sun, 04 Apr 2004 22:14:57 -0400
Organization: TMR Associates, Inc
Message-ID: <c4qf6n$1qj$2@gatekeeper.tmr.com>
References: <406FC621.1090507@A88da.a.pppool.de> <1081108674.1072.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081131031 1875 192.168.12.10 (5 Apr 2004 02:10:31 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1081108674.1072.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Ramendik wrote:
> Hello,
> 
> Andreas Hartmann wrote:
> 
>>>As recommended there, I have tried 2.6.5-rc3-mm4.
>>>
>>>No change. Still 100% CPU usage; the performance seems teh same.
>>
>>Yes. But it's curious:
>>Take a tar-file, e.g. tar the compiled 2.6 kernel directory. Than, untar 
>>it again - the machine behaves total normaly. 
> 
> 
> Not really. I tried a "simple" tar (no gzib/bzip2) - it was the same as
> with cp, a near-100% CPU "system" load, most of it iowait.

??? was it in system or wait-io? One or the other, if you can't tell the 
difference update your tools, see what's really happening.
> 
> If I use bzip2 with tar, then yes, the load is nearly 100% "user",
> actually it's bzip2. But this is because the disk i/o is done at a *far*
> slower rate; the bottleneck is the CPU. If we don't read (or write) the
> disk heavily, naturally the system/iowait load is low.
> 
> I tried doing a "cp" in another xterm window, while the tar/bzip2 was
> running. And sure enough, up the CPU system/iowait usage goes - the
> "cp"'s disk i/o takes much of the CPU time away from the bz2 task! Looks
> exactly like a cause of performance problems.
> 
> (All of this was done on 2.6.5-rc3-mm4).

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
