Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbTL1DD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTL1DD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:03:26 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:48809 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264931AbTL1DDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:03:24 -0500
Message-ID: <3FEE47F5.6090406@why.dont.jablowme.net>
Date: Sat, 27 Dec 2003 22:03:17 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
Cc: "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
References: <200312232342.17532.josh@stack.nl>	 <20031226233855.GA476@hh.idb.hist.no>  <3FECCAF9.7070209@maine.rr.com> <1072507896.27022.226.camel@menion.home>
In-Reply-To: <1072507896.27022.226.camel@menion.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Schmidlkofer wrote:

>On Fri, 2003-12-26 at 15:57, David B. Stevens wrote:
>  
>
>>While I agree that the kernel should provide decent error handling and 
>>reporting I still have to ask questions about what is reasonable.
>>
>>What does that other OS do when you pull a USB stick out?  What do you 
>>think the kernel should do?  Why don't the applications operating on the 
>>data take better care of handling error conditions?
>>
>>I don't have one here to try, but at some point the (ab)user needs to 
>>take a bit of the heat for his or her action(s) or lack thereof.
>>
>>After all you could just reach in your case and rip out the IDE or SCSI 
>>cables.  Bet that leads to all kinds of stuff (tm).
>>
>>Cheers,
>>  Dave
>>
>>
>>Helge Hafting wrote:
>>
>>    
>>
>>>On Tue, Dec 23, 2003 at 11:42:17PM +0100, Jos Hulzink wrote:
>>> 
>>>
>>>      
>>>
>>>>Hi,
>>>>
>>>>First of all... Compliments about 2.6.0. It is a superb kernel, with very few 
>>>>serious bugs, and for me it runs stable like a rock from the very first 
>>>>moment.
>>>>
>>>>As an end user, Linux doesn't give me a good feeling on one particular item 
>>>>yet: Error handling. 
>>>>
>>>>What do I mean ? Well... for example: Pull out your USB stick with a mounted 
>>>>fs on it. 
>>>>   
>>>>
>>>>        
>>>>
>>>You aren't supposed to do that.  If you want to pull devices like that,
>>>with no warning, access them in other ways than mounting.  
>>>mtools are nice when you don't want to mount/umount floppies - a
>>>similiar approach should work for usb sticks too.
>>>
>>>
>>>
>>>Helge Hafting
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>      
>>>
>
>Sometimes Windows 2k or XP dump (BSOD), or maybe you just get an error. 
>
>  
>
Generally it just complains that you pulled out the device prematurely, 
I've never seen one give a STOP error from that but I guess a bad driver 
or USB controller could cause anything.

When you insert a device like a USB stick Windows puts a little icon 
next to the clock in the system tray that you're supposed to use to stop 
the device before pulling it, effectively it unmounts and stops (or 
atleast releases the device from) the driver so the device can be 
'safely' removed. I also believe Windows mounts any removable device 
synchronously so that if you do pull it out prematurely the damage done 
is limited.

Jim.
