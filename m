Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbTDKWUk (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTDKWUj (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:20:39 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:51961 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261848AbTDKWUh (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:20:37 -0400
Message-ID: <3E974299.3030701@mvista.com>
Date: Fri, 11 Apr 2003 15:32:57 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Lang <david.lang@digitalinsight.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Jeremy Jackson'" <jerj@coplanar.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <A46BBDB345A7D5118EC90002A5072C780BEBAA44@orsmsx116.jf.intel.com> <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com> <20030411205948.GV1821@kroah.com>
In-Reply-To: <20030411205948.GV1821@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Fri, Apr 11, 2003 at 01:48:17PM -0700, David Lang wrote:
>  
>
>>ant then you also have all the same problems as devfs about default
>>permissions, making permissions persistant across reboots, etc.
>>    
>>
>
>You can store the default permissions in the database you use to store
>the naming data.  This solves the reboot problem, as long as you can
>convince people to not modify the permissions on their own (well even if
>they do, at shutdown, you can always validate that they are the same
>before you clean up the node.)
>
>And provide an easy way for users to change the permissions so they show
>up in the database.
>
>devchmod and devchown anyone?  :)
>  
>
Greg,

I've been thinking of how to solve this particular problem, and believe 
you could use dnotify in a daemon to track permission and ownership 
changes and store them in a backing database.  In fact, we do something 
similiar to this today.  This allows the user to use any type of 
application for changing permissions/owners, even syscalls directly 
without having to go "through" any sort of tracking database.

>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

