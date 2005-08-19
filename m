Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVHSKHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVHSKHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 06:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVHSKHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 06:07:04 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:391 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S964891AbVHSKHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 06:07:01 -0400
Message-ID: <4305AECE.3020508@dresco.co.uk>
Date: Fri, 19 Aug 2005 11:05:02 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Pavel Machek <pavel@suse.cz>, Adam Goode <adam@evdebs.org>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <20050818204904.GE516@openzaurus.ucw.cz> <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu> <20050818213823.GA4275@elf.ucw.cz> <20050819063602.GD6273@suse.de>
In-Reply-To: <20050819063602.GD6273@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Pythagoras-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>Please make it "echo 1 > frozen", then userspace can do "echo 0 > frozen"
>>>>after five seconds.
>>>>        
>>>>
>>>What if the code to do "echo 0 > frozen" is swapped out to disk? ;)
>>>      
>>>
>>Emergency head parker needs to be pagelocked for other reasons. You do
>>not want to page it from disk while your notebook is in free fall.
>>    
>>
>
>It's still a very bad idea imho, what if the head parker daemon is
>killed for other reasons? The automatic timeout thawing the drive is
>much saner.
>  
>
For hard disk protection, I prefer the idea of the userspace code 
thawing the drive based on current accelerometer data, rather than 
simply waking up after x seconds (maybe you're running for a bus rather 
than falling off a table)...

To get the best of both worlds, could we maybe take a watchdog timer 
approach, and have the timeout reset by the userspace component 
periodically re-requesting freeze?

Regards,
Jon.


______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
