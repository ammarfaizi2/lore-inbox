Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWALSoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWALSoi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWALSoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:44:38 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:15748 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932652AbWALSoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:44:37 -0500
Message-ID: <43C6A383.80205@us.ibm.com>
Date: Thu, 12 Jan 2006 12:44:19 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Mike D. Day" <ncmike@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <20060112071000.GA32418@kroah.com> <43C66B56.8030801@us.ibm.com> <43C67C7E.3070909@us.ibm.com> <20060112173449.GB10513@kroah.com>
In-Reply-To: <20060112173449.GB10513@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, Jan 12, 2006 at 09:57:50AM -0600, Anthony Liguori wrote:
>  
>
>>Here's a list of the remaining things we current expose in /proc/xen 
>>that have no obvious place:
>>
>>1) capabilities (is the domain a management domain)
>>    
>>
>
>Is this just a single value or a bitfield?
>  
>
Right now it's a string that identifies the type of partition is it (for 
instance, "control_d" for the control domain).

>>2) xsd_mfn (a frame number for our bus so that userspace can connect to it)
>>    
>>
>
>Single number, right?
>  
>
Yup.

>>3) xsd_evtchn (a virtual IRQ for xen bus for userspace)
>>    
>>
>
>Again, single number?
>  
>
Yup.

>>I would think these would most obviously go under something like:
>>
>>/sys/hypervisor/xen/
>>
>>That would introduce a hypervisor subsystem.  There are at least a few 
>>hypervisors out there already so this isn't that bad of an idea 
>>(although perhaps it may belong somewhere else in the hierarchy).  Greg?
>>    
>>
>
>I would have no problem with /sys/hypervisor/xen/ as long as you play by
>the rest of the rules for sysfs (one value per file, no binary blobs
>being intrepreted by the kernel, etc.)
>  
>
Great, thanks!

Regards,

Anthony Liguori

>thanks,
>
>greg k-h
>
>  
>

