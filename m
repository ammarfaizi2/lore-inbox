Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUGTUAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUGTUAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUGTT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:58:08 -0400
Received: from mail.tmr.com ([216.238.38.203]:16909 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266188AbUGTTyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:54:49 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.7 SMP trouble?
Date: Tue, 20 Jul 2004 15:57:23 -0400
Organization: TMR Associates, Inc
Message-ID: <cdjt08$c70$1@gatekeeper.tmr.com>
References: <2873B794CB1BE04F80E2968B438680E503ACF5C1@server6.ctg.com><2873B794CB1BE04F80E2968B438680E503ACF5C1@server6.ctg.com> <Pine.LNX.4.53.0407191557590.3740@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090352968 12512 192.168.12.100 (20 Jul 2004 19:49:28 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.53.0407191557590.3740@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Mon, 19 Jul 2004, Jason Gauthier wrote:
> 
> 
>>I've found an IBM netfinity (5600) box that was shelved a few years ago.  I
>>spent $80 and got two processors for it. (P3-667).
>>
>>I put them in the box, installed Linux (slackware) and upgraded the kernel
>>to 2.6.7.  I then started installing my software on it.  Nagios, MRTG,
>>samba, and some other tools we use for network monitoring.  This is going to
>>be an upgrade to a monitoring server we have.  Well, I went home, came in
>>the next day and the box was locked hard.  No messages, no console output.
>>Just dead.
>>
>>Thinking it was a fluke, I fired it up.  Again, after several hours running;
>>total death.  So, I figured I have two options.  Software or hardware is
>>making it die.  I removed each processor in turn, and ran the box for over
>>24 hours under HIGH stress. (5+ load average). The system is running the
>>above mentioned software.  But, just to make sure this processor gets a
>>workout I am compiling code over and over.  Both processors have been rock
>>solid for the duration of the test.
>>
>>I then placed both processors in the box and started the same test.  It was
>>dead within 8 hours.  I am now very suspicious of the kernel.
>>
>>So, I installed 2.4.22 and ran the same tests.  It went over 48 hours with
>>no issues.  Now I'm certain it's the kernel.  Can anyone confirm any SMP
>>issues that might cause this?
>>
>>Thanks,
>>
>>Jason
> 
> 
> Another data-point. I haven't been able to run any new (2.6+) kernel
> reliably in a SMP machine. They stop. Just like you noted. That's
> why all my SMP machines still run 2.4.26. It's rock solid and has
> the latest-and-greatest updates (there's a -pre-27 coming out).
> Anyway, for production machines, you probably need to run 2.4.26.
> 
> If you don't really need anything reliable, you might try to enable
> Sys Req and see if you can find out where it's stopped. When my
> machines stop, the CPUs get cold, just like their clocks were
> shut off! -- another data-point --

I suspect it's s config thing, rather than some overall evil, I have 
some production machines up 72+ days. These are production news servers 
with hundreds of users all day long.

The exact version is 2.6.5aa5, but I had a 2.6.7 up for 30 days or so 
until AS3.0 got a hotfix for my applications.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
