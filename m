Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTDKWbM (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTDKWbL (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:31:11 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:64249 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261884AbTDKWbK (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:31:10 -0400
Message-ID: <3E974500.7050700@mvista.com>
Date: Fri, 11 Apr 2003 15:43:12 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
CC: Greg KH <greg@kroah.com>, "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com> <20030411223856.GI21726@marowsky-bree.de>
In-Reply-To: <20030411223856.GI21726@marowsky-bree.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lars Marowsky-Bree wrote:

>On 2003-04-11T15:30:21,
>   Steven Dake <sdake@mvista.com> said:
>
>  
>
>>There is no "spec" that states this is a requirement, however, telecom 
>>customers require the elapsed time from the time they request the disk 
>>to be used, to the disk being usable by the operating system to be 20 msec.
>>    
>>
>
>Heh. Yes, I've read that spec, and some of it involves some good crack smoking
>;-) The current Linux scheduler will make that rather hard for you, you'll
>need hard realtime for such guarantees.
>
Its quite easy to do if you are not dependent upon spawning an entire 
process to execute the insertion and creation even of the device node.

>
>  
>
>>Its even more helpful for their applications if the call that hotswap 
>>inserts blocks until the device is actually ready to use and available 
>>in the filesystem.  Another requirement of any system that attempts to 
>>replace devfs would be this capability (vs constantly checking for the 
>>device in the filesystem).
>>    
>>
>
>Uh. Can you please clarify?
>
>You want open(/dev/not_there_yet) to block until /dev/not_there_yet is
>inserted? But if it is not inserted, the device file does not exist yet, so
>the open() will simply return a ENOENT.
>
>The application (or a library, providing this capability you want) could
>interact with the hotplug subsystem to be notified when this device is
>inserted.
>
>
>Sincerely,
>    Lars Marowsky-Brée <lmb@suse.de>
>
>  
>

