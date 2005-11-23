Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVKWUcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVKWUcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVKWUcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:32:46 -0500
Received: from kirby.webscope.com ([204.141.84.57]:2184 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932377AbVKWUaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:30:09 -0500
Message-ID: <4384D0EC.5050709@linuxtv.org>
Date: Wed, 23 Nov 2005 15:28:28 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Johannes Stezenbach <js@linuxtv.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511231436.54136.gene.heskett@verizon.net> <4384C909.4040107@m1k.net> <200511231514.17157.gene.heskett@verizon.net>
In-Reply-To: <200511231514.17157.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Wednesday 23 November 2005 14:54, Michael Krufky wrote:
>  
>
>>Gene Heskett wrote:
>>    
>>
>>>On Wednesday 23 November 2005 14:17, Michael Krufky wrote:
>>>
>>>[...]
>>>
>>>>f it fixes Gene's problem (a quick glance at his emails suggests that
>>>>it does) then:
>>>>        
>>>>
>>>Read further Michael, it still takes a _cold_ reboot to 2.6.14.2 to
>>>fix it.
>>>      
>>>
>>I'm sorry -- I should have been clearer... It fixes the following error
>>message, correct?
>>
>>Gene Heskett wrote:
>>    
>>
>>>WARNING:/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-
>>>dvb .ko needs unknown symbol nxt200x_attach.
>>>      
>>>
>>About the cold reboot needed for 2.6.14.2, well, that is completely
>>unrelated...
>>
>>First, does the patch fix the unknown symbol error?  If so, then the
>>patch is correct.
>>    
>>
>Yes, it fixes that just fine.
>  
>
GREAT! ... So then Adrian's patch with my ACK should be applied, in 
addition to a similar patch for saa7134-dvb ...  I'd like to try Sam's 
method on my machine... if it works, then I will send in a new patch on 
Friday.

>>Moving on........
>>
>>Kirk Lapray wrote both OR51132 and NXT200X frontend modules (cc added)
>>...
>>
>>First off, Gene, I am still under the impression that both v4l and dvb
>>subsystems are broken under 2.6.15 due to the memory bugs... I don't
>>know if Hugh Dickins fixed those yet or not.
>>    
>>
>Neither do I.  But as a tv engineer with 50+ years of experience, the
>general appearance is if the antenna cable has been disconnected and
>held about 2" away from the f-59 connector when a hot reboot is done. 
>The audio in both cases sounds like its a station 300 miles away when
>the atmospherics are behaving themselves.
>  
>
More than likely, I would assume that the issue has something to do with 
some code inside nxt200x.c that makes some additional devices visible on 
the i2c bus... This should only affect devices that use nxt200x module, 
but perhaps there is something going on that is causing interference on 
the i2c bus of your card?  This is just a guess.... Results from your 
cvs test will show us some better information.

If you are successfully loading cx88-dvb WITHOUT nxt200x module (before 
the cold boot) then the above is not the case.

Meanwhile, I repeat, it is well-known that the media tree is broken in 
2.6.15 ... I think we'll get better results after Hugh Dickin's sends in 
another patch.  In the meantime, you can test the v4l + dvb code using 
the merge-trees build method on the cvs repositories.  (see below)

>>Please try to build merged v4l+dvb cvs trees against your 2.6.14.2
>>kernel, and tell me if you are having the same problems.  If you are
>>indeed having the same problem, then it confirms that something in the
>>nxt200x module is causing problems in the OR51132 module.
>>    
>>
>And how & where do I obtain that?
>
Link to wiki-howto on linuxtv.org provided below.

>>Kirk, are you able to use both modules together using both pcHDTV and
>>ATI HDTV Wonder PCI cx88 boards simultaneously without causing any
>>conflicts?
>>
>>Once again, Gene, please follow the tree-merge instructions located at:
>>
>>http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS
>>    
>>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

>I'll give this a shot and advise on the results.
>
>>Please let me know if the problem persists.  If the problem is gone,
>>then nxt200x is a red herring.
>>
>>Regards,
>>
>>Michael Krufky
>>    
>>
I'll keep my email open...

Thanks,

Michael Krufky
