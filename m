Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbTL1DUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTL1DUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:20:15 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:35214 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264941AbTL1DUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:20:09 -0500
Message-ID: <3FEE4BD9.5000000@why.dont.jablowme.net>
Date: Sat, 27 Dec 2003 22:19:53 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Love <rml@ximian.com>
Cc: Joshua Schmidlkofer <kernel@pacrimopen.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
References: <200312232342.17532.josh@stack.nl>	 <20031226233855.GA476@hh.idb.hist.no>  <3FECCAF9.7070209@maine.rr.com>	 <1072507896.27022.226.camel@menion.home>	 <3FEE47F5.6090406@why.dont.jablowme.net> <1072581073.4042.10.camel@fur>
In-Reply-To: <1072581073.4042.10.camel@fur>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Love wrote:
> On Sat, 2003-12-27 at 22:03, Jim Crilly wrote:
> 
> 
>>Generally it just complains that you pulled out the device prematurely, 
>>I've never seen one give a STOP error from that but I guess a bad driver 
>>or USB controller could cause anything.
> 
> 
> It would be pretty easy to screw things up if you pull out a device in
> the middle of use.
> 
> 
>>When you insert a device like a USB stick Windows puts a little icon 
>>next to the clock in the system tray that you're supposed to use to stop 
>>the device before pulling it, effectively it unmounts and stops (or 
>>atleast releases the device from) the driver so the device can be 
>>'safely' removed.
> 
> 
> This is useful, and something I think we need on the Linux desktop (stay
> tuned).
> 

I agree, that's one of the reasons I posted at all. Little things like 
this can make a big difference, even though I've seen a lot of users not 
notice the little icon and have to be told about it.

Maybe when the icon appears have a tool-tip that pops up and says 
something like "your USB device is ready for user at /mnt/usb, click 
here when you're done" or something like that to make it more noticable 
that they shouldn't just yank it.

But I seem to be getting OT for this list...

> 
>>I also believe Windows mounts any removable device 
>>synchronously so that if you do pull it out prematurely the damage done 
>>is limited.
> 
> 
> Eww, I hope not, that would be excruciatingly slow.  It might adjust the
> buffer writeback to be really short (even nearly immediate) but
> synchronous I/O is a different story, and much slower.
> 
> 	Rob Love
> 
> 

Perhaps synchronous was the wrong term =) But it does atleast seem to do 
less buffering for removable devices or I could just be fooled by 
something else slowing it down.
