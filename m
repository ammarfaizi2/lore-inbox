Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVGGXGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVGGXGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 19:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGGXDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 19:03:53 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:17057 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S262235AbVGGXCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 19:02:07 -0400
Message-ID: <42CDB3F9.5010402@dresco.co.uk>
Date: Fri, 08 Jul 2005 00:00:09 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Shawn Starr <spstarr@sh0n.net>, hdaps-devel@lists.sourceforge.net,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <42C8D06C.2020608@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <200507071028.06765.spstarr@sh0n.net> <20050707150548.GD24401@suse.de>
In-Reply-To: <20050707150548.GD24401@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Rutherford-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Thu, Jul 07 2005, Shawn Starr wrote:
>  
>
>>Model: HTS548080M9AT00 (Hitachi)
>>Laptop: T42.
>>
>>segfault:/home/spstarr# ./a /dev/hda
>>head parked
>>
>>Seems to park, heard it click :)
>>    
>>
>
>Note on that - if the util says it parked, you can be very sure that it
>actually did as the drive actually returns that status outside of just
>completing the command.
>  
>
It's worth noting that you'll need the libata passthrough patch to make 
this work on a T43..

However, with this patch I'm getting the "head not parked 4c" message, 
but I can hear the click from the drive.. It takes around 350-400ms for 
the command to execute, but when repeated, it drops to around 5ms for a 
short while (with no audible clicking), before reverting to original 
behaviour after a few seconds.

The clicking and the variation in execution time lead me to think it is 
parking, but not being reported correctly?

Regards,
Jon,


______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
