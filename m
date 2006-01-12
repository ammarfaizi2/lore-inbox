Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWALPm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWALPm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWALPm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:42:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:44937 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751399AbWALPm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:42:56 -0500
Message-ID: <43C678F2.9090501@us.ibm.com>
Date: Thu, 12 Jan 2006 09:42:42 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Williamson <mark.williamson@cl.cam.ac.uk>
CC: xen-devel@lists.xensource.com, "Mike D. Day" <ncmike@us.ibm.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060112071000.GA32418@kroah.com> <43C66B56.8030801@us.ibm.com> <200601121453.39629.mark.williamson@cl.cam.ac.uk>
In-Reply-To: <200601121453.39629.mark.williamson@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Williamson wrote:

>>These will be text files with simple attrributes. Most will be
>>read-only. It is kind of fun to think about creating a domain by doing
>>something like
>>
>>cat $domain_config > /sys/xen/domain/new
>>
>>but there are some ugly aspects of doing so. Likewise it would be good
>>to add a potential migration host by writing an ip address to
>>/sys/xen/migrate/hosts_to
>>
>>Again, we need to get this solidified before going further.
>>    
>>
>
>Anthony (cc-ed) did a little work on implementing something like this using 
>FuSE to call the existing management interfaces we have for this 
>functionality.  IIRC, it was mostly targetted at reading information about 
>running domains, but it seemed like a good level to implement these 
>higher-level controls in a virtual FS.
>  
>
Yeah, I like this idea but I agree that sysfs is not the right place for 
it (it would requiring maintaining a kobject representation of domains 
in the kernel which is going to be painful).

A custom Xen filesystem is definitely the right approach (and even 
already exists :-)).

Regards,

Anthony Liguori

>Cheers,
>Mark
>  
>

