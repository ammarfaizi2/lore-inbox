Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbUCEHW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 02:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbUCEHW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 02:22:58 -0500
Received: from dsl-082-083-136-020.arcor-ip.net ([82.83.136.20]:60290 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S262024AbUCEHW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 02:22:56 -0500
Message-ID: <40482ACC.3070504@kubla.de>
Date: Fri, 05 Mar 2004 08:22:52 +0100
From: Dominik Kubla <dominik@kubla.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
References: <20040303000957.GA11755@kroah.com> <4046CE91.50701@kubla.de> <20040304184442.GH13907@kroah.com>
In-Reply-To: <20040304184442.GH13907@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Mar 04, 2004 at 07:37:05AM +0100, Dominik Kubla wrote:
> 
>>On Tue, Mar 02, 2004 at 04:09:57PM -0800, Greg KH wrote:
>>
>>>I've released the 021 version of udev.  It can be found at:
>>>	kernel.org/pub/linux/utils/kernel/hotplug/udev-021.tar.gz
>>
>>Nice work, but  I ran into a problem  on my Debian system and  i did use
>>the udev-019 permissions file for  Debian. What's the story here anyway?
> 
> 
> Debian has a "official" package.  I recommend you use that if you have a
> Debian system.

Hmm. Yes, i just tried it, but i am not impressed.  Somebody tried very 
hard to make the resulting /dev look like devfs instead of following 
devices.txt... Especially unconditionally using tmpfs for /dev is a
bad idea if the user wants/needs to use ACLs.

So i'll continue to work from your sources.

> 
>>I seem to be unable to assign group "cdrom" to my ATAPI DVD/CD-RW drive.
>>It appears to me that the permissions syntax is missing a possibility to
>>overide the owner/group based upon the class of the device.
> 
> 
> Permissions are based on the name of the device.
> 

Oh, i realized that. But my point is: shouldn't they be based on the 
CLASS of the device rather than the name? After all the names are 
changeable, but the class is not...

I checked the hotplug-devel archives and saw that somebody has already
posted a patch doing that. So i guess the question boils down to:
Will you accept it or not?

>>Is there a way to distinguish between CD-ROM, DVD-ROM and writers? It is
>>not unusual  these days to  have at least a  DVD-ROM and CD-Writer  in a
>>desktop system. If you look at the  latest offers from Dell you will see
>>that they tend to include a DVD-ROM  and a DVD+RW drive in at least some
>>configurations. So  it would  be nice  if udev would  be able  to create
>>links like "cdwriter", "dvd" and "dvdwriter" out of the box. (And assign
>>the appropriate group to the device nodes...)
> 
> 
> You can do that, just name them differently based on the type of device.
> Also, try providing a symlink to "cdrom" to not break what users are
> expecting.

Would you care to explain how to do it?

TIA,
   Dominik
