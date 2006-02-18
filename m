Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWBRQky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWBRQky (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWBRQky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:40:54 -0500
Received: from mail.tmr.com ([64.65.253.246]:44189 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932071AbWBRQkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:40:53 -0500
Message-ID: <43F74EE9.7070400@tmr.com>
Date: Sat, 18 Feb 2006 11:44:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "D. Hazelton" <dhazelton@enter.net>, mrmacman_g4@mac.com,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com> <43EC83EC.nailISD91HRFF@burner> <200602090737.47747.dhazelton@enter.net> <20060210130228.GA30256@infradead.org> <43F63846.80109@tmr.com> <20060217210107.GA20411@infradead.org>
In-Reply-To: <20060217210107.GA20411@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Fri, Feb 17, 2006 at 03:55:34PM -0500, Bill Davidsen wrote:
>  
>
>>Christoph Hellwig wrote:
>>
>>    
>>
>>>You can access SCSI CDs using /dev/sr* for burning CDs.  It's backed by 
>>>the
>>>same highlevel code as SG_IO on /dev/hd* while the lowerlevel handling is
>>>done transparently by the scsi midlayer, the same code used by /dev/sg* 
>>>for
>>>the below-blocklayer handling.
>>>
>>>      
>>>
>>This may be true if you create your own /dev entries, or are a udev guru 
>>and can get it to generate the right entries. And if you use ATAPI 
>>devices it works fine... But with Fedora and SuSE it appears that USB 
>>devices which appear as SCSI aren't functional. I tested the Fedora 
>>myself, and after killing udevd and making some entries by hand it 
>>worked once.
>>
>>Now if you can access SCSI burners more power to you, with FC4 up to 
>>recent updates, my one convenient real SCSI device most definitely 
>>doesn't work, and I havd to fall the system back to Slackware and 2.4 
>>which was on it before.
>>
>>Because you know how to get around the problems doesn't really suggest 
>>that there aren't any.
>>    
>>
>
>How are the dev entires related to CD burning?  If the device entries
>don't appear for you that's a problem, but you deserve what you get
>for using a POS like udev.  If you have a sd or sr node you can use
>SG_IO on it, period.  Whether you can actually burn a CD of course
>depends on the capability of the device.  I don't have a CD burner
>connected through usb, but I couldn't think of a reason the usb <-> atapi
>bridge would make problems with the scsi commands used to burn a CD.
>
>  
>
I'm sorry if I didn't make that clear. Some developers are saying that 
the application shouldn't be finding devices because udev does that so 
it doesn't matter that doing device location in the application is 
complex and poorly defined because udev does it for you. I was making 
the point that in the most common distributions (Fedora and SuSE) 
pluggable burners don't get proper entries in /dev to make cdrecord 
work. Based on a single report sent directly to me that seems to be the 
case in ubuntu as well, but I haven't personally tried it.

I was refuting the claim that applications no longer need to find their 
own devices; in many cases they do.

Burning using the USB devices works fine if the right devices are found 
and created.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

