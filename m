Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVAADLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVAADLg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 22:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVAADLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 22:11:33 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:9211 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262182AbVAADLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 22:11:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
Date: Fri, 31 Dec 2004 22:11:17 -0500
User-Agent: KMail/1.7
Cc: Jim Nelson <james4765@cwazy.co.uk>, Postmaster@verizon.net,
       kernel-janitors@lists.osdl.org
References: <20041231014403.3309.58245.96163@localhost.localdomain> <200412312035.02761.gene.heskett@verizon.net> <41D60129.3070002@cwazy.co.uk>
In-Reply-To: <41D60129.3070002@cwazy.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412312211.17950.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 21:11:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 20:47, Jim Nelson wrote:
>Gene Heskett wrote:
>> On Friday 31 December 2004 20:14, Gene Heskett wrote:
>>>On Friday 31 December 2004 19:13, Russell King wrote:
>>>>To: no To-header on input <>
>>>
>>>Thats the To: line of this message Russell, as it came in here.  I
>>>assume it was originally filled in to be to me and that you
>>> cleaned that to prevent your getting a bounce from verizon?
>>>
>>>And no, it hasn't bounced yet as it typically will lay in the
>>> queue somewhere in lala land for anywhere from 4 hours to 6 or 7
>>> days.  By that time the friggin message is no longer germain to
>>> the conversation, so they get deleted here.
>>
>> Now, this message did bounce, and the bounce message is damned
>> confusing...
>>
>> From: Mail Administrator <Postmaster@verizon.net>
>>  To: gene.heskett@verizon.net
>>
>> This Message was undeliverable due to the following reason:
>>
>> Your message was not delivered because the destination computer
>> was not found.  Carefully check that it was spelled correctly and
>> try sending it again if there were any mistakes.
>>
>> It is also possible that a network problem caused this situation,
>> so if you are sure the address is correct you might want to try to
>> send it again.  If the problem continues, contact your friendly
>> system administrator.
>>
>>      Host coyote.coyote.den not found
>>
>> The following recipients did not receive this message:
>>
>>      <""@coyote.coyote.den>
>>
>> Please reply to Postmaster@verizon.net
>> if you feel this message to be in error.
>> --------------------------
>> coyote.coyote.den is indeed the name of this machine, but I should
>> be known to the outside world as gene.heskett AT verizon.net.
>>
>> So the $64,000 question is how did that domain name even get to
>> the outside world.
>>
>> Here is the complete header from the message that elicited that
>> response from verizons servers.
>> From: Gene Heskett <gene.heskett@verizon.net>
>>  Reply-To: gene.heskett@verizon.net
>>  Organization: Organization: None, detectable by casual observers
>>  To: linux-kernel@vger.kernel.org
>>  Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
>>  Date: Fri, 31 Dec 2004 20:14:39 -0500
>>  User-Agent: KMail/1.7
>>  Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
>>  Jim Nelson <james4765@cwazy.co.uk>,
>>  Andrew Morton <akpm@osdl.org>,
>>  kernel-janitors@lists.osdl.org
>>  References:
>> <20041231014403.3309.58245.96163@localhost.localdomain>
>> <200412311901.50638.gene.heskett@verizon.net>
>> <20050101001311.D10216@flint.arm.linux.org.uk>
>>  In-Reply-To: <20050101001311.D10216@flint.arm.linux.org.uk>
>>  X-KMail-Link-Message: 676118
>>  X-KMail-Link-Type: reply
>>  MIME-Version: 1.0
>>  Content-Type: text/plain;
>>   charset="us-ascii"
>>  Content-Transfer-Encoding: 7bit
>>  Content-Disposition: inline
>>  Message-Id: <200412312014.39618.gene.heskett@verizon.net>
>>  Status: RO
>>  X-Status: RSC
>>  X-KMail-EncryptionState:
>>  X-KMail-SignatureState:
>>  X-KMail-MDN-Sent:
>>
>> On Friday 31 December 2004 19:13, Russell King wrote:
>>>To: no To-header on input <>
>>
>> And there sure as heck isn't any mention of 'coyote.coyote.den' in
>> that.
>
> From my perspective:
[...]
------------------------
>Received: from coyote.coyote.den ([151.205.52.185]) by
> out003.verizon.net (InterMail vM.5.01.06.06
> 201-253-122-130-106-20030910) with ESMTP id
> <20050101013503.LVAF1106.out003.verizon.net@coyote.coyote.den>;
--------
I still wonder.  And no, AFAIK I am not running a mail server, just 
kmail from a kde 3.3.0 build by konstruct.

The actual path from coyote.coyote.den at 192.168.xx.xx goes thru an 8 
port netgear switch, to my firewall, gene.coyote.den via the eth1 
interface in that machine, gets noted by iptables, and forwarded to 
router.coyote.den in a different subnet of the 192.168.xx.xx block.  
router.coyote.den is a linksys BEFSR41 set for gateway mode, which 
sends it thru its NAT and PPPoE to the wan port and the westel dsl 
modem.  So the quoted address in the 151.205.xx.xx block above 
doesn't exist on my side of the BEFSR41.  Kmails sending is 
configured for smtp, with the output address & password direct to 
incoming.verizon.net.

If somehow, the smtp is adding my local hostname so that my regular 
address is munged, how can I fix that?  Or is it my problem since the 
header of the outgoing message copy in kmails sent mail folder 
contains no such data.  Is that not a verbatum copy of whats sent.  
If not, then it sounds like its time to file a bug against kmail.

[...]

>Are you running your own MTA?  That would explain a lot - Verizon's
> mailservers are touchy at best.

See above description and tell me, I am apparently a big dummy.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
