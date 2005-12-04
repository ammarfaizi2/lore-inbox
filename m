Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVLDVNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVLDVNF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 16:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVLDVNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 16:13:05 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:61637 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932287AbVLDVNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 16:13:04 -0500
Message-ID: <43935C29.3050602@m1k.net>
Date: Sun, 04 Dec 2005 16:14:17 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc5: off-line for a week
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org> <200512041034.14146.gene.heskett@verizon.net> <43933A8C.2090606@m1k.net> <200512041547.05151.gene.heskett@verizon.net>
In-Reply-To: <200512041547.05151.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Sunday 04 December 2005 13:50, Michael Krufky wrote:
>  
>
>>Gene Heskett wrote:
>>    
>>
>>>On Sunday 04 December 2005 01:03, Linus Torvalds wrote:
>>>      
>>>
>>>>There's a rc5 out there now, largely because I'm going to be out of
>>>>email contact for the next week, and while I wish people were
>>>>religiously testing all the nightly snapshots, the fact is, you guys
>>>>don't.
>>>>        
>>>>
>>>Ahh Linus, but sometimes we do!  In any case, rc5 is missing this
>>>patch, the  "v4l_ena_tda9887.patch" reproduced below:
>>>
>>>Index: linux/drivers/media/video/cx88/cx88-cards.c
>>>===================================================================
>>>RCS file:
>>>/cvs/video4linux/v4l-dvb/linux/drivers/media/video/cx88/cx88-cards.c,v
>>>retrieving revision 1.108
>>>diff -u -p -r1.108 cx88-cards.c
>>>--- linux/drivers/media/video/cx88/cx88-cards.c 25 Nov 2005 10:24:13
>>>-0000      1.108
>>>+++ linux/drivers/media/video/cx88/cx88-cards.c 1 Dec 2005 20:56:43
>>>-0000
>>>@@ -569,6 +569,7 @@ struct cx88_board cx88_boards[] = {
>>>               .radio_type     = UNSET,
>>>               .tuner_addr     = ADDR_UNSET,
>>>               .radio_addr     = ADDR_UNSET,
>>>+               .tda9887_conf   = TDA9887_PRESENT,
>>>               .input          = {{
>>>                       .type   = CX88_VMUX_TELEVISION,
>>>                       .vmux   = 0,
>>>----------
>>>So my pcHDTV-3000 card is once again disabled.
>>>      
>>>
>>NACK.
>>
>>Linus, Please DO NOT apply this as it is here... This same change above
>>had to also be applied to the FusionHDTV3 Gold-T ...
>>    
>>
>
>And several others if I read the threads here correctly.
>
>  
>
>>I've already
>>applied the appropriate changes to cvs, and Mauro told me that he has
>>mailed the patches to Andrew, although I do not see them here yet on
>>LKML ....
>>
>>I get the feeling you're not even close to releasing 2.6.15, so I'm
>>sure the bugfix that Gene is waiting for will make it over to your
>>tree soon, along with some other small v4l fixes that we had to make
>>in order to account for changes in -rc4.
>>
>>Gene, in the meantime, you can fix your situation without changing any
>>code by simply issuing the following command:
>>
>>modprobe tda9887
>>
>>Ta - da! Magic!
>>    
>>
>
>Before, or after, the "modprobe cx88-dvb" in my rc.local that loads it
>all, ask somewhat tongue in cheek, because I already rebuilt
>and rebooted to the fixed version.  It Just Works(TM) :-)  But I'll try
>that for rc6 if it doesn't work.
>
>  
>
>>Cheers,
>>
>>Michael Krufky
>>    
>>
>
>  
>
AFTER.

...but it's moot. Linus has already applied the correct fix from Mauro 
and I, 1st patch after -rc5:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e4f5c82a92c2a546a16af1614114eec19120e40a

:-)

Cheers,

-Mike
