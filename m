Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268692AbUHLTwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268692AbUHLTwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268699AbUHLTwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:52:42 -0400
Received: from mail.tmr.com ([216.238.38.203]:8210 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268692AbUHLTwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:52:12 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.xSMP and IPv4 issues (ifconfig(s))
Date: Thu, 12 Aug 2004 15:55:49 -0400
Organization: TMR Associates, Inc
Message-ID: <cfghdv$g58$1@gatekeeper.tmr.com>
References: <5D229985.7782B8C2.345005B1@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092339967 16552 192.168.12.100 (12 Aug 2004 19:46:07 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <5D229985.7782B8C2.345005B1@netscape.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> 
> 
>>You should connect your box to another one and verify that
>>network is ok (it is working under non-SMP kernel, right?).
>>Most probably you already did this. :)
>>
>>Then, do this ping test again, and while ping is running, do
>>
>>tcpdump -nleieth0 -s0 -vvv
>>
>>on both boxes. You will see what is happening on the wire.
>>For example, does other box actually hear anything?
>>
>>
>>>New! Netscape Toolbar for Internet Explorer
>>
>>Heh.
>>--
>>vda
>>
>>
> 
> 
> Not to switch gears on you, but...
> 
> I have a "fix", through some feedback from the fedora-legacy-project list I was directed to send the command 'noapic' at boot time.  To see if this would have some effect on the IPv4 problem.
> 
> This allowed IPv4 to operate with the SMP kernel!!!
> 
> So, can anyone explane what is going on with this...
> Is it my motherboard/bios having communication issues with the SMP kernel, but not with the non-SMP kernel?

I suspect that the on-CPU interrupt controllers are not getting 
initialized correctly. Using noapic can slow the communication between 
processors, although I've never been able to measure it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
