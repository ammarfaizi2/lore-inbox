Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTDKT1M (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTDKT1M (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:27:12 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:19706 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261631AbTDKT1L (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:27:11 -0400
Message-ID: <3E9719C9.6090300@cox.net>
Date: Fri, 11 Apr 2003 12:38:49 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-hotplug-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411192827.GC31739@ca-server1.us.oracle.com>
In-Reply-To: <20030411192827.GC31739@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

> On Fri, Apr 11, 2003 at 11:31:28AM -0700, Kevin P. Fleming wrote:
> 
>>- if any partitions are found, they are registered with the kernel using 
>>device-mapper ioctls
>>- because these new "mapped sections" of the drive are _also_ usable block 
>>devices in their own right, they generate hotplug events
> 
> 
> 	In reality, we need /dev/disk0 for disks, and /dev/part0 for
> partitions, and /dev/lv0 for logical volumes from the LVM.  There's
> going to be a war over this naming, and that's why this is hard.
> 
> Joel
> 

No doubt. And then you get into the situation where the devices themselves have 
names and/or UUIDs, and you want that to be incorporated into the device name. 
As it stands today, the only way to achieve that is pass that information to 
device-mapper so it can create devices with those names.

Personally, I wouldn't be upset if _all_ "physical volumes" (meaning an 
accessible block devices or portion thereof) appeared under /dev/volume/... Even 
logical volumes could be done that way, since they have names as well. I don't 
really see the need to have "whole disks", "partitions" and other types of 
volumes in separate directories under /dev, but then I may be way off base with 
the rest of the world wants to do :-)


