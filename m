Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWALTLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWALTLQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWALTLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:11:16 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51143 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161189AbWALTLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:11:15 -0500
Message-ID: <43C6A9CE.9080105@us.ibm.com>
Date: Thu, 12 Jan 2006 14:11:10 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       Gerd Hoffmann <kraxel@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>	 <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de>	 <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de>	 <20060112173926.GD10513@kroah.com>  <43C6A5B4.80801@us.ibm.com> <1137092120.2936.55.camel@laptopd505.fenrus.org> <43C6A70D.8010902@us.ibm.com>
In-Reply-To: <43C6A70D.8010902@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
> Arjan van de Ven wrote:
> 
>> On Thu, 2006-01-12 at 12:53 -0600, Anthony Liguori wrote:
>>  
>>
>>> We wish to make management hypercalls as the root user in userspace 
>>> which means we have to go through the kernel.  Currently, we do this
>>> by having /proc/xen/privcmd accept an ioctl() that takes a structure
>>> that describe the register arguments.  The kernel interface allows us 
>>> to control who in userspace can execute hypercalls.
>>>   
>>
>> ioctls on proc is evil though (so is ioctl-on-sysfs). It's a device not
>> a proc file!
>>  
>>
> I full heartedly agree with you :-)

What about making hypercalls via with a read/write interface into memory 
mapped by a char device? Any problems with that approach?

Mike



-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
