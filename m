Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVBCIu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVBCIu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVBCIu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:50:56 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:33807 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262777AbVBCIuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:50:19 -0500
Message-ID: <4201E7DB.6030403@hist.no>
Date: Thu, 03 Feb 2005 09:59:07 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
CC: Greg KH <greg@kroah.com>, Pavel Roskin <proski@gnu.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Please open sysfs symbols to proprietary modules
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>	 <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net>	 <20050202232909.GA14607@kroah.com>	 <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>	 <20050203003010.GA15481@kroah.com> <1107406442.23059.16.camel@localhost>
In-Reply-To: <1107406442.23059.16.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx wrote:

>On Wed, 2005-02-02 at 16:30 -0800, Greg KH wrote:
>  
>
>>On Wed, Feb 02, 2005 at 07:07:21PM -0500, Pavel Roskin wrote:
>>    
>>
>>>On Wed, 2 Feb 2005, Greg KH wrote:
>>>      
>>>
>>>>On Wed, Feb 02, 2005 at 03:23:30PM -0800, Patrick Mochel wrote:
>>>>        
>>>>
>>>>>What is wrong with creating a (GPL'd) abstraction layer that exports
>>>>>symbols to the proprietary modules?
>>>>>          
>>>>>
>>>>Ick, no!
>>>>
>>>>Please consult with a lawyer before trying this.  I know a lot of them
>>>>consider doing this just as forbidden as marking your module
>>>>MODULE_LICENSE("GPL"); when it really isn't.
>>>>        
>>>>
>>>There will be a GPL'd layer, and it's likely that sysfs interaction will 
>>>be on the GPL'd side anyway, for purely technical reasons.  But it does 
>>>feel like circumvention of the limitations set in the kernel.
>>>      
>>>
>>It is.  And as such, it is not allowed.
>>    
>>
>[snip]
>
>So, what's the magic amount of redirection and abstraction that cleanses
>the GPLness, hmm?  Who gets to wave the magic wand to say what
>interfaces are GPL-to-non-GPL and which aren't?
>
>For example, the IDE drivers use GPL symbols but the VFS does not.  So
>anyone can write a proprietary filesystem which eventually gets around
>to driving the IDE layer.  That is okay, but this isn't?
>  
>
Well, it is ok because the proprietary FS in question does not
access anything in the IDE layer.  The VFS does not reexport
ide symbols and interfaces.  It is not a "workaround" for proprietary
fs'es - someone who writes proper GPL code cannot simply take a shortcut,
skip the VFS layer and have his GPL'ed fs drive the IDE layer directly.
He'd end up with a stupid fs this way, one with artifical limitations such
as being unable to work on SCSI too, and unable to cooperate
properly with the VFS.

If skipping some GPL glue layer is possible, technically convenient, 
better for
performance but unfortunately illegal, then that is a strong hint that
the glue layer itself may be an illegal circumvention device.  In some 
countries,
at least.  The VFS however, is not a mere glue layer, it is an important
subsystem of its own.  Sitting between block devices and filesystems
makes it a middle-man of course, but it is much more than that.

>If the trend of making everything _GPL continues, I don't see any choice
>for binary module vendors but to join together to develop a stable
>driver API and build it as a GPL/BSD module.  Do the same API for BSD
>systems to prove modules using it are not GPL derived.  Watch Greg foam.
>It'd be fun.
>
There is another alternative, which is to provide open drivers.  The 
money is
in pushing _hardware_, not drivers!  And linux users are more likely to buy
the hardware device with the open driver, rather than the device with the
proprietary driver.  So this is good for sales too.  See the recent thread
about a open hw graphichs card.  Lots of people got interested, because of
the "no secrets - *fully* documented" approach.
Nobody really needs to be a "binary vendor".

Helge Hafting




