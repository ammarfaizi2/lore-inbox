Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUANTXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUANTV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:21:27 -0500
Received: from [81.193.98.140] ([81.193.98.140]:31366 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S263370AbUANTU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:20:29 -0500
Message-ID: <4005971F.4020608@vgertech.com>
Date: Wed, 14 Jan 2004 19:23:11 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com> <20040114171527.GB5472@kroah.com> <40058086.5000106@nortelnetworks.com>
In-Reply-To: <40058086.5000106@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris!
Hi Greg!

Chris Friesen wrote:
> Greg KH wrote:
  >
>> Yeah, but what exactly would udev print out?  All of the sysfs files in
>> the device it found?  Would it print it out for every device that comes
>> through?  Or just for ones that no rule applied to?
> 
> 
> 
> Maybe for ones with a matching rule, you could print something like:
> 
> udev[1234]: new device found matching rule <blah>, creating device node 
> <nodename>
> 
> For ones that don't match any rules, you could dump out all the info:
> 
> udev[1234]: new device found with no matching rules, device info: blah blah
> 

This would be nice but I think that full info for every new hotplugged 
device is even better. It's only 1 line :-)

Lame people, like myself, will make this rule:

BUS="scsi", SYSFS_model="CD-Writer cd4f*", KERNEL="sr*", NAME="cdrw"

When I connect a second drive (same model) /udev/cdrw will be 
overwritten. So I'd want to check the logs, find some difference between 
the two and create a new entry "myfriends-cdrw".

(I know that NAME="cdrw%n" would work but that depends on the order you 
plug things).

Regards,
Nuno Silva

