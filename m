Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTDKWSH (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTDKWSH (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:18:07 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:47609 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261835AbTDKWSG (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:18:06 -0400
Message-ID: <3E9741FD.4080007@mvista.com>
Date: Fri, 11 Apr 2003 15:30:21 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com>
In-Reply-To: <20030411204329.GT1821@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "spec" that states this is a requirement, however, telecom 
customers require the elapsed time from the time they request the disk 
to be used, to the disk being usable by the operating system to be 20 msec.

Its even more helpful for their applications if the call that hotswap 
inserts blocks until the device is actually ready to use and available 
in the filesystem.  Another requirement of any system that attempts to 
replace devfs would be this capability (vs constantly checking for the 
device in the filesystem).

Greg KH wrote:

>On Fri, Apr 11, 2003 at 01:29:57PM -0700, Steven Dake wrote:
>  
>
>>It gets even worse, because performance of hotswap events on disk adds 
>>is critical and spawning processes is incredibly slow compared to the 
>>performance required by some telecom applications...
>>    
>>
>
>It's critical that we quick name this disk within X milliseconds after
>it has been added to the system?  What spec declares this?
>
>thanks,
>
>greg k-h
>
>
>
>  
>

