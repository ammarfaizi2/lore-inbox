Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269298AbUI3PK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269298AbUI3PK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269304AbUI3PK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:10:27 -0400
Received: from mail.tmr.com ([216.238.38.203]:46086 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269298AbUI3PKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:10:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ESP corruption bug - what CPUs are affected?
Date: Thu, 30 Sep 2004 11:11:41 -0400
Organization: TMR Associates, Inc
Message-ID: <cjh76u$56l$2@gatekeeper.tmr.com>
References: <4155D7D2.8000705@aknet.ru><4155D7D2.8000705@aknet.ru> <20040925234214.GA10603@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096556575 5333 192.168.12.100 (30 Sep 2004 15:02:55 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20040925234214.GA10603@iram.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:
> 	Hi,
> 
> 
>>It does not restore it in any case for the 16bit
>>stack (no matter whether the code is 16 or 32 in PM).
>>Petr says V86 is not affected, but I have not tested
>>that case because why to care? The problem is only for
>>the 32bit code. For 16bit code (PM or V86) it just
>>doesn't really matter I think (I don't think using
>>prefixes for ESP is sane).
> 
> 
> Well, thrashing a register at any time under the user
> just because an interrupt happened is even less sane ;-)
> 
> 
>>>I'm absolutely amazed by the fact that this bug has been there
>>>since the beginning and only seems to hit users right now.
>>
>>No, right now it just hits me:)
>>It used to hit the dosemu users always, but people just
>>blamed dosemu itself and that was it. Noone wanted
>>to spend weeks traceing the DOS programs under dosemu,
>>then traceing dosemu itself, then traceing kernel,
>>then looking through the docs to track the problem down
>>to something known, then writing to Intel's techsup for
>>clarifications, and then writing to LKML:) And if not
>>for the great help I got here, this will end up nowhere
>>again. So that's how it used to stay "unnoticed" for
>>years.
> 
> 
> I see. And finally we know that the problem with the
> processor and that Intel changed the spec to conform
> to what the hardware does but is rather coy about it.
> 
> 
>>As for the other instances of that problem, here are some:
>>
>>http://www.tenberry.com/dos4g/watcom/rn4gw.html
>>---
>>B ** Fixed the mouse32 handler to ignore a Microsoft Windows DOS box bug
>>    which mangles the high word of ESP.
> 
> 
> But if the bug is also affects Windows DOS box, it means that
> V86 is affected too, no? 
> 
> I'd like to know what OS/2 did. The DOS boxes and 16 bit mode
> DPMI applications ran very well and it was very stable, despite
> the fact that the kernel spent its time switching between 16
> and 32 bit modes (for example, almost all device drivers were 
> 16 bit code, but the drivers for DOS emulation were 32 bit).
> But I removed it from all my machines several years ago.

May I suggest that IBM is a friend of Linux, and that *if* there is a 
simple way to get around the problem they will probably be very willing 
to share it with us.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
