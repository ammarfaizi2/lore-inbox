Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268678AbUHaOzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268678AbUHaOzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUHaOzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:55:50 -0400
Received: from mail.tmr.com ([216.238.38.203]:62469 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268678AbUHaOzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:55:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: an oops possibly due to an SMP related bug in netfilter
Date: Tue, 31 Aug 2004 10:56:36 -0400
Organization: TMR Associates, Inc
Message-ID: <ch2357$8hi$1@gatekeeper.tmr.com>
References: <20040830165753.GA22979@sch.bme.hu><20040830165753.GA22979@sch.bme.hu> <20040830172557.GD1029@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093963752 8754 192.168.12.100 (31 Aug 2004 14:49:12 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040830172557.GD1029@always.joy.eth.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua N Pritikin wrote:
> On Mon, Aug 30, 2004 at 06:57:53PM +0200, KOVACS Krisztian wrote:
> 
>>On Mon, Aug 30, 2004 at 05:38:09PM +0530, Joshua N Pritikin wrote:
>>
>>>(Perhaps I am one of the few people crazy enough to run a firewall on
>>>an SMP machine.  ;-)
>>> 
>>>CPU:    0 
>>>EIP:    0060:[<c8895955>]    Not tainted 
>>>EFLAGS: 00010246   (2.6.7)  
>>>EIP is at __ip_conntrack_find+0x179/0x1a0 [ip_conntrack] 
>>>eax: 00000001   ebx: 00000000   ecx: c0353cc0   edx: 00000000 
>>>esi: 00000000   edi: 00000000   ebp: c0353c88   esp: c0353c6c 
>>>ds: 007b   es: 007b   ss: 0068 
>>>Process swapper (pid: 0, threadinfo=c0352000 task=c0300980)
>>
>>  I don't think you're the only one running iptables on SMP... This looks
>>like a conntrack hash table corruption, so the first thing you should
>>check is your memory, of course. Are you 100 percent sure that it is ok?
> 
> 
> Fair enough.
> 
> Memtest86 doesn't spot anything BUT it could be due to voltage
> fluctuation.  I guess I can't run this motherboard without a UPS.
> 
Bad to guess, there's a program called memburn which may also be used. 
It's doing testing in a different way and I just grabbed it because 
someone in comp.sys.intel reported finding problems which memtest didn't 
show.

I run firewall on a LOT of dual Xeon+HT and ran iptables firewall on 
dual P5-166 until it died. I don't think there are problems.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
