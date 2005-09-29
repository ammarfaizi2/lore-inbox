Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVI2R3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVI2R3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVI2R3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:29:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:4077 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932278AbVI2R3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:29:07 -0400
Message-ID: <433C245D.7070707@pobox.com>
Date: Thu, 29 Sep 2005 13:29:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <willy@w.ods.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com>	 <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com>	 <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com>	 <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com>	 <20050929040403.GE18716@alpha.home.local> <1127979848.2918.7.camel@laptopd505.fenrus.org> <433C2137.1040108@s5r6.in-berlin.de>
In-Reply-To: <433C2137.1040108@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Arjan van de Ven wrote:
> 
>> On Thu, 2005-09-29 at 06:04 +0200, Willy Tarreau wrote:
>>
>>> On Wed, Sep 28, 2005 at 07:04:31PM -0400, Jeff Garzik wrote:
>>>
>>>> Linux is about getting things done, not being religious about 
>>>> specifications.  You are way too focused on the SCSI specs, and 
>>>> missing the path we need to take to achieve additional flexibility.
> 
> 
> AFAIU, demands to get our concepts closer to SAM concepts are actually 
> motivated by this: To achieve additional flexibility. (In particular, to 
> ease integration of the various transports.)

That's what transport classes help achieve.

We just gotta move gunk from the core (HCIL etc.) to scsi_transport_spi 
before we get there.


> We implement drivers of initiators. (Well, targets too.) The specs 
> describe _what_ initiators do. Thereby they partly describe _how_ 
> drivers of initiators (our sw pieces) work.

Mostly agreed.  Some of the firmware-based and emulated SCSI stuff is a 
bit of an I_T mix.


> However it is very desirable to reflect layers and concepts of the SAM 
> in our stack. One class of reasons is maintainability. No person is able 
> to understand the stack; nor is a person able to consume and understand 
> all or even half of the SCSI specs. No person is able to construct a 
> mapping between the whole stack and the whole SCSI-3 Architecture Model 
> (in his mind or with pencil and paper...). Therefore there have to be 
> _components_ of the stack's architecture model which map 1:1 to 
> _components_ of the SCSI-3 Architecture Model.
> 
> Fortunately, SAM layers and concepts are already there in the stack, 
> although incomplete and incoherent. It will always be disputable _how_ 
> complete and coherent our software should be in this respect. However it 
> is out of a question that our software's architecture model might 
> arbitrarily differ from the SAM.

I think just about everybody agrees with this.

The current thread is more about the path to take, to get there...

The general point about specs is that you gotta think about them, not 
just blindly implement them.  SNIA for example is notorious for 
generating silly storage-related specifications.  And some of the T10 
stuff is... well... obviously designed by committee :)

	Jeff


