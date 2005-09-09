Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVIIUrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVIIUrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbVIIUrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:47:47 -0400
Received: from mail-out1.fuse.net ([216.68.8.174]:30451 "EHLO smtp1.fuse.net")
	by vger.kernel.org with ESMTP id S1030329AbVIIUrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:47:47 -0400
Message-ID: <43214CEB.2070702@fuse.net>
Date: Fri, 09 Sep 2005 04:50:51 -0400
From: rob <rob.rice@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: swsusp
References: <431E97E5.1080506@fuse.net> <200509072201.13268.rjw@sisk.pl> <4321190E.2030804@fuse.net> <200509092035.29884.rjw@sisk.pl>
In-Reply-To: <200509092035.29884.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

>On Friday, 9 of September 2005 07:09, you wrote:
>  
>
>>Rafael J. Wysocki wrote:
>>
>>    
>>
>>>Hi,
>>>
>>>On Wednesday, 7 of September 2005 09:33, rob wrote:
>>> 
>>>
>>>      
>>>
>>>>I singed up to this mailing list just to ask this question
>>>>I have built a 2.6.13 kernel for a toshiba  tecra 500cdt
>>>>this computer uses the pci buss for the sound card
>>>>and pcmcia bridge
>>>>I have writen a script to unload all the pci buss modules amd go to sleep
>>>>it works up to this point
>>>>now how do I get the modules put back when ever I add the lines to
>>>>rerun the " /etc/rc.d/rc.hotplug /etc/rc.d/rc.pcmcia and 
>>>>/etc/rc.d/rcmodules "
>>>>I get a kernel crash befor it gose to sleep
>>>>I have been al over the net and the olny info I can find is about 
>>>>software suspend2
>>>>Is there some way to change the sowftware suspend2 scripts to work with the
>>>>unpatched kernel software suspend or where can I get the path to init
>>>>talked about in the menuconfig file
>>>>   
>>>>
>>>>        
>>>>
>>>Could you just try
>>>
>>># echo shutdown > /sys/power/disk && echo disk > /sys/power/state
>>>
>>>without unloading any modules and see what happens (it should suspend
>>>to disk)?
>>>
>>>If it craches, could you boot the kernel with the init=/bin/bash option and try
>>>
>>># mount /sys
>>># mount /proc
>>># /sbin/swapon -a
>>># echo shutdown > /sys/power/disk && echo disk > /sys/power/state
>>>
>>>and see what happens?
>>>
>>>Rafael
>>>
>>>
>>> 
>>>
>>>      
>>>
>>yes I did try this it just crashes and tacks out my file system with it
>>and I have to reinstall to recover from it it chops up files like bash
>>and every thing on the path the error codes scroll by so fast there is
>>no hope ov finding out what errors are tacking place
>>    
>>
>
>Then I guess your swap partition is on a logcal volume.  Is it?
>
>Rafael
>
>
>  
>
I sould have sed more than just where my syap parttion is
in linux2.6.13/Doucumentation /power/deviecs.txt it says
somethhing about pci bus devices causing problems
with just my sound card modules it just halts with an oops
with pcmcia modules loaded it eats the file system
with the pci bus mouldes unloaded ALL of them it suspends fine
and resumes just fine
this works I can live with this I dont mind that all the pci bus devices
have to be turned off and restarted after resume
what I need is a safe way to reload them
I tryed sleep 5 (this may have been too short ) then rerunning the /etc/rc.d
scripts to reload them it ate my file system
I have an extra file parttion with minum install and  a  tat.bz2 of a fresh
install to recover from  Note (all of this was done from a fresh install 
of slackware 10.1
