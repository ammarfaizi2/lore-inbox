Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWEKIYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWEKIYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWEKIYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:24:32 -0400
Received: from 122.84-49-227.nextgentel.com ([84.49.227.122]:59900 "EHLO
	chewbacca.solo.net") by vger.kernel.org with ESMTP id S1030185AbWEKIYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:24:32 -0400
In-Reply-To: <20060511001646.GB27465@kroah.com>
References: <mailman.1146575400.25877.linux-kernel2news@redhat.com> <20060502202412.0d68150f.zaitcev@redhat.com> <20060511001646.GB27465@kroah.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <75791FC0-E133-4E5F-B468-9E9A2C474577@usit.uio.no>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Hans A Eide <haeide@usit.uio.no>
Subject: Re: [PATCH] block/ub.c: Increase number of partitions for usb storage
Date: Thu, 11 May 2006 10:24:07 +0200
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 11. mai. 2006, at 02:16, Greg KH wrote:

> On Tue, May 02, 2006 at 08:24:12PM -0700, Pete Zaitcev wrote:
>> On Tue, 2 May 2006 14:59:52 +0200, Hans A Eide  
>> <haeide@usit.uio.no> wrote:
>>
>>> I do backups to external USB storage and hit the 8 partitions limit
>>> of ub.c
>>> This could also be a problem for others (HFS+ formatted iPods?)
>>
>> It was a bad mistake in retrospect. I limited ub to 8 partitions
>> because I wanted to fit 26 devices into 8 bits of minor.
>>
>>> Any reason for not increasing the partitions limit to 16?
>>
>> Doing so would not be compatible for systems which do not run udevd.
>> Linus forbade such changes, and I agree. So, if we strongly needed
>> ub to go beyond 1+7 partitions, we would need some kind of a  
>> remapping
>> scheme. I have to discuss this with Greg or Harald. Making dis-
>> contiguous nodes is easy with mknod, but I do not know if udev
>> supports it.
>
> udev can handle it just fine, as it just looks at the sysfs "dev" file
> to get the major:minor numbers.  It knows nothing about "ranges" :)

I can confirm this in practice. Good magic :-)


Hans



--
+                                                                      +
     Hans A Eide, PhD.                  Senior Analyst, USIT
    haeide@usit.uio.no             University of Oslo, Norway
+                                                                      +


