Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVAABrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVAABrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 20:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVAABrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 20:47:21 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:17822 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262174AbVAABrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 20:47:06 -0500
Message-ID: <41D60129.3070002@cwazy.co.uk>
Date: Fri, 31 Dec 2004 20:47:21 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Postmaster@verizon.net,
       kernel-janitors@lists.osdl.org
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
References: <20041231014403.3309.58245.96163@localhost.localdomain> <20050101001311.D10216@flint.arm.linux.org.uk> <200412312014.39618.gene.heskett@verizon.net> <200412312035.02761.gene.heskett@verizon.net>
In-Reply-To: <200412312035.02761.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.220.243] at Fri, 31 Dec 2004 19:47:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Friday 31 December 2004 20:14, Gene Heskett wrote:
> 
>>On Friday 31 December 2004 19:13, Russell King wrote:
>>
>>>To: no To-header on input <>
>>
>>Thats the To: line of this message Russell, as it came in here.  I
>>assume it was originally filled in to be to me and that you cleaned
>>that to prevent your getting a bounce from verizon?
>>
>>And no, it hasn't bounced yet as it typically will lay in the queue
>>somewhere in lala land for anywhere from 4 hours to 6 or 7 days.  By
>>that time the friggin message is no longer germain to the
>>conversation, so they get deleted here.
> 
> 
> Now, this message did bounce, and the bounce message is damned 
> confusing...
> 
> From: Mail Administrator <Postmaster@verizon.net>
>  To: gene.heskett@verizon.net
>  
> This Message was undeliverable due to the following reason:
> 
> Your message was not delivered because the destination computer was
> not found.  Carefully check that it was spelled correctly and try
> sending it again if there were any mistakes.
> 
> It is also possible that a network problem caused this situation,
> so if you are sure the address is correct you might want to try to
> send it again.  If the problem continues, contact your friendly
> system administrator.
> 
>      Host coyote.coyote.den not found
> 
> The following recipients did not receive this message:
> 
>      <""@coyote.coyote.den>
> 
> Please reply to Postmaster@verizon.net
> if you feel this message to be in error.
> --------------------------
> coyote.coyote.den is indeed the name of this machine, but I should be 
> known to the outside world as gene.heskett AT verizon.net.
> 
> So the $64,000 question is how did that domain name even get to the 
> outside world.
> 
> Here is the complete header from the message that elicited that 
> response from verizons servers.
> From: Gene Heskett <gene.heskett@verizon.net>
>  Reply-To: gene.heskett@verizon.net
>  Organization: Organization: None, detectable by casual observers
>  To: linux-kernel@vger.kernel.org
>  Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
>  Date: Fri, 31 Dec 2004 20:14:39 -0500
>  User-Agent: KMail/1.7
>  Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
>  Jim Nelson <james4765@cwazy.co.uk>,
>  Andrew Morton <akpm@osdl.org>,
>  kernel-janitors@lists.osdl.org
>  References: <20041231014403.3309.58245.96163@localhost.localdomain> 
> <200412311901.50638.gene.heskett@verizon.net> 
> <20050101001311.D10216@flint.arm.linux.org.uk>
>  In-Reply-To: <20050101001311.D10216@flint.arm.linux.org.uk>
>  X-KMail-Link-Message: 676118
>  X-KMail-Link-Type: reply
>  MIME-Version: 1.0
>  Content-Type: text/plain;
>   charset="us-ascii"
>  Content-Transfer-Encoding: 7bit
>  Content-Disposition: inline
>  Message-Id: <200412312014.39618.gene.heskett@verizon.net>
>  Status: RO
>  X-Status: RSC
>  X-KMail-EncryptionState: 
>  X-KMail-SignatureState: 
>  X-KMail-MDN-Sent: 
>  
> On Friday 31 December 2004 19:13, Russell King wrote:
> 
>>To: no To-header on input <>
> 
> 
> And there sure as heck isn't any mention of 'coyote.coyote.den' in 
> that.
> 

 From my perspective:
 From - Fri Dec 31 20:42:48 2004
X-UIDL: <59229-2004-1231-193921-22204@st108mss.verizon.net>
X-Mozilla-Status: 0011
X-Mozilla-Status2: 00000000
Return-Path: 
<linux-kernel-owner+james4765=40verizon.net-S262173AbVAABfz@vger.kernel.org>
Received: from vger.kernel.org ([206.46.170.120]) by mta008.verizon.net
           (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
           id <20050101013921.PWOD28241.mta008.verizon.net@vger.kernel.org>
           for <james4765@verizon.net>; Fri, 31 Dec 2004 19:39:21 -0600
Received: from vger.kernel.org (12.107.209.244) by sc009pub.verizon.net (MailPass 
SMTP server v1.1.1 - 121803235448JY) with  ESMTP id 
<1-995-136-995-258990-6-1104543560> for mta008.verizon.net; Fri, 31 Dec 2004 
19:39:21 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVAABfz (ORCPT <rfc822;james4765@verizon.net>);
	Fri, 31 Dec 2004 20:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVAABfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 20:35:54 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:39854 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262173AbVAABfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 20:35:04 -0500
Received: from coyote.coyote.den ([151.205.52.185]) by out003.verizon.net
           (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
           id <20050101013503.LVAF1106.out003.verizon.net@coyote.coyote.den>;
           Fri, 31 Dec 2004 19:35:03 -0600
From:	Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To:	linux-kernel@vger.kernel.org, Postmaster@verizon.net
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
Date:	Fri, 31 Dec 2004 20:35:02 -0500
User-Agent: KMail/1.7
Cc:	Russell King <rmk+lkml@arm.linux.org.uk>,
	Jim Nelson <james4765@cwazy.co.uk>,
	Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org
References: <20041231014403.3309.58245.96163@localhost.localdomain> 
<20050101001311.D10216@flint.arm.linux.org.uk> 
<200412312014.39618.gene.heskett@verizon.net>
In-Reply-To: <200412312014.39618.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
   charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412312035.02761.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from 
[151.205.52.185] at Fri, 31 Dec 2004 19:35:03 -0600
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

Are you running your own MTA?  That would explain a lot - Verizon's mailservers 
are touchy at best.
