Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSBCGa6>; Sun, 3 Feb 2002 01:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSBCGa4>; Sun, 3 Feb 2002 01:30:56 -0500
Received: from mx3.fuse.net ([216.68.1.123]:54700 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S286207AbSBCGaf>;
	Sun, 3 Feb 2002 01:30:35 -0500
Message-ID: <3C5CD8FD.6@fuse.net>
Date: Sun, 03 Feb 2002 01:30:21 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Issues with 2.5.3-dj1
In-Reply-To: <3C5B5EC0.40503@fuse.net> <20020202055115.GA11359@kroah.com> <3C5B8C0D.8090009@fuse.net> <20020202133358.A5738@suse.de> <3C5C8CA2.9000103@fuse.net> <20020203062124.GA15134@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Sat, Feb 02, 2002 at 08:04:34PM -0500, Nathan wrote:
>
>>Dave Jones wrote:
>>
>>>On Sat, Feb 02, 2002 at 01:49:49AM -0500, Nathan wrote:
>>>
>>>>Alright... a 2.5.3 with no extras boots fine (with init=/bin/bash) and 
>>>>can load and unload hotplug several times without OOPSing.  So it 
>>>>appears to be something else.  Hope that helps.
>>>>
>>>Do you have driverfs mounted ? Can you try 2.5.3 + greg's
>>>USB driverfs patch ?
>>>
>>Unless driverfs is mounted by default or by something other than 
>>/etc/fstab, no I don't have it on.
>>
>
>It's internally mounted even if you don't physically mount the fs.
>
>>w/ Greg's USB driverfs patch : system proves to be stable.
>>   (though 2.5.3 sometimes looses my keyboard after a time?)
>>
>
>Is this a USB keyboard?  Are there any kernel log messages?
>
It's a regular AT keyboard... no, there are no kernel log messages 
dumped to the screen and I highly doubt any captured to any file because 
the only way out is to power down the system.  Searching kern.log, all I 
see is hotplug add NAME=AT commands, which is nothing unusual.  This 
"losing" only seems to happen after 2.5.2-dj6 (did not try -dj7).

But even 2.5.2-dj6 will lose my mouse... or rather, it will never see it 
to begin with.  It's a regular, bland, boring PS/2 mouse.

>>Raw -dj1:  explosion as above. [no ACPI (doesn't compile anyway), no 
>>preempt this time around, either.]
>>   (also lost my keyboard.  Odd.  Seems to be about 50% of the time 
>>with 2.5.3 + anything.)
>>
>
>Hm, input layer changes?
>
>Glad 2.5.3 is working for you :)
>
>Thanks for testing it with my driverfs patch.
>
>greg k-h
>


