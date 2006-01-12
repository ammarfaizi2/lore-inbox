Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWALOme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWALOme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWALOme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:42:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:62083 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030429AbWALOmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:42:33 -0500
Message-ID: <43C66ACC.60408@suse.de>
Date: Thu, 12 Jan 2006 15:42:20 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Mike D. Day" <ncmike@us.ibm.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>	 <43C5B59C.8050908@us.ibm.com>  <43C65196.8040402@suse.de> <1137072089.2936.29.camel@laptopd505.fenrus.org>
In-Reply-To: <1137072089.2936.29.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>   privcmd returns a filehandle which is then used 
>> for ioctls (misc char dev maybe?). 
> 
> 
> EWWWWWWWWWWWWWW
> 
> what is wrong with open() ?????
> things that return fd's that aren't open() (or dup and socket) are just
> evil. Esp if it's in proc or sysfs.

Nothing is wrong with open, but probably the sentense above is a bit too 
short.  If you call fd = open("/proc/xen/privcmd", ...) you'll get a 
filehandle returned for the thingy (as usual) and then you'll use that 
filehandle to call ioctl(fd, ...), so it's the usual unix way ...

cheers,

   Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
