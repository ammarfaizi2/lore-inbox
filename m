Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTEFNP7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbTEFNP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:15:59 -0400
Received: from mailsrv1-tu0.sanger.ac.uk ([193.62.206.128]:35341 "EHLO
	mailsrv1.sanger.ac.uk") by vger.kernel.org with ESMTP
	id S263655AbTEFNP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:15:57 -0400
Message-ID: <3EB7B879.4040405@thekelleys.org.uk>
Date: Tue, 06 May 2003 14:28:25 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Binary firmware in the kernel - licensing issues.
References: <3EB79ECE.4010709@thekelleys.org.uk> <1052219735.28796.28.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1052219735.28796.28.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-05-06 at 12:38, Simon Kelley wrote:
> 
>>This software is copyrighted by and is the sole property of Atmel
>>Corporation.  All rights, title, ownership, or other interests
>>in the software remain the property of Atmel Corporation.  This
>>software may only be used in accordance with the corresponding
>>license agreement.  Any un-authorized use, duplication, transmission,
>>distribution, or disclosure of this software is expressly forbidden. 
> 
> 
> So you can't distribute it at all unless there is other paperwork
> involved.

That's what it says, but I don't think it was the intention, given
that the company itself published the source under the GPL  and put them 
up on Sourceforge. What I need is the correct legalese to replace the
above which makes it legal to redistribute (easy) and to combine with
the GPL'd bulk of linux - that's the difficult bit. Once I have
said legalese I'll put it to Atmel with the message "this is what I
think you _meant_ to say."
> 
> 
>>Given the current SCO-IBM situation I don't want to be responsible for
>>introducing any legally questionable IP into the kernel tree.
>>
>>This situation must have come up before, how was it solved then?
> 
> 
> The easiest approach is to do the firmware load from userspace - which
> also keeps the driver size down and makes updating the firmware images
> easier for end users.

That has attractions, especially since there are half a dozen different
firmware images for different hardware variants, and some cards have
flash and don't need loading at all. OTOH one of the my goals is to have 
the driver just there in the kernel, and not to need extra stuff to make
it work.

My current plan is to make separate modules for each firmware image so 
that people only need to compile in/load the one they need.

> 
> (Debian as policy will rip the firmware out anyway regardless of what
> Linus does btw)

Without exception? Time to hit debian-legal, methinks.

> 
> The hotplug interface can be used to handle this.
> 

Bah, more configuration. I want it to just _work_.


So, back to the question: what license for a binary firmware blob is 
GPL-compatible?

Simon.

